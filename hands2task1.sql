INSERT INTO students (first_name, last_name, email, date_of_birth, department_id, enrollment_year)
VALUES
('Rahul', 'Sharma', 'rahul.sharma@college.edu', '2003-06-10', 1, 2022),
('Anjali', 'Reddy', 'anjali.reddy@college.edu', '2004-02-18', 2, 2023);



SELECT COUNT(*) AS Total_Students FROM students;



UPDATE enrollments
SET grade='B'
WHERE student_id=5
AND course_id=1;


SELECT *
FROM enrollments
WHERE student_id=5
AND course_id=1;


SELECT *
FROM enrollments
WHERE grade IS NULL;


DELETE FROM enrollments
WHERE grade IS NULL;


SELECT COUNT(*) AS Student_Count
FROM students;

SELECT COUNT(*) AS Enrollment_Count
FROM enrollments;



SELECT *
FROM students
WHERE enrollment_year=2022
ORDER BY last_name ASC;


SELECT *
FROM courses
WHERE credits>3
ORDER BY credits DESC;

SELECT *
FROM professors
WHERE salary BETWEEN 80000 AND 95000;

SELECT *
FROM students
WHERE email LIKE '%@college.edu';


SELECT enrollment_year,
COUNT(*) AS Total_Students
FROM students
GROUP BY enrollment_year;



SELECT CONCAT(s.first_name,' ',s.last_name) AS Student_Name,
d.dept_name AS Department
FROM students s
INNER JOIN departments d
ON s.department_id=d.department_id;



SELECT CONCAT(s.first_name,' ',s.last_name) AS Student_Name,
c.course_name
FROM enrollments e
INNER JOIN students s
ON e.student_id=s.student_id
INNER JOIN courses c
ON e.course_id=c.course_id;


SELECT s.student_id, CONCAT(s.first_name,' ',s.last_name) AS Student_Name
FROM students s
LEFT JOIN enrollments e
ON s.student_id=e.student_id
WHERE e.student_id IS NULL;


SELECT c.course_name, COUNT(e.student_id) AS Enrollment_Count
FROM courses c
LEFT JOIN enrollments e
ON c.course_id=e.course_id
GROUP BY c.course_id,c.course_name;



SELECT d.dept_name, p.prof_name, p.salary FROM departments d LEFT JOIN professors p ON d.department_id=p.department_id;


SELECT c.course_name, COUNT(e.student_id) AS Enrollment_Count FROM courses c LEFT JOIN enrollments e ON c.course_id=e.course_id GROUP BY c.course_name;


SELECT d.dept_name, ROUND(AVG(p.salary),2) AS Average_Salary
FROM departments d LEFT JOIN professors p ON d.department_id=p.department_id
GROUP BY d.dept_name;



SELECT dept_name, budget FROM departments WHERE budget>600000;



SELECT grade, COUNT(*) AS Grade_Count FROM enrollments e INNER JOIN courses c ON e.course_id=c.course_id WHERE c.course_code='CS101' GROUP BY grade;


SELECT d.dept_name, COUNT(e.student_id) AS Total_Enrollments FROM departments d INNER JOIN students s ON d.department_id=s.department_id
INNER JOIN enrollments e ON s.student_id=e.student_id GROUP BY d.dept_name HAVING COUNT(e.student_id)>2;