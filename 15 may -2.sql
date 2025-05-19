create database data;
use data;
CREATE TABLE Product (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(100),
Category VARCHAR(100),
Price INT,
StockQuantity INT,
Supplier VARCHAR(100)
);
INSERT INTO Product VALUES
(1, 'Laptop', 'Electronics', 70000, 50, 'TechMart'),
(2, 'Office Chair', 'Furniture', 5000, 100, 'HomeComfort'),
(3, 'Smartwatch', 'Electronics', 15000, 200, 'GadgetHub'),
(4, 'Desk Lamp', 'Lighting', 1200, 300, 'BrightLife'),
(5, 'Wireless Mouse', 'Electronics', 1500, 250, 'GadgetHub');
--1 crud---
--1 Add a new product---
INSERT INTO Product (ProductID, ProductName, Category, Price, StockQuantity, Supplier)
VALUES (6, 'Gaming Keyboard', 'Electronics', 3500, 150, 'TechMart');
----2 Update product price----
UPDATE Product
SET Price = Price * 1.10
WHERE Category = 'Electronics';
---3 Delete a product---
DELETE FROM Product
WHERE ProductID = 4;
----4 Read all products-----
SELECT * FROM Product
ORDER BY Price DESC;

-----2 Sorting and Filtering:---
----5 Sort products by stock quantity---
SELECT * FROM Product
ORDER BY StockQuantity ASC;
----6 Filter products by category----
SELECT * FROM Product
WHERE Category = 'Electronics';
----7 Filter products with AND condition-----
SELECT * FROM Product
WHERE Category = 'Electronics' AND Price > 5000;
---8 Filter products with OR condition----
SELECT * FROM Product
WHERE Category = 'Electronics' OR Price < 2000;


----3 Aggregation and Grouping ---
---9 Calculate total stock value---
SELECT SUM(Price * StockQuantity) AS TotalStockValue FROM Product;
---10 Average price of each category---
SELECT Category, AVG(Price) AS AveragePrice
FROM Product
GROUP BY Category;
----11Total number of products by supplier---
SELECT COUNT(*) AS ProductCount
FROM Product
WHERE Supplier = 'GadgetHub';
-----4 Conditional and Pattern Matching----
-----12 Find products with a specific keyword---
SELECT * FROM Product
WHERE ProductName LIKE '%Wireless%';
-----13 Search for products from multiple suppliers -----
SELECT * FROM Product
WHERE Supplier IN ('TechMart', 'GadgetHub');
-----14 Filter using BETWEEN operator -----
SELECT * FROM Product
WHERE Price BETWEEN 1000 AND 20000;


----5. Advanced Queries----
----15 Products with high stock ---
SELECT * FROM Product
WHERE StockQuantity > (SELECT AVG(StockQuantity) FROM Product);

------16 Get top 3 expensive products -------
SELECT TOP 3 * FROM Product
ORDER BY Price DESC;

-------17 Find duplicate supplier names -------
SELECT Supplier, COUNT(*) AS Count
FROM Product
GROUP BY Supplier
HAVING COUNT(*) > 1;

-------18 Product summary-------
SELECT Category,
       COUNT(*) AS NumberOfProducts,
       SUM(Price * StockQuantity) AS TotalStockValue
FROM Product
GROUP BY Category;
-----19Supplier with most products---
SELECT TOP 1 Supplier, COUNT(*) AS ProductCount
FROM Product
GROUP BY Supplier
ORDER BY ProductCount DESC;

---6  Join and Subqueries-----
-----20 Most expensive product per category-----
SELECT P.*
FROM Product P
JOIN (
SELECT Category, MAX(Price) AS MaxPrice
FROM Product
GROUP BY Category
) AS MaxProducts
ON P.Category = MaxProducts.Category AND P.Price = MaxProducts.MaxPrice;










