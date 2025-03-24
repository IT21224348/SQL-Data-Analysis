-- Order By key word

SELECT *
FROM dbo.customers
ORDER BY score DESC;

SELECT *
FROM dbo.customers
ORDER BY score ;

SELECT *
FROM dbo.customers
ORDER BY country ASC, score DESC ;

SELECT *
FROM dbo.customers
ORDER BY 4 ASC, 5 DESC ;
