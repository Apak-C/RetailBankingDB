Retail Banking Executive Dashboard & Risk Analysis

## Executive Summary:

Retail banking institutions require centralized, real-time visibility into customer portfolios, credit default risks, and deposit trends to ensure financial stability and minimize non-performing loan (NPL) losses. This project implements an end-to-end data analytics and business intelligence pipeline—combining a relational PostgreSQL database backend, optimized SQL views, and an interactive Power BI executive dashboard.

## Tech Stack & Architecture
Database & Querying: PostgreSQL, pgAdmin 4

Business Intelligence: Power BI Desktop

Core Concepts: Relational Data Modeling (Primary/Foreign Keys), Multi-Table Joins, Data Aggregation, Financial KPI Tracking, Risk Segmentation.

## Database Schema & Architecture
The database is structured around three core relational entities designed to maintain referential integrity and precision for financial calculations (using DECIMAL types to prevent floating-point rounding errors):

Customers: Stores core demographic and financial profile data (CustomerID, FullName, Age, City, EmploymentStatus, AnnualIncome).

Accounts: Tracks customer deposit accounts and balances (AccountID, CustomerID, AccountType, CurrentBalance, OpenDate).

Loans: Records credit details and risk markers (LoanID, CustomerID, LoanAmount, InterestRate, LoanTermMonths, DebtToIncomeRatio, LoanStatus).

## SQL Engineering & Performance Optimization
To optimize performance and streamline reporting for executive tools, a master SQL view was engineered to pre-join customer, account, and loan ledgers:

SQL
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
Risk Extraction Query
An analytical query used to isolate high-risk delinquent accounts and assess exposure:

SQL
SELECT 
    c.FullName,
    c.AnnualIncome,
    l.LoanAmount,
    l.DebtToIncomeRatio,
    l.LoanStatus,
    a.CurrentBalance
FROM Customers c
JOIN Loans l ON c.CustomerID = l.CustomerID
JOIN Accounts a ON c.CustomerID = a.CustomerID
WHERE l.LoanStatus = 'Default';

Power BI Executive Dashboard Features
The Power BI report connects directly to the PostgreSQL database view, presenting a clean, user-friendly 3-part layout for bank management:

Executive KPI Cards: Real-time tracking of total active loan portfolio volume ($235K+) and total customer deposits/balances ($77K+).

Loan Risk Breakdown Chart: A visual categorical split showing portfolio exposure between performing (Current) and non-performing (Default) assets.

Risk Indicator Integration: Evaluates debt-to-income (DTI) metrics against customer default behavior to support credit underwriting decisions.

## How to Run Locally
Clone the repository:

Bash
git clone https://github.com/your-username/retail-banking-analytics.git
Set up the Database:

Open pgAdmin and create a database named RetailBankingDB.

Run the schema creation and data insertion scripts located in the sql_scripts/ folder.

Open the Dashboard:

Launch Power BI Desktop and open Retail_Banking_Executive_Dashboard.pbix to explore the interactive visual model.
