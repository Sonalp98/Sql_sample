-- Day 35/50 SQL Challenge

DROP TABLE IF EXISTS Students;
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    marks INT,
    class VARCHAR(10)
);


INSERT INTO Students (student_id, student_name, marks, class) VALUES
(1, 'John Doe', 85, 'A'),
(2, 'Jane Smith', 92, 'B'),
(3, 'Michael Johnson', 78, 'A'),
(4, 'Emily Brown', 59, 'C'),
(5, 'David Lee', 88, 'B'),
(6, 'Sarah Wilson', 59, 'A'),
(7, 'Daniel Taylor', 90, 'C'),
(8, 'Emma Martinez', 79, 'B'),
(9, 'Christopher Anderson', 87, 'A'),
(10, 'Olivia Garcia', 91, 'C'),
(11, 'James Rodriguez', 83, 'B'),
(12, 'Sophia Hernandez', 94, 'A'),
(13, 'Matthew Martinez', 76, 'C'),
(14, 'Isabella Lopez', 89, 'B'),
(15, 'Ethan Gonzalez', 80, 'A'),
(16, 'Amelia Perez', 93, 'C'),
(17, 'Alexander Torres', 77, 'B'),
(18, 'Mia Flores', 86, 'A'),
(19, 'William Sanchez', 84, 'C'),
(20, 'Ava Ramirez', 97, 'B'),
(21, 'Daniel Taylor', 75, 'A'),
(22, 'Chloe Cruz', 98, 'C'),
(23, 'Benjamin Ortiz', 89, 'B'),
(24, 'Harper Reyes', 99, 'A'),
(25, 'Ryan Stewart', 99, 'C');



/*
Data Analyst Interview Questions 

You have a students table with columns
id, name, marks and class of students

-- Write a query to fetch students
with minmum marks and maximum marks 


*/
with cte as(select class, max(marks) as max,min(marks) as min from students
group by class)
select cte.class,max,min,
max(case when marks= max then student_name else null end )as max_name,
max(case when marks= min then student_name else null end )as min_name
from cte
left join students s 
on cte.class = s.class 
group by cte.class,max,min;
with cte as(select *, row_number() over(partition by class order by marks desc) as max,
row_number() over(partition by class order by marks) as min
from students)
select class,
max(case when max=1 then student_name else null end )as max_name,
max(case when min=1 then student_name else null end )as min_name
from cte
group by class;