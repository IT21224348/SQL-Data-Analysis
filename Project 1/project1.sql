-- Explore All Countries Our Customers Come form.
SELECT DISTINCT country
FROM gold.dim_customers;

--Explore All Categories "The major Divisions"
SELECT DISTINCT category, subcategory, product_name
FROM gold.dim_products
order by category, subcategory, product_name;

--Find the date of the first and last order
SELECT min(order_date) AS 'First Order Date', max(order_date) AS 'Last Order Date',
DATEDIFF(MONTH, MIN(order_date),MAX(order_date)) AS 'Order Range Months'
FROM gold.fact_sales;

--Find the youngest ans oldest custome
SELECT MIN(birthdate) AS 'Oldest Customer',  
DATEDIFF(YEAR,MIN(birthdate),GETDATE()) AS 'Oldest Age',
MAX(birthdate) AS 'Youngest Customer',
DATEDIFF(YEAR, MAX(birthdate),GETDATE()) AS 'Youngest Age'
FROM gold.dim_customers;

--Find total sales
SELECT SUM(sales_amount) AS 'Total Sales'
FROM gold.fact_sales;

--Find how many items are sold\
SELECT SUM(quantity) AS 'Total Quantity'
FROM gold.fact_sales;

--Find the average selling price
SELECT AVG(price)
FROM gold.fact_sales;

--Find the total number of orders
SELECT COUNT(order_number) AS 'Total Orders'
FROM gold.fact_sales;

SELECT COUNT(DISTINCT order_number) AS 'Total Orders'
FROM gold.fact_sales;

-- Find the total number of products
SELECT COUNT(product_id)
FROM gold.dim_products;

--Find the total number of customers
SELECT COUNT(customer_id)
FROM gold.dim_customers;

--Find total number of customers that has placed an order
SELECT COUNT(DISTINCT customer_key) AS 'Total Customers'
FROM gold.fact_sales;


--Generate a report that shows all key metrics of the business
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL 
SELECT 'Total Nr. Products', COUNT(product_name) FROM gold.dim_products
UNION ALL
SELECT 'Total Nr Customers',COUNT(customer_key) FROM gold.dim_customers
