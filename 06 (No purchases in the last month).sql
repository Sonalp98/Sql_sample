DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id INT,
    name VARCHAR(100),
    email VARCHAR(100)
);


DROP TABLE IF EXISTS orders3;
CREATE TABLE orders3 (
    order_id INT ,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10, 2)
);



-- Inserting sample customers
INSERT INTO customers (customer_id, name, email) VALUES
(1, 'John Doe', 'john@example.com'),
(2, 'Jane Smith', 'jane@example.com'),
(3, 'Alice Johnson', 'alice@example.com'),
(4, 'Sam B', 'sb@example.com'),
(5, 'John Smith', 'j@example.com')	
;

-- Inserting sample orders
INSERT INTO orders3 (order_id, customer_id, order_date, amount) VALUES
(1, 1, '2024-03-05', 50.00),
(2, 2, '2024-03-10', 75.00),
(5, 4, '2024-04-02', 45.00),
(5, 2, '2024-04-02', 45.00)	,
(3, 4, '2024-04-15', 100.00),
(4, 1, '2024-04-01', 60.00),
(5, 5, '2024-04-02', 45.00);







/*
Given tables customers (columns: customer_id, 
name, email) and orders (columns: order_id, 
customer_id, order_date, amount), 

Write an SQL query to find customers who 
haven't made any purchases in the last month, 
assuming today's date is April 2, 2024. 
*/

-- customers details 
-- who has not done purchase in last month (orders)


SELECT * FROM customers;
SELECT * FROM orders3;
-- This query won't work beacause the join will restrict output from customer table -- 
select * from customers c
left join orders3 o
on c.customer_id = o.customer_id
where order_date not between '2024-02-29' and '2024-04-01' ;
-- 1 This will work 
select * from customers c
where customer_id not in (
select customer_id from orders3 
where order_date between '2024-02-29' and '2024-04-01') ;

-- 2
select * from customers
where customer_id not in ( 
select customer_id from 
orders3 
where extract(month from order_date) = extract(month from current_date)-1
and
extract(year from order_date) = extract(year from current_date)) ;
---

 



