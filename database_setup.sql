-- 1. Create Tables
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Age INT,
    City VARCHAR(50),
    EmploymentStatus VARCHAR(50),
    AnnualIncome DECIMAL(12, 2)
);

CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    AccountType VARCHAR(30),
    CurrentBalance DECIMAL(12, 2),
    OpenDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    CustomerID INT,
    LoanAmount DECIMAL(12, 2),
    InterestRate DECIMAL(5, 2),
    LoanTermMonths INT,
    DebtToIncomeRatio DECIMAL(5, 2),
    LoanStatus VARCHAR(30),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- 2. Insert Sample Data
INSERT INTO Customers (CustomerID, FullName, Age, City, EmploymentStatus, AnnualIncome) VALUES
(1, 'Elena Rostova', 34, 'New York', 'Employed', 85000.00),
(2, 'Marcus Vance', 45, 'Chicago', 'Self-Employed', 120000.00),
(3, 'Sarah Jenkins', 28, 'Austin', 'Employed', 52000.00),
(4, 'David Chen', 51, 'San Francisco', 'Employed', 145000.00),
(5, 'Amanda Ross', 39, 'Seattle', 'Unemployed', 28000.00);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, CurrentBalance, OpenDate) VALUES
(101, 1, 'Checking', 4300.50, '2023-01-15'),
(102, 1, 'Savings', 15200.00, '2023-01-15'),
(103, 2, 'Checking', 12400.80, '2022-11-04'),
(104, 3, 'Checking', 850.20, '2024-03-10'),
(105, 4, 'Savings', 45000.00, '2021-05-20'),
(106, 5, 'Checking', 120.40, '2024-06-01');

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, LoanTermMonths, DebtToIncomeRatio, LoanStatus) VALUES
(1001, 1, 25000.00, 6.50, 36, 0.22, 'Current'),
(1002, 2, 50000.00, 7.20, 60, 0.35, 'Current'),
(1003, 3, 15000.00, 8.50, 24, 0.48, 'Default'),
(1004, 4, 100000.00, 5.50, 72, 0.18, 'Current'),
(1005, 5, 20000.00, 11.00, 36, 0.65, 'Default');

-- 3. Create Power BI Executive Overview View
CREATE OR REPLACE VIEW vw_BankExecutiveOverview AS
SELECT 
    c.CustomerID,
    c.FullName,
    c.Age,
    c.City,
    c.EmploymentStatus,
    c.AnnualIncome,
    a.AccountType,
    a.CurrentBalance,
    l.LoanID,
    l.LoanAmount,
    l.InterestRate,
    l.LoanTermMonths,
    l.DebtToIncomeRatio,
    l.LoanStatus
FROM Customers c
LEFT JOIN Accounts a ON c.CustomerID = a.CustomerID
LEFT JOIN Loans l ON c.CustomerID = l.CustomerID;
