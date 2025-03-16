--Find the total sales of each year
SELECT YEAR(order_date) As Order_Year,
SUM(sales_amount) AS Total_Sales,
COUNT(DISTINCT customer_key) AS Total_Customers,
SUM(quantity) AS Total_Quantity
FROM gold.fact_sales
WHERE order_date  IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date) DESC;
