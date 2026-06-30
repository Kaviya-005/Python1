import mysql.connector

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="kaviya005",
    database="college_db"
)

cursor = conn.cursor()
print("Connected Successfully")




import mysql.connector
import time
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="kaviya005",
    database="college_db"
)
cursor = conn.cursor()
start=time.time()
query_count=1
cursor.execute("SELECT * FROM enrollments")
enrollments=cursor.fetchall()
for row in enrollments:
    student_id=row[1]
    cursor.execute(
        "SELECT first_name,last_name FROM students WHERE student_id=%s",
        (student_id,)
    )
    student=cursor.fetchone()
    print(student)
    query_count+=1
end=time.time()
print("Queries Executed :",query_count)
print("Execution Time :",end-start)




import mysql.connector
import time
conn=mysql.connector.connect(
    host="localhost",
    user="root",
    password="YOUR_PASSWORD",
    database="college_db"
)
cursor=conn.cursor()
start=time.time()
cursor.execute("""
SELECT
s.first_name,
s.last_name,
c.course_name

FROM enrollments e

JOIN students s
ON e.student_id=s.student_id

JOIN courses c
ON e.course_id=c.course_id
""")
rows=cursor.fetchall()

for row in rows:
    print(row)
end=time.time()
print("Queries Executed : 1")
print("Execution Time :",end-start)




import time
start=time.time()
...
end=time.time()
print(end-start)


