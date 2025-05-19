-- Create Database and Use It
CREATE DATABASE InventoryDB;
GO
USE InventoryDB;
GO

-- Create Table
CREATE TABLE ProductInventory (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    Supplier VARCHAR(50),
    LastRestocked DATE
);

-- Insert Sample Data
INSERT INTO ProductInventory VALUES
(1, 'Laptop', 'Electronics', 20, 70000, 'TechMart', '2025-04-20'),
(2, 'Office Chair', 'Furniture', 50, 5000, 'HomeComfort', '2025-04-18'),
(3, 'Smartwatch', 'Electronics', 30, 15000, 'GadgetHub', '2025-04-22'),
(4, 'Desk Lamp', 'Lighting', 80, 1200, 'BrightLife', '2025-04-25'),
(5, 'Wireless Mouse', 'Electronics', 100, 1500, 'GadgetHub', '2025-04-30');

-- CRUD Operations
-- 1. Add new product
INSERT INTO ProductInventory VALUES
(6, 'Gaming Keyboard', 'Electronics', 40, 3500, 'TechMart', '2025-05-01');

-- 2. Update stock quantity
UPDATE ProductInventory 
SET Quantity = Quantity + 20 
WHERE ProductName = 'Desk Lamp';

-- 3. Delete discontinued product
DELETE FROM ProductInventory 
WHERE ProductID = 2;

-- 4. Read all products sorted by ProductName
SELECT * FROM ProductInventory 
ORDER BY ProductName ASC;

-- Sorting and Filtering
-- 1. Sort by Quantity (Descending)
SELECT * FROM ProductInventory 
ORDER BY Quantity DESC;

-- 2. Filter by Category
SELECT * FROM ProductInventory 
WHERE Category = 'Electronics';

-- 3. AND Condition
SELECT * FROM ProductInventory 
WHERE Category = 'Electronics' AND Quantity > 20;

-- 4. OR Condition
SELECT * FROM ProductInventory 
WHERE Category = 'Electronics' OR UnitPrice < 2000;

-- Aggregation and Grouping
-- 1. Total Stock Value
SELECT SUM(Quantity * UnitPrice) AS TotalStockValue 
FROM ProductInventory;

-- 2. Average Price by Category
SELECT Category, AVG(UnitPrice) AS AvgPrice 
FROM ProductInventory 
GROUP BY Category;

-- 3. Count Products by Supplier
SELECT COUNT(*) AS ProductCount 
FROM ProductInventory 
WHERE Supplier = 'GadgetHub';

-- Conditional and Pattern Matching
-- 1. ProductName starts with 'W'
SELECT * FROM ProductInventory 
WHERE ProductName LIKE 'W%';

-- 2. Supplier = GadgetHub and UnitPrice > 10000
SELECT * FROM ProductInventory 
WHERE Supplier = 'GadgetHub' AND UnitPrice > 10000;

-- 3. UnitPrice BETWEEN 1000 AND 20000
SELECT * FROM ProductInventory 
WHERE UnitPrice BETWEEN 1000 AND 20000;

-- Advanced Queries
-- 1. Top 3 Most Expensive Products
SELECT TOP 3 * FROM ProductInventory 
ORDER BY UnitPrice DESC;

-- 2. Products Restocked in Last 10 Days
SELECT * FROM ProductInventory 
WHERE LastRestocked >= DATEADD(DAY, -10, GETDATE());

-- 3. Total Quantity by Supplier
SELECT Supplier, SUM(Quantity) AS TotalQuantity 
FROM ProductInventory 
GROUP BY Supplier;

-- 4. Products with Quantity < 30
SELECT * FROM ProductInventory 
WHERE Quantity < 30;

-- Join & Subqueries
-- 1. Supplier with Most Products
SELECT TOP 1 Supplier, COUNT(*) AS ProductCount
FROM ProductInventory
GROUP BY Supplier
ORDER BY ProductCount DESC;

-- 2. Product with Highest Stock Value
SELECT TOP 1 *, (Quantity * UnitPrice) AS StockValue
FROM ProductInventory
ORDER BY StockValue DESC;
