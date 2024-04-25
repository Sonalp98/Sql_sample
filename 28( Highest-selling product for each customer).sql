-- day 28/50 days SQL Challenge






SELECT * FROM walmart_eu;

/*
--Question
Write a query to find the highest-selling 
product for each customer

Return cx id, product description, 
and total count of purchase.
*/ 
-- cx all product they purchased and their total orders
-- order by by number of purchase desc
-- 1 product that has highest purchase 
-- rank 

-- use customer,product in group by but not in ranking beacuse then every product for each customer will have 1st rank 
-- because there is partition on product also which we don't want.
-- we want ranking for all the products under each customer

with cte as(select customerid, description,sum(quantity) as total_purchase,
dense_rank() over(partition by customerid order by sum(quantity) desc) as rn
from walmart_eu
group by customerid, description
order by customerid, description)
select * from cte
where rn=1;
-- This is based on count
SELECT *
FROM
(
    SELECT 
         customerid,
        description,
        COUNT(*) as total_purchase,
        RANK() OVER(PARTITION BY customerid 
        ORDER BY  COUNT(*) DESC) as rn
    FROM walmart_eu
    GROUP BY customerid, description
    ORDER BY customerid, total_purchase DESC  
) s
WHERE rn = 1