--Find the total sales across all orders. Additionally provide details such as Order id, order date 

SELECT OrderID, OrderDate, 
SUM(Sales) OVER ()
FROM Sales.Orders

--Find the total sales for each product, additionally provide details such as order id and order date

SELECT OrderID, OrderDate,
SUM(Sales) OVER (PARTITION BY ProductID)
FROM Sales.Orders

--Find the total sales for each combination of product and order status. Give product id and order status. Give order id and order date

SELECT OrderID, OrderDate,ProductID, OrderStatus,
SUM(Sales) OVER (PARTITION BY ProductID, OrderStatus)
FROM Sales.Orders
