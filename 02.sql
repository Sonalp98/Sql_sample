-- Day 02/50

DROP TABLE IF EXISTS Orders;
	
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2)
);

DROP TABLE IF EXISTS Returns;
CREATE TABLE Returns (
    ReturnID INT PRIMARY KEY,
    OrderID INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO Orders (OrderID, OrderDate, TotalAmount) VALUES
(1, '2023-01-15', 150.50),
(2, '2023-02-20', 200.75),
(3, '2023-02-28', 300.25),
(4, '2023-03-10', 180.00),
(5, '2023-04-05', 250.80);

INSERT INTO Returns (ReturnID, OrderID) VALUES
(101, 2),
(102, 4),
(103, 5),
(104, 1),
(105, 3);


/*

Given the Orders table with columns OrderID, 
OrderDate, and TotalAmount, and the 
Returns table with columns ReturnID and OrderID, 

write an SQL query to calculate the total 
numbers of returned orders for each month

*/
-- total numbers of returns
-- group by month orders
-- LEFT JOIN 



SELECT * FROM orders;	
SELECT * FROM returns;
-- write an SQL query to calculate the total 
-- numbers of returned orders for each month
select date_format(OrderDate, '%Y-%m') as Yearmonth,count(ReturnID) as total_return
from returns r
left join orders o
on r.OrderID = o.OrderID
group by Yearmonth
order by Yearmonth;
-- || this works only when set sql_mode = 'ANSI' is set in Mysql 
select extract(month from o.OrderDate ) || '-' || extract( Year from o.OrderDate) as MONYEAR,
count(r.ReturnID) as total_return
from returns r
left join orders o
on r.OrderID = o.OrderID
group by MONYEAR
order by MONYEAR;

select extract(Year_month from OrderDate ) as ABC
from Orders ;
select extract(Year from OrderDate ) as ABC
from Orders ;
select extract(Month from OrderDate ) as ABC
from Orders ;
select  concat(extract(month from OrderDate ),"-", extract( Year from OrderDate)) as MONYEAR
from Orders ;
set sql_mode = 'ANSI';
select extract(month from OrderDate ) || '-' || extract( Year from OrderDate) as MONYEAR
from Orders ;