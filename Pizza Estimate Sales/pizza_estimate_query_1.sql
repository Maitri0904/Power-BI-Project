SELECT * FROM [pizza_estimate].[dbo].[pizza_estimate]
  
  -- all data 
select * from pizza_estimate;

-- here i have extra column with all null values - delete that col
ALTER TABLE pizza_estimate drop column column13;

-- KPI 


-- q.1 What is the total revenue generated in the last year?

select SUM(total_price) as total_revenue from pizza_estimate;

-- q.2 How many total orders were placed?

select COUNT(DISTINCT order_id) as total_orders from pizza_estimate;

-- q.3 How many total pizzas were sold?

select sum(quantity) as total_pizza_sold from pizza_estimate;

-- q.4 What is the average order value (AOV)? [total revenue / total order ]

select ROUND(SUM(total_price) / COUNT(distinct order_id) , 2) as avg_order_value
from pizza_estimate;

-- q. 5 What is the average number of pizzas per order?

select ROUND(SUM(quantity) / COUNT(distinct order_id) ,2 ) as avg_pizza_pr_order
from pizza_estimate;


-- q.6 How many pizzas are sold yearly during peak hours?

SELECT
SUM(quantity) as pizza_sold_peak_hours
from pizza_estimate
where
DATEPART(HOUR, order_time) BETWEEN 12 AND 13 -- EFTERNOON TIME
OR DATEPART(HOUR, order_time) BETWEEN 17 AND 18; -- EVENING TIME


-- q. 7 What is the average number of pizzas sold per hour in day?
WITH hourly_daily_sales AS (
SELECT
order_date,
DATEPART(HOUR, CAST(order_time AS TIME)) AS order_hour, -- here we should find first day avg then we find horu avg
SUM(quantity) AS pizzas_sold
FROM pizza_estimate
GROUP BY
order_date,
DATEPART(HOUR, CAST(order_time AS TIME))
)
SELECT
ROUND(AVG(pizzas_sold * 1.0), 2) AS avg_pizzas_per_hour
FROM hourly_daily_sales;



-- q. 8 What is the average revenue per pizza?

SELECT
ROUND(SUM(total_price) / SUM(quantity * 1.0), 2) AS avg_revenue_per_pizza
FROM pizza_estimate;

-- Q.9 What is the average revenue generated per day?
WITH daily_sales AS (
    SELECT
        order_date,
        SUM(total_price) AS daily_revenue
    FROM pizza_estimate
    GROUP BY order_date
)
SELECT
    ROUND(AVG(daily_revenue), 2) AS avg_sales_per_day
FROM daily_sales;








-- CHART

--Q.10 What is the total revenue generated on each day? [line chart]
SELECT
    order_date,
    SUM(total_price) AS daily_revenue
FROM pizza_estimate
GROUP BY order_date;


-- q. 11 Which day of the week has the highest number of orders? [column chart]
select * from pizza_estimate;

SELECT
DATENAME(WEEKDAY, order_date) AS day_name,
COUNT(DISTINCT order_id) AS total_orders
FROM pizza_estimate
GROUP BY DATENAME(WEEKDAY, order_date)
ORDER BY total_orders DESC;


-- q. 12 Which hour of the day is the busiest based on number of orders? [histrogram]

SELECT 
DATEPART(HOUR , order_time) as order_hour ,
COUNT(distinct order_id) as total_orders
FROM pizza_estimate
GROUP BY DATEPART(HOUR, order_time)
ORDER BY total_orders desc;

-- q. 13 What is the monthly sales trend across the year? [column chart]

select
DATENAME(MONTH,order_date) as month_name,
SUM(total_price) as total_revenue
FROM pizza_estimate
GROUP BY MONTH(order_date) , DATENAME(MONTH , order_date)
order by total_revenue DESC;


-- q. 14 Which pizzas are the top 5 best-selling by quantity? [pie chart / donut chart]

SELECT TOP 5
pizza_name,
SUM(quantity) AS total_quantity_sold
FROM pizza_estimate
GROUP BY pizza_name
ORDER BY total_quantity_sold DESC;


-- q. 15 Which pizzas are the bottom 5 worst-selling by quantity? [pie / donut chart]

SELECT TOP 5
pizza_name,
SUM(quantity) AS total_quantity_sold
FROM pizza_estimate
GROUP BY pizza_name
ORDER BY total_quantity_sold ASC;


-- q. 16 Which pizzas generate the highest revenue? [tree map]

SELECT TOP(3)
pizza_name,
SUM(total_price) AS total_revenue
FROM pizza_estimate
GROUP BY pizza_name
ORDER BY total_revenue DESC;


-- q. 17 Which pizza categories contribute the most to total sales with percentage? [funnal chart ] 

SELECT
pizza_category,
SUM(total_price) AS total_revenue,
ROUND(
SUM(total_price) * 100.0 / SUM(SUM(total_price)) OVER (),
2
) AS revenue_percentage
FROM pizza_estimate
GROUP BY pizza_category
ORDER BY total_revenue DESC;


-- q.18 Are customers ordering more small or large pizzas? [funnal chart ] 

SELECT
pizza_size,
SUM(quantity) AS total_pizzas_sold,
CAST(
ROUND(
SUM(quantity) * 100.0 / SUM(SUM(quantity)) OVER (),
2
) AS DECIMAL(5,2)
) AS percentage_share
FROM pizza_estimate
GROUP BY pizza_size
ORDER BY total_pizzas_sold DESC; 

