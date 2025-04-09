/* Find the products that have a price higher than the average price of all the products */

SELECT *
FROM (SELECT 
         ProductID,
		 Product,
		 price,
		 AVG(Price) OVER () AVGPRICE
      FROM Sales.Products
       )t
WHERE Price > AVGPRICE

SELECT ProductID,
       Product,
	   Price
FROM Sales.Products
WHERE Price > (SELECT AVG(Price) FROM Sales.Products)

/* Rank the customers based on their total amount of sales */
SELECT
    CustomerID,
	SUM(Sales) 'TotalSales',
	SUM(Quantity) 'Total Quantity',
	RANK() OVER (ORDER BY SUM(Sales) DESC) 'Customer Ranking'
FROM Sales.Orders
GROUP BY CustomerID

SELECT *,
    RANK() OVER (ORDER BY Total_Quantity DESC)
FROM (SELECT
    CustomerID,
	SUM(Sales) 'TotalSales',
	SUM(Quantity) Total_Quantity
	FROM Sales.Orders
    GROUP BY CustomerID
    )T

/* Find the customer who has the 2nd best sales */
SELECT *
FROM (SELECT 
     CustomerID,
	SUM(Sales) 'TotalSales',
	SUM(Quantity) Total_Quantity,
	RANK() OVER (ORDER BY SUM(Sales) DESC) Customer_Ranking
	FROM Sales.Orders
    GROUP BY CustomerID    
   )T
WHERE Customer_Ranking = 2

--Select Clause
-- In here we use values that return single value

/* Find the product ids, names, price and total number of orders */
SELECT 
     ProductID,
	 Product,
	 Price,
	 (SELECT COUNT(*) FROM Sales.Orders)
FROM Sales.Products

--Show all customer details and find the total orders for each customer
SELECT c.CustomerID,
       c.FirstName,
	   c.LastName,
	   c.Country,
	   c.Score,
	   SUM(o.Sales) OVER(PARTITION BY c.CustomerID) Total_sales
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
    

SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.Country,
    c.Score,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(o.Sales) AS TotalSales
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID, c.FirstName, c.LastName, c.Country, c.Score;


SELECT *
FROM Sales.Customers c
LEFT JOIN (
		SELECT CustomerID,
			   COUNT(*) total_orsders
		FROM Sales.Orders
		GROUP BY CustomerID) o
ON c.CustomerID = o.CustomerID

--Find the products that have a price higher than the average price of all products
SELECT *,
(SELECT AVG(Price) FROM Sales.Products)
FROM Sales.Products 
WHERE Price > (SELECT AVG(Price) FROM Sales.Products)

--Show the details of orders made by customers in Germany
SELECT *
FROM Sales.Orders
WHERE CustomerID IN (SELECT CustomerID FROM Sales.Customers WHERE Country = 'Germany')

--Show the details of orders that are not made by customers in Germany
SELECT *
FROM Sales.Orders
WHERE CustomerID NOT IN (SELECT CustomerID FROM Sales.Customers WHERE Country = 'Germany')

SELECT *
FROM Sales.Orders
WHERE CustomerID IN (SELECT CustomerID FROM Sales.Customers WHERE Country != 'Germany')

--Find female employees whose salaries are greate than any male employee
SELECT FirstName, Salary
FROM Sales.Employees
WHERE Gender = 'F' AND Salary > ANY(SELECT Salary FROM Sales.Employees WHERE Gender = 'M')

----Find female employees whose salaries are greate than all male employee
SELECT FirstName, Salary
FROM Sales.Employees
WHERE Gender = 'F' AND Salary > ALL(SELECT Salary FROM Sales.Employees WHERE Gender = 'M')
