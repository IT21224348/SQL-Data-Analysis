--Find the total sales of each year
SELECT YEAR(order_date) As Order_Year,
SUM(sales_amount) AS Total_Sales,
COUNT(DISTINCT customer_key) AS Total_Customers,
SUM(quantity) AS Total_Quantity
FROM gold.fact_sales
WHERE order_date  IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date) DESC;

--Find the total sales of each month
SELECT MONTH(order_date) AS Order_year,
       SUM(sales_amount) AS Total_sales,
	   COUNT(DISTINCT customer_key) AS Total_Customers,
	   SUM(quantity) AS Total_Quantity
FROM gold.fact_sales  
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date)

--Find total sales of each year each months
SELECT YEAR(order_date) AS Order_year,
       MONTH(order_date) AS Order_month,
       SUM(sales_amount) AS Total_sales,
	   COUNT(DISTINCT customer_key) AS Total_customers,
	   SUM(quantity) AS Total_Quantity
FROM gold.fact_sales  
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date),MONTH(order_date)
ORDER BY YEAR(order_date),MONTH(order_date)

SELECT DATETRUNC(MONTH,order_date) AS Order_year,
       SUM(sales_amount) AS Total_sales,
	   COUNT(DISTINCT customer_key) AS Total_customers,
	   SUM(quantity) AS Total_Quantity
FROM gold.fact_sales  
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH,order_date)
ORDER BY DATETRUNC(MONTH,order_date)

--Custom Format
SELECT FORMAT(order_date, 'YYYY-MMM') AS Order_month,
       SUM(sales_amount) AS Total_sales,
	   COUNT(DISTINCT customer_key) AS Total_customer,
	   SUM(quantity) AS Total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'YYYY-MMM')
ORDER BY FORMAT(order_date, 'YYYY-MMM')

--Calculate the total sales per month
-- and the running total of sales over time

SELECT 
order_date,
Total_sales,
SUM(Total_sales) OVER (ORDER BY order_date)  AS running_total_sales
FROM
(
SELECT DATETRUNC(MONTH,order_date) AS order_date,
SUM(sales_amount) AS Total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH,order_date)) t
