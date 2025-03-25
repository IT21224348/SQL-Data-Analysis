/* Find the products that have a price higer than the average price of all products */

SELECT *
FROM(
	SELECT 
	product_id,
	name,
	price,
	AVG(price) over () avgprice
	FROM product) t
WHERE price > avgprice

/* Rank customers based on their total amount of sales */

SELECT *,
RANK() OVER(ORDER BY total_sales DESC) Rank_customer
FROM(
	SELECT
		c.customer_id,
		SUM(total_amount) total_sales
	FROM customer c
	LEFT JOIN orders o
	ON c.customer_id = o.customer_id
	GROUP BY c.customer_id)t 


SELECT *,
RANK() OVER(ORDER BY total_sales DESC) Rank_customer
FROM(
	SELECT
		c.customer_id,
		SUM(total_amount) total_sales
	FROM customer c
	INNER JOIN orders o
	ON c.customer_id = o.customer_id
	GROUP BY c.customer_id)t 

SELECT *
FROM(
	SELECT
	  c.customer_id,
	  SUM(total_amount) total_sales,
	  RANK() OVER (ORDER BY SUM(total_amount) DESC) rank_customer
	FROM customer c
	INNER JOIN orders o
	ON c.customer_id = o.customer_id
	GROUP BY c.customer_id)T
WHERE rank_customer = 2
