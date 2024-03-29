CREATE TABLE employees2 (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);

-- Insert records for three departments
INSERT INTO employees2 (name, department, salary) VALUES 
('John Doe', 'Engineering', 63000),
('Jane Smith', 'Engineering', 55000),
('Michael Johnson', 'Engineering', 64000),
('Emily Davis', 'Marketing', 58000),
('Chris Brown', 'Marketing', 56000),
('Emma Wilson', 'Marketing', 59000),
('Alex Lee', 'Sales', 58000),
('Sarah Adams', 'Sales', 58000),
('Ryan Clark', 'Sales', 61000);


/*

Write the SQL query to find the second highest salary */
select * from employees2;
select * from employees2
where salary < (select max(salary) from employees2)
limit 1;
select * from employees2
order by salary desc
limit 1 offset 1;
INSERT INTO employees2 (name, department, salary) VALUES ('Riya','IT',63000);
delete from employees2
where salary = 630000;
set sql_safe_updates =0;
select * from employees2;

select * from (select *, dense_rank() over (order by salary desc) as rn
from employees2) b
where rn = 2;
-- Your Task 

-- Question: Get the details of the employee with the second-highest salary from each department
select * from (select *, dense_rank() over ( partition by department order by salary desc) rn
from employees2) b
where rn =2;
