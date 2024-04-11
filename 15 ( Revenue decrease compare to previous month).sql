-- Day 15/50 SQL Challenge 


-- Creating the orders table
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2)
);

-- Inserting records for the current month
INSERT INTO orders (order_date, product_id, quantity, price) VALUES
    ('2024-04-01', 1, 10, 50.00),
    ('2024-04-02', 2, 8, 40.00),
    ('2024-04-03', 3, 15, 30.00),
    ('2024-04-04', 4, 12, 25.00),
    ('2024-04-05', 5, 5, 60.00),
    ('2024-04-06', 6, 20, 20.00),
    ('2024-04-07', 7, 18, 35.00),
    ('2024-04-08', 8, 14, 45.00),
    ('2024-04-09', 1, 10, 50.00),
    ('2024-04-10', 2, 8, 40.00);

-- Inserting records for the last month
INSERT INTO orders (order_date, product_id, quantity, price) VALUES
    ('2024-03-01', 1, 12, 50.00),
    ('2024-03-02', 2, 10, 40.00),
    ('2024-03-03', 3, 18, 30.00),
    ('2024-03-04', 4, 14, 25.00),
    ('2024-03-05', 5, 7, 60.00),
    ('2024-03-06', 6, 22, 20.00),
    ('2024-03-07', 7, 20, 35.00),
    ('2024-03-08', 8, 16, 45.00),
    ('2024-03-09', 1, 12, 50.00),
    ('2024-03-10', 2, 10, 40.00);

-- Inserting records for the previous month
INSERT INTO orders (order_date, product_id, quantity, price) VALUES
    ('2024-02-01', 1, 15, 50.00),
    ('2024-02-02', 2, 12, 40.00),
    ('2024-02-03', 3, 20, 30.00),
    ('2024-02-04', 4, 16, 25.00),
    ('2024-02-05', 5, 9, 60.00),
    ('2024-02-06', 6, 25, 20.00),
    ('2024-02-07', 7, 22, 35.00),
    ('2024-02-08', 8, 18, 45.00),
    ('2024-02-09', 1, 15, 50.00),
    ('2024-02-10', 2, 12, 40.00);



/*

Write an SQL query to retrieve the product details for items whose revenue 
decreased compared to the previous month. 

Display the product ID, quantity sold, 
and revenue for both the current and previous months.
select * from orders;
with cte as(
select product_id, 
sum(quantity) as total_quantity,
sum(quantity*price) as total_revenue
from orders 
where month(order_date) = month(current_date)
group by product_id),
cte2 as(
select product_id, 
sum(quantity) as total_quantity,
sum(quantity*price) as total_revenue
from orders 
where month(order_date) = month(current_date)-1
group by product_id)
select cte.product_id,
cte.total_quantity as curr_quantity,
cte2.total_quantity as prev_quantity,
cte.total_revenue as curr_revenue,
cte2.total_revenue as prev_revenue
from cte
join cte2
on cte.product_id = cte2.product_id
where cte.total_revenue < cte2.total_revenue;
--- same ans
WITH current_month_revenue
AS
(    
    SELECT
        product_id,
        SUM(quantity) as qty_sold,
        SUM(price * quantity) as current_month_rev
    FROM orders
    WHERE EXTRACT(MONTH FROM order_date) = EXTRACT(MONTH FROM CURRENT_DATE) 
    GROUP BY product_id
),
prev_month_revenue
AS    
(
    SELECT
        product_id,
        SUM(quantity) as qty_sold,
        SUM(price * quantity) as prev_month_rev
    FROM orders
    WHERE EXTRACT(MONTH FROM order_date) = EXTRACT(MONTH FROM CURRENT_DATE)-1 
    GROUP BY product_id
)

SELECT
    cr.product_id,
    cr.qty_sold as cr_month_qty,
     pr.qty_sold as pr_month_qty,
    cr.current_month_rev,
    pr.prev_month_rev
FROM current_month_revenue as cr
JOIN 
prev_month_revenue as pr
ON cr.product_id = pr.product_id
WHERE cr.current_month_rev < pr.prev_month_rev
