-- Create a new database
CREATE DATABASE Company;

-- Use the database
USE Company;

-- Create a table with constraints using DDL
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,           
    FirstName VARCHAR(50) NOT NULL,       
    LastName VARCHAR(50) NOT NULL,
    Department VARCHAR(50),
    Salary DECIMAL(10, 2) CHECK (Salary >= 0),  
    HireDate DATE DEFAULT CURRENT_DATE      
);

-- Insert rows into the table using DML
INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate) 
VALUES 
(1, 'John', 'Smith', 'IT', 60000.00, '2023-01-15'),
(2, 'Jane', 'Doe', 'HR', 55000.00, '2023-02-20');

-- Update rows based on condition using DML
UPDATE Employees
SET Salary = 65000.00
WHERE EmployeeID = 1;

-- Delete rows from the table using DML
DELETE FROM Employees
WHERE EmployeeID = 2;

-- View current data
SELECT * FROM Employees;
