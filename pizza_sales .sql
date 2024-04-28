
create table pizza_sales(
pizza_id int,
order_id int,
pizza_name_id varchar(20),
quantity int,
order_date  date,
order_time time,
unit_price float,
total_price float,
pizza_size varchar(50),
pizza_category varchar(50),
pizza_name varchar(100),
pizza_ingredients  varchar(500)
);
drop table pizza_sales


BULK INSERT pizza_sales
FROM 'C:\Users\lenovo\Downloads\pizza_sales1.csv'
WITH
(
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);


--1.Total Revenue
--the sum of total price of all pizza orders.
select sum(total_price) as 'total revenue 'from pizza_sales

--2.Avg order value
--(the avg amount spent per order .calculated by dividing the total revenue /total no of orders)
select sum(total_price) /count(distinct order_id) as 'Avg order value' from pizza_sales

--3. Total Pizzas Sold
SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales



--4. Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales


--5. Average Pizzas Per Order
--the avg no. of piza's sold per order .calculated by dividing the total no of piza's sold by the total no of orders

SELECT round(SUM(cast(quantity AS float))/ 
COUNT(DISTINCT order_id),2)
AS Avg_Pizzas_per_order
FROM pizza_sales

--or




--B. Daily Trend for Total Orders
SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales GROUP BY DATENAME(DW, order_date)
--datename() -giving name to order date & dw-dateweek means in that orderdate colm date is converted to weekday 


--C. Monthly Trend for Orders
select DATENAME(MONTH, order_date) as Month_Name, COUNT(DISTINCT order_id) as Total_Orders
from pizza_sales GROUP BY DATENAME(MONTH, order_date)


--D. % of Sales by Pizza Category

 SELECT  pizza_Category,
(SUM(total_Price) / (SELECT SUM(total_Price) FROM Pizza_sales)) * 100 AS PercentageOfSales
FROM  Pizza_sales GROUP BY   pizza_Category;


	


--E. % of Sales by Pizza Size
select pizza_size ,(sum(total_price)/(select sum(total_price) from pizza_sales ))*100 as PercentageOfSales
from pizza_sales group by pizza_size;

--F. Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) as Total_pizzas_Sold
FROM pizza_sales GROUP BY pizza_category 

--G. Top 5 Pizzas by Revenue
select top 5  pizza_name ,sum(total_price) as 'revenue' from pizza_sales  group by pizza_name order by revenue desc;

--H. Bottom 5 Pizzas by Revenue

select top 5  pizza_name ,sum(total_price) as 'revenue' from pizza_sales  group by pizza_name order by revenue asc;

--I. Top 5 Pizzas by Quantity
select top 5 pizza_name ,sum(quantity) as 'quantity' from pizza_sales group by pizza_name order by quantity desc;

--J. Bottom 5 Pizzas by Quantity
select top 5 pizza_name ,sum(quantity) as 'quantity' from pizza_sales group by pizza_name order by quantity asc;

--K. Top 5 Pizzas by Total Orders

select top 5 pizza_name ,count(distinct order_id) as 'total_order' from pizza_sales group by pizza_name order by total_order desc;
select *from pizza_sales

--L. Borrom 5 Pizzas by Total Orders
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales GROUP BY pizza_name ORDER BY Total_Orders ASC;
