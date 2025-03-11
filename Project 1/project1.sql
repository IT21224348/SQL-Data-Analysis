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
