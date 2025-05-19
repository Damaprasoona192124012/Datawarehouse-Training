-- Create Database
CREATE DATABASE EmployeeDB;
GO

-- Use the Database
USE EmployeeDB;
GO

-- Create EmployeeAttendance Table
CREATE TABLE EmployeeAttendance (
    AttendanceID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    Date DATE,
    Status VARCHAR(20),
    HoursWorked INT
);

-- Insert Initial Data
INSERT INTO EmployeeAttendance (AttendanceID, EmployeeName, Department, Date, Status, HoursWorked) VALUES
(1, 'John Doe', 'IT', '2025-05-01', 'Present', 8),
(2, 'Priya Singh', 'HR', '2025-05-01', 'Absent', 0),
(3, 'Ali Khan', 'IT', '2025-05-01', 'Present', 7),
(4, 'Riya Patel', 'Sales', '2025-05-01', 'Late', 6),
(5, 'David Brown', 'Marketing', '2025-05-01', 'Present', 8);

-- Add a new attendance record
INSERT INTO EmployeeAttendance VALUES (6, 'Neha Sharma', 'Finance', '2025-05-01', 'Present', 8);

-- Update Riya Patel's status from Late to Present
UPDATE EmployeeAttendance
SET Status = 'Present'
WHERE EmployeeName = 'Riya Patel' AND Date = '2025-05-01';

-- Delete Priya Singh's attendance record
DELETE FROM EmployeeAttendance
WHERE EmployeeName = 'Priya Singh' AND Date = '2025-05-01';

-- Display all attendance records sorted by EmployeeName
SELECT * FROM EmployeeAttendance
ORDER BY EmployeeName ASC;

-- List employees sorted by HoursWorked in descending order
SELECT * FROM EmployeeAttendance
ORDER BY HoursWorked DESC;

-- Display all attendance records for the IT department
SELECT * FROM EmployeeAttendance
WHERE Department = 'IT';

-- List all Present employees from the IT department
SELECT * FROM EmployeeAttendance
WHERE Department = 'IT' AND Status = 'Present';

-- Retrieve all employees who are either Absent or Late
SELECT * FROM EmployeeAttendance
WHERE Status IN ('Absent', 'Late');

-- Calculate the total hours worked grouped by Department
SELECT Department, SUM(HoursWorked) AS TotalHours
FROM EmployeeAttendance
GROUP BY Department;

-- Find the average hours worked per day across all departments
SELECT AVG(HoursWorked) AS AverageHours
FROM EmployeeAttendance;

-- Count how many employees were Present, Absent, or Late
SELECT Status, COUNT(*) AS Count
FROM EmployeeAttendance
GROUP BY Status;

-- List all employees whose EmployeeName starts with 'R'
SELECT * FROM EmployeeAttendance
WHERE EmployeeName LIKE 'R%';

-- Display employees who worked more than 6 hours and are marked Present
SELECT * FROM EmployeeAttendance
WHERE HoursWorked > 6 AND Status = 'Present';

-- List employees who worked between 6 and 8 hours
SELECT * FROM EmployeeAttendance
WHERE HoursWorked BETWEEN 6 AND 8;

-- Display the top 2 employees with the highest number of hours worked
SELECT TOP 2 * FROM EmployeeAttendance
ORDER BY HoursWorked DESC;

-- List all employees whose HoursWorked are below the average
SELECT * FROM EmployeeAttendance
WHERE HoursWorked < (SELECT AVG(HoursWorked) FROM EmployeeAttendance);

-- Calculate the average hours worked for each attendance status
SELECT Status, AVG(HoursWorked) AS AverageHours
FROM EmployeeAttendance
GROUP BY Status;

-- Identify any employees who have multiple attendance records on the same date
SELECT EmployeeName, Date, COUNT(*) AS RecordCount
FROM EmployeeAttendance
GROUP BY EmployeeName, Date
HAVING COUNT(*) > 1;

-- Find the department with the highest number of Present employees
SELECT TOP 1 Department
FROM EmployeeAttendance
WHERE Status = 'Present'
GROUP BY Department
ORDER BY COUNT(*) DESC;

-- Find the employee with the most hours worked in each department
SELECT A.*
FROM EmployeeAttendance A
INNER JOIN (
    SELECT Department, MAX(HoursWorked) AS MaxHours
    FROM EmployeeAttendance
    GROUP BY Department
) B
ON A.Department = B.Department AND A.HoursWorked = B.MaxHours;
