SELECT *
FROM Sales.Customers

SELECT *
FROM Sales.Employees

SELECT *
FROM Sales.Orders

SELECT *
FROM Sales.Products

--Retrieve all records from the Sales.Customers table.
SELECT *
FROM Sales.Customers

--Display only the FirstName and LastName of all employees.
SELECT FirstName,LastName
FROM Sales.Employees

--Show all products and their prices.
SELECT Product,Price
FROM Sales.Products

--List the countries of all customers without duplicates.
SELECT DISTINCT Country
FROM Sales.Customers

--Retrieve the top 3 employees with the highest salaries
SELECT TOP 3 FirstName, LastName, Salary
FROM Sales.Employees
ORDER BY Salary DESC

--List the departments in the Employees table.
SELECT DISTINCT Department
FROM Sales.Employees

--Show the CustomerID and Score of all customers
SELECT CustomerID, Score
FROM Sales.Customers

--Select all customers who have a score greater than 500.
SELECT CustomerID,FirstName, LastName
FROM Sales.Customers
WHERE score > 500

--Display all orders sorted by OrderDate in descending order.
SELECT OrderID, OrderDate
FROM Sales.Orders
ORDER  BY OrderDate DESC

--Show all employees who have a manager.
SELECT FirstName
FROM Sales.Employees
WHERE ManagerID IS NOT NULL

--Find customers whose first name starts with 'M'.
SELECT *
FROM Sales.Customers
WHERE FirstName LIKE 'M%'

--Retrieve employees whose last name contains 'a'.
SELECT * 
FROM Sales.Employees
WHERE LastName LIKE '%a%'

--Select customers from the USA with a score above 600.
SELECT *
FROM Sales.Customers
WHERE Country = 'USA' AND Score > 600

--List all employees born after 1980.
SELECT *
FROM Sales.Employees
WHERE YEAR(BirthDate) > 1980

--Find products with names that end in 're'.
SELECT *
FROM Sales.Products
WHERE Product LIKE '%re'

--Display orders placed before '2020-01-01'.
SELECT *
FROM Sales.Orders
WHERE OrderDate < '2020-01-01'

--Show employees with salaries between 50000 and 70000.
SELECT *
FROM Sales.Employees
WHERE Salary BETWEEN 50000 AND 70000

--List customers whose last name is NULL.
SELECT *
FROM Sales.Customers
WHERE LastName IS NULL

--Retrieve all employees whose department is not 'Sales'.
SELECT *
FROM  Sales.Employees
WHERE Department != 'Sales'

--Find the products where second letter of the name should be e
SELECT *
FROM Sales.Products
WHERE Product LIKE '_e%'


--Find the products where second letter of the name should be a
SELECT *
FROM Sales.Products
WHERE Product LIKE '_a%'

--Get customers who are not from 'Germany'.
SELECT *
FROM Sales.Customers
WHERE Country != 'Germany'

--Find employees whose first names have exactly 5 characters.
SELECT *
FROM Sales.Employees
WHERE LEN(FirstName) = 5

--List customers with score not equal to 900.
SELECT *
FROM Sales.Customers
WHERE Score != 500

--Find employees whose birth date is between '1980-01-01' and '1990-12-31'.
SELECT *
FROM Sales.Employees
WHERE BirthDate BETWEEN '1980-01-01' AND '1990-12-31'

--Get products where product name includes the word "Pro".
SELECT *
FROM Sales.Products
WHERE Product LIKE '%PRO%'

--Get products where product name includes the word "ire".
SELECT *
FROM Sales.Products
WHERE Product LIKE '%ire%'

--Join Orders and Customers to get customer names and order dates
SELECT c.CustomerID, c.FirstName, o.OrderDate
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID

--Join Employees with themselves to show employee-manager pairs.
SELECT e.FirstName AS employee_name, m.ManagerID, m.FirstName
FROM Sales.Employees e
INNER JOIN (
	SELECT ManagerID, FirstName
	FROM Sales.Employees
	WHERE ManagerID IS NOT NULL) m
ON e.EmployeeID = m.ManagerID

/* In here we want to match the each employees managerId to another employee's employee id */

SELECT 
    e.FirstName AS employee_name, 
    e.ManagerID, 
    m.FirstName AS manager_name
FROM Sales.Employees e
INNER JOIN Sales.Employees m
    ON e.ManagerID = m.EmployeeID;

--List all orders with corresponding product names and prices.
SELECT o.OrderID, p.Product, p.Price
FROM Sales.Orders o
LEFT JOIN Sales.Products p
ON o.ProductID = p.ProductID

--Display all employees and their manager’s name.
SELECT e.FirstName,m.FirstName
FROM Sales.Employees e
LEFT JOIN Sales.Employees m
ON e.ManagerID = m.EmployeeID

--Get customer name, product name, and quantity for each order.
SELECT c.FirstName, p.Product, SUM(o.Quantity)
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
INNER JOIN Sales.Products p
ON o.ProductID = p.ProductID
GROUP BY c.FirstName,p.Product

--Join customers and orders where order amount > 60.
SELECT c.CustomerID,c.FirstName,SUM(o.Sales)
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.CustomerID = O.CustomerID
GROUP BY c.CustomerID,c.FirstName
HAVING SUM(o.Sales) > 60

--Show employee name and the number of orders handled (if orders table links)
SELECT e.EmployeeID,e.FirstName,COUNT(*) No_of_orders
FROM Sales.Employees e
INNER JOIN Sales.Orders o
ON e.EmployeeID = o.SalesPersonID
GROUP BY e.EmployeeID,e.FirstName 
ORDER BY No_of_orders DESC

--Show customers who haven’t placed any orders.
SELECT *
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL

--Show products that have never been ordered.
SELECT p.Product, o.OrderID,o.CustomerID
FROM Sales.Products p
LEFT JOIN Sales.Orders o
ON p.ProductID = o.ProductID
WHERE O.OrderID IS NULL

--Display the employee who handled each order
SELECT e.EmployeeID, e.FirstName, o.OrderID, o.OrderDate
FROM Sales.Employees e
INNER JOIN Sales.Orders o
ON e.EmployeeID = o.SalesPersonID

--Join employees with departments and show department-wise average salary
SELECT 
    e.EmployeeID,
    e.Department,
    e.Salary,
    AVG(e.Salary) OVER (PARTITION BY e.Department) AS avg_dept_salary
FROM Sales.Employees e;

--List all employees with their manager’s department.
SELECT e.EmployeeID,e.FirstName,m.Department,m.ManagerID
FROM Sales.Employees e
INNER JOIN Sales.Employees m
ON e.ManagerID = m.EmployeeID

SELECT 
    e.EmployeeID,
    e.FirstName AS EmployeeName,
    m.Department AS ManagerDepartment,
    e.ManagerID
FROM Sales.Employees e
INNER JOIN Sales.Employees m
    ON e.ManagerID = m.EmployeeID;

--Show customer name, order ID, and order total.
SELECT c.FirstName, 
       o.OrderID,
	   o.Sales
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.CustomerID = O.CustomerID

/*SELECT c.FirstName, 
       o.OrderID,
	   SUM(Sales) OVER (PARTITION BY c.CustomerID)
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.CustomerID = O.CustomerID*/


