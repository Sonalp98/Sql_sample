-- Day 05/30 SQL Challenge 



DROP TABLE IF EXISTS Employees;
-- Create the Employee table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

-- Insert sample records into the Employee table
INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
(101, 'John Smith', 'Sales', 60000.00, '2022-01-15'),
(102, 'Jane Doe', 'Marketing', 55000.00, '2022-02-20'),
(103, 'Michael Johnson', 'Finance', 70000.00, '2021-12-10'),
(104, 'Emily Brown', 'Sales', 62000.00, '2022-03-05'),
(106, 'Sam Brown', 'IT', 62000.00, '2022-03-05'),	
(105, 'Chris Wilson', 'Marketing', 58000.00, '2022-01-30');


/*

Write a SQL query to retrieve the 
third highest salary from the Employee table.

*/
select * from employees;
-- Due to 2nd highest salary appearing twice this query will give it as 3rd highest salary
select *
from employees
order by salary desc
limit 2,1;

select * from (
select *,dense_rank() over(order by salary desc) as rn
from employees) subquery
where rn = 3;
-- In each department
select * from (
select *,dense_rank() over(partition by department order by salary desc) as rn
from employees) subquery
where rn = 3;