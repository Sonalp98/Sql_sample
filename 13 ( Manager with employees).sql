-- SQL Challenge Day 13/50

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    manager_id INT
    
);

INSERT INTO employees (emp_id, name, manager_id) VALUES
(1, 'John Doe', NULL),        -- John Doe is not a manager
(2, 'Jane Smith', 1),          -- Jane Smith's manager is John Doe
(3, 'Alice Johnson', 1),       -- Alice Johnson's manager is John Doe
(4, 'Bob Brown', 3),           -- Bob Brown's manager is Alice Johnson
(5, 'Emily White', NULL),      -- Emily White is not a manager
(6, 'Michael Lee', 3),         -- Michael Lee's manager is Alice Johnson
(7, 'David Clark', NULL),      -- David Clark is not a manager
(8, 'Sarah Davis', 2),         -- Sarah Davis's manager is Jane Smith
(9, 'Kevin Wilson', 2),        -- Kevin Wilson's manager is Jane Smith
(10, 'Laura Martinez', 4);     -- Laura Martinez's manager is Bob Brown


/*
You have a table named employees containing information about employees, 
including their emp_id, name, and manager_id. 
The manager_id refers to the emp_id of the employee's manager.


write a SQL query to retrieve all employees' 
details along with their manager's names based on the manager ID

*/
-- The first query pairs each employee with their manager.
select e1.*, e2.name from employees e1
cross join employees e2
on  e1.manager_id= e2.emp_id;
SELECT * FROM employees;
-- The second query pairs each manager with their subordinate(s).
select e1.*, e2.name from employees e1
cross join employees e2
on  e1.emp_id=e2.manager_id;












-- -----------
-- My Solution
-- -----------