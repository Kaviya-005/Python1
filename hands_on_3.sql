SELECT s.student_id, CONCAT(s.first_name,' ',s.last_name) AS student_name FROM students s JOIN enrollments e ON s.student_id=e.student_id
GROUP BY s.student_id,s.first_name,s.last_name HAVING COUNT(e.course_id) >
(SELECT AVG(course_count) FROM ( SELECT COUNT(*) AS course_count FROM enrollments GROUP BY student_id) AS avg_table);


SELECT c.course_name FROM courses c WHERE NOT EXISTS ( SELECT * FROM enrollments e WHERE e.course_id=c.course_id AND e.grade<>'A');

SELECT p.* FROM professors p WHERE salary= (SELECT MAX(salary) FROM professors p2 WHERE p.department_id=p2.department_id);


SELECT * FROM (SELECT d.dept_name,AVG(p.salary) AS avg_salary FROM departments d JOIN professors p ON d.department_id=p.department_id 
GROUP BY d.dept_name) AS dept_salary WHERE avg_salary>85000;

CREATE VIEW vw_student_enrollment_summary AS

SELECT
s.student_id,
CONCAT(s.first_name,' ',s.last_name) AS student_name,
d.dept_name,
COUNT(e.course_id) AS total_courses,ROUND(AVG(CASE
WHEN grade='A' THEN 4
WHEN grade='B' THEN 3
WHEN grade='C' THEN 2
WHEN grade='D' THEN 1
WHEN grade='F' THEN 0
END),2) AS GPA FROM students s LEFT JOIN departments d ON s.department_id=d.department_id LEFT JOIN enrollments e ON s.student_id=e.student_id
GROUP BY s.student_id, student_name, d.dept_name;


CREATE VIEW vw_course_stats AS SELECT c.course_name,c.course_code,COUNT(e.student_id) AS total_enrollments, ROUND(AVG(
CASE
WHEN grade='A' THEN 4
WHEN grade='B' THEN 3
WHEN grade='C' THEN 2
WHEN grade='D' THEN 1
WHEN grade='F' THEN 0
END
),2
) AS avg_gpa FROM courses c LEFT JOIN enrollments e ON c.course_id=e.course_id
GROUP BY c.course_name,c.course_code;


UPDATE vw_student_enrollment_summar SET GPA=4 WHERE student_id=1;


DROP VIEW IF EXISTS vw_student_enrollment_summary;
DROP VIEW IF EXISTS vw_course_stats;

CREATE VIEW vw_student_enrollment_summary AS SELECT student_id, first_name, last_name, department_id FROM students WHERE department_id=1 
WITH CHECK OPTION;




DELIMITER $$
CREATE PROCEDURE sp_enroll_student
(
IN p_student_id INT,
IN p_course_id INT,
IN p_date DATE
)
BEGIN
IF EXISTS
(
SELECT *
FROM enrollments
WHERE student_id=p_student_id
AND course_id=p_course_id
)
THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Student already enrolled';
ELSE
INSERT INTO enrollments
(student_id,course_id,enrollment_date)
VALUES
(p_student_id,p_course_id,p_date);
END IF;
END$$
DELIMITER ;




CREATE TABLE department_transfer_log
(
log_id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT,
old_department INT,
new_department INT,
transfer_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
DELIMITER $$
CREATE PROCEDURE sp_transfer_student
(
IN p_student INT,
IN p_new_department INT
)
BEGIN
DECLARE old_dept INT;
START TRANSACTION;
SELECT department_id
INTO old_dept
FROM students
WHERE student_id=p_student;
UPDATE students
SET department_id=p_new_department
WHERE student_id=p_student;
INSERT INTO department_transfer_log
(student_id,old_department,new_department)
VALUES
(p_student,old_dept,p_new_department);
COMMIT;
END$$
DELIMITER ;


START TRANSACTION;
UPDATE students
SET department_id=99
WHERE student_id=1;
ROLLBACK;


START TRANSACTION;
INSERT INTO enrollments (student_id,course_id,enrollment_date) VALUES (2,2,CURDATE());
SAVEPOINT sp1;
INSERT INTO enrollments (student_id,course_id,enrollment_date) VALUES (999,2,CURDATE());
ROLLBACK TO sp1;
COMMIT;