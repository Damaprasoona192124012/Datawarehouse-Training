-- Create Database
CREATE DATABASE BookStore;
USE BookStore;

-- Create Book Table
CREATE TABLE Book (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Price INT,
    PublishedYear INT,
    Stock INT
);

-- Insert Initial Data
INSERT INTO Book VALUES
(1, 'The Alchemist', 'Paulo Coelho', 'Fiction', 300, 1988, 50),
(2, 'Sapiens', 'Yuval Noah Harari', 'Non-Fiction', 500, 2011, 30),
(3, 'Atomic Habits', 'James Clear', 'Self-Help', 400, 2018, 25),
(4, 'Rich Dad Poor Dad', 'Robert Kiyosaki', 'Personal Finance', 350, 1997, 20),
(5, 'The Lean Startup', 'Eric Ries', 'Business', 450, 2011, 15);

-- 1. CRUD Operations

-- Add a new book
INSERT INTO Book VALUES (6, 'Deep Work', 'Cal Newport', 'Self-Help', 420, 2016, 35);

-- Update book price
UPDATE Book SET Price = Price + 50 WHERE Genre = 'Self-Help';

-- Delete a book
DELETE FROM Book WHERE BookID = 4;

-- Read all books sorted by Title
SELECT * FROM Book ORDER BY Title ASC;

-- 2. Sorting and Filtering

-- Sort by price descending
SELECT * FROM Book ORDER BY Price DESC;

-- Filter by genre: Fiction
SELECT * FROM Book WHERE Genre = 'Fiction';

-- Filter with AND condition
SELECT * FROM Book WHERE Genre = 'Self-Help' AND Price > 400;

-- Filter with OR condition
SELECT * FROM Book WHERE Genre = 'Fiction' OR PublishedYear > 2000;

-- 3. Aggregation and Grouping

-- Total stock value
SELECT SUM(Price * Stock) AS TotalStockValue FROM Book;

-- Average price by genre
SELECT Genre, AVG(Price) AS AveragePrice FROM Book GROUP BY Genre;

-- Total books by author
SELECT COUNT(*) AS TotalBooks FROM Book WHERE Author = 'Paulo Coelho';

-- 4. Conditional and Pattern Matching

-- Titles containing 'The'
SELECT * FROM Book WHERE Title LIKE '%The%';

-- Books by Yuval Noah Harari priced below 600
SELECT * FROM Book WHERE Author = 'Yuval Noah Harari' AND Price < 600;

-- Books priced between 300 and 500
SELECT * FROM Book WHERE Price BETWEEN 300 AND 500;

-- 5. Advanced Queries

-- Top 3 most expensive books
SELECT * FROM Book ORDER BY Price DESC LIMIT 3;

-- Books published before 2000
SELECT * FROM Book WHERE PublishedYear < 2000;

-- Total books in each Genre
SELECT Genre, COUNT(*) AS TotalBooks FROM Book GROUP BY Genre;

-- Find duplicate titles
SELECT Title, COUNT(*) FROM Book GROUP BY Title HAVING COUNT(*) > 1;

-- 6. Join and Subqueries (if related tables are present)

-- Author with the most books
SELECT Author 
FROM Book 
GROUP BY Author 
ORDER BY COUNT(*) DESC 
LIMIT 1;

-- Oldest book by genre
SELECT Genre, Title, MIN(PublishedYear) AS EarliestYear 
FROM Book 
GROUP BY Genre;
