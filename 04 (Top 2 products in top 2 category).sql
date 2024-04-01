-- Day 04/50 


DROP TABLE IF EXISTS ORDERS;
create table orders1(
  	category varchar(20),
	product varchar(20),
	user_id int , 
  	spend int,
  	transaction_date DATE
);

Insert into orders1 values
('appliance','refrigerator',165,246.00,'2021/12/26'),
('appliance','refrigerator',123,299.99,'2022/03/02'),
('appliance','washingmachine',123,219.80,'2022/03/02'),
('electronics','vacuum',178,152.00,'2022/04/05'),
('electronics','wirelessheadset',156,	249.90,'2022/07/08'),
('electronics','TV',145,189.00,'2022/07/15'),
('Television','TV',165,129.00,'2022/07/15'),
('Television','TV',163,129.00,'2022/07/15'),
('Television','TV',141,129.00,'2022/07/15'),
('toys','Ben10',145,189.00,'2022/07/15'),
('toys','Ben10',145,189.00,'2022/07/15'),
('toys','yoyo',165,129.00,'2022/07/15'),
('toys','yoyo',163,129.00,'2022/07/15'),
('toys','yoyo',141,129.00,'2022/07/15'),
('toys','yoyo',145,189.00,'2022/07/15'),
('electronics','vacuum',145,189.00,'2022/07/15');



/*
Find the top 2 products in the top 2 categories based on spend amount?
*/
-- top 2 category based on spend 
-- top 2 product in above best 2 category
SELECT * FROM orders1;
--
with cte as (
select category, total_sepnd_category from 
(select category, sum(spend) as total_sepnd_category,
dense_rank() over(order by sum(spend)) as rn1
from orders1
group by category) subquery1
where rn1 <=2
)
select category, product, total_spend_product from (
select o.category, o.product, sum(o.spend) as total_spend_product,
dense_rank() over( partition by o.category order by sum(o.spend) desc) as rn
from orders1 o
join cte c
on c.category = o.category
group by o.category, o.product) subquery2 
where rn =1;
-- If you have duplicate products in the same category first of all you need to aggregate the values
select category, product, sum(spend) as sum_spend ,dense_rank() over(partition by category order by sum(spend) ) as rn
from orders1
group by category,product; 
-- Chcek this
select category,product,dense_rank() over(partition by category order by spend ) as rn
from orders1;

