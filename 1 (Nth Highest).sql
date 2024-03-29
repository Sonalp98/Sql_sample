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
-- 2nd Highest
select * from employees2
where salary < (select max(salary) from employees2)
limit 1;
-- Nth highest use limit n-1 offset 1
select * from employees2
order by salary desc
limit 1 offset 1;
INSERT INTO employees2 (name, department, salary) VALUES ('Riya','IT',63000);
delete from employees2
where salary = 630000;
set sql_safe_updates =0;
select * from employees2;
-- Nth Highest
select * from (select *, dense_rank() over (order by salary desc) as rn
from employees2) b
where rn = 2;
-- Your Task 

-- Question: Get the details of the employee with the second-highest salary from each department
select * from (select *, dense_rank() over ( partition by department order by salary desc) rn
from employees2) b
where rn =2;
-- select * from table_name order by column desc limit n-1,1; For 3rd highest use n=3
select * from employees2
order by salary desc
limit 1,1;
-- nth highest
select min(salary)
from ( select * from employees2
order by salary desc 
limit 2) a;
-- nth Highest
select * from (select * from employees2
order by salary desc 
limit 2) a
order by salary 
limit 1;
-- 2nd Highest
select max(salary) from employees2
where salary not in( select max(salary) from employees2);
-- 2nd Hightest
select e1.salary from employees2 e1
join employees2 e2
on e1.salary < e2.salary
group by e1.salary
order by e1.salary desc
limit 1;
---- For n highest salary use (where n-1)
select * from employees2 A
where 3 = ( select count(1) from employees2 B where B.salary > A.salary);

-- Explanation to last query

| Name  | Salary |
|-------|--------|
| Alice | 3000   |
| Bob   | 3500   |
| Carl  | 4000   |
| Dave  | 4500   |

Your query is:

sql
SELECT name, salary
FROM employee A
WHERE 3 = (SELECT count(1) 
           FROM employee B 
           WHERE B.salary > A.salary)


This query selects the name and salary from the "employee" table (aliased as "A") where the count of employees with a salary higher than each individual employee's salary is equal to 3.

Let's break it down:

1. *Alice (Salary: 3000)*:
   - The inner query counts how many employees have a higher salary than Alice's salary (3000). There are 3 employees (Bob, Carl, and Dave) with a higher salary. So, Alice meets the condition.

2. *Bob (Salary: 3500)*:
   - The inner query counts how many employees have a higher salary than Bob's salary (3500). There are 2 employees (Carl and Dave) with a higher salary. So, Bob does not meet the condition.

3. *Carl (Salary: 4000)*:
   - The inner query counts how many employees have a higher salary than Carl's salary (4000). There is only 1 employee (Dave) with a higher salary. So, Carl does not meet the condition.

4. *Dave (Salary: 4500)*:
   - The inner query counts how many employees have a higher salary than Dave's salary (4500). There are no employees with a higher salary. So, Dave does not meet the condition.

Therefore, only Alice meets the condition specified in the query. The final output of the query would be the row corresponding to Alice:

| Name  | Salary |
|-------|--------|
| Alice | 3000   |

I hope this explanation clarifies your query!

