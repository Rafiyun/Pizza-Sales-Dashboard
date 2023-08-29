-- Total Revenue

SELECT
  sum(total_price) AS total_revenue
FROM pizza_sales

-- Average Order Value

SELECT
  sum(total_price) AS total_revenue,
  count(distinct order_id) AS total_order,
  sum(total_price) / count(distinct order_id) AS average_order_value
FROM pizza_sales

-- Total Pizzas Sold

SELECT 
  sum(quantity) AS total_pizzas
FROM pizza_sales

-- Total Orders

SELECT
  count(distinct order_id) AS total_order
FROM pizza_sales

-- Average Pizzas Per Order

SELECT
  sum(quantity) AS total_pizzas,
  count(distinct order_id) AS total_order,
  sum(quantity) / count(distinct order_id) AS average_order_value
FROM pizza_sales

-- Hourly Trend for Total Pizzas Sold

SELECT 
	DATEPART(HOUR, order_time) as order_hour,
	SUM(quantity) as total_pizzas_sold
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time) asc

-- Weekly Trend for Total Orders

SELECT 
	DATEPART(ISO_WEEK, order_date) as week_number,
	YEAR(order_date) AS order_year,
	COUNT(DISTINCT order_id) as total_orders
FROM pizza_sales
GROUP BY DATEPART(ISO_WEEK, order_date),YEAR(order_date)
ORDER BY DATEPART(ISO_WEEK, order_date),YEAR(order_date)

-- Percentage of Sales by Pizza Category

SELECT * FROM pizza_sales

SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS percentage
--where MONTH(order_date) = 1) as percentage
from pizza_sales AS total_sales
--where MONTH(order_date) = 1 -- 1 equates to the month of january
GROUP BY pizza_category

-- Percentage of sales by pizza size

SELECT * FROM pizza_sales

SELECT pizza_size, CAST(SUM(total_price) AS decimal(10,2)) as Total_Revenue,
CAST(SUM(total_price) * 100 / (SELECT sum(total_price) from pizza_sales) AS decimal(10,2)) AS pecentage
--WHERE DATEPART(quarter, order_date)=1) AS decimal(10,2)) as percentage
from pizza_sales
--WHERE DATEPART(quarter, order_date)=1
GROUP BY pizza_size
order by pizza_size

-- Total pizzas sold by pizza category

SELECT * FROM pizza_sales

SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

-- Top 5 Best Sellers and bottom by Revenue, Total Quantity and Total Orders

SELECT * FROM pizza_sales

-- Top 5 total revenue

SELECT TOP 5
	pizza_name,
	sum(total_price) as total_revenue
FROM pizza_sales
group by pizza_name
order by total_revenue desc --asc

-- Bottom 5 total revenue

SELECT TOP 5
	pizza_name,
	sum(total_price) as total_revenue
FROM pizza_sales
group by pizza_name
order by total_revenue asc

--Top 5 total_quantity

SELECT TOP 5
	pizza_name,
	sum(quantity) as total_quantity
FROM pizza_sales
group by pizza_name
order by total_quantity desc --asc

--Bottom 5 total_quantity

SELECT TOP 5
	pizza_name,
	sum(quantity) as total_quantity
FROM pizza_sales
group by pizza_name
order by total_quantity asc

-- Top 5 total_orders

SELECT TOP 5
	pizza_name,
	COUNT(DISTINCT order_id) as total_orders
FROM pizza_sales
group by pizza_name
order by total_orders desc --asc

-- Bottom 5 total_orders

SELECT TOP 5
	pizza_name,
	COUNT(DISTINCT order_id) as total_orders
FROM pizza_sales
group by pizza_name
order by total_orders asc