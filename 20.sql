-- Day 20/50 Days SQL Challenge


DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(100),
    supplier_name VARCHAR(50)
);

INSERT INTO products (product_id, product_name, supplier_name) VALUES
    (1, 'Product 1', 'Supplier A'),
    (1, 'Product 1', 'Supplier B'),
    (3, 'Product 3', 'Supplier A'),
    (3, 'Product 3', 'Supplier A'),
    (5, 'Product 5', 'Supplier A'),
    (5, 'Product 5', 'Supplier B'),
    (7, 'Product 7', 'Supplier C'),
    (8, 'Product 8', 'Supplier A'),
    (7, 'Product 7', 'Supplier B'),
    (7, 'Product 7', 'Supplier A'),
    (9, 'Product 9', 'Supplier B'),
    (9, 'Product 9', 'Supplier C'),
    (10, 'Product 10', 'Supplier C'),
    (11, 'Product 11', 'Supplier C'),
    (10, 'Product 10', 'Supplier A')
    
    ;

/*
-- Write a query to find products that are sold by 
both Supplier A and Supplier B, 
excluding products sold by only one supplier.

*/

-- product_id, product_name
-- sold by supplier a and B where
With cte as(select product_id, product_name from products
where supplier_name = "Supplier A" 
group by product_id, product_name, supplier_name),
cte2 as(
select product_id, product_name from products
where supplier_name = "Supplier B" 
group by product_id, product_name, supplier_name)
select c.product_id, c.product_name from cte c
inner join cte2 c2
on c.product_id = c2.product_id;
select product_id, product_name, count(distinct supplier_name) as cnt
from products
where supplier_name in ( "Supplier A", "Supplier B")
group by product_id, product_name
having cnt =2;
