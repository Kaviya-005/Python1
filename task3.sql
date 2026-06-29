ALTER TABLE students ADD phone_number VARCHAR(15);

DESC students;

ALTER TABLE courses ADD max_seats INT DEFAULT 60;

DESC courses;

ALTER TABLE enrollments ADD CONSTRAINT chk_grade  CHECK (grade IN ('A','B','C','D','F') OR grade IS NULL);

SHOW CREATE TABLE enrollments;


ALTER TABLE departments RENAME COLUMN hod_name TO head_of_dept;


ALTER TABLE departments CHANGE hod_name head_of_dept VARCHAR(100);


DESC departments;


ALTER TABLE students DROP COLUMN phone_number;


DESC students;

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'college_db'
AND TABLE_NAME = 'courses';


SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'college_db'
AND TABLE_NAME = 'departments';



SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'college_db'
AND TABLE_NAME = 'students';