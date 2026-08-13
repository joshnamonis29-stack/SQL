CREATE DATABASE FinancialDB;
USE FinancialDB;
CREATE TABLE Customers91(
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15)
);
INSERT INTO Customers91 (Customer_ID, Customer_Name, Email, Phone)
VALUES
(1, 'Joshna', 'joshna@gmail.com', '9876543210'),
(2, 'Mary', 'mary@gmail.com', '98765432411');
CREATE TABLE Accounts7 (
    Account_ID INT PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Account_Type VARCHAR(50) NOT NULL,
    Balance DECIMAL(10,2) CHECK (Balance >= 0),
    FOREIGN KEY (Customer_ID)
    REFERENCES Customers(Customer_ID)
);
INSERT INTO Accounts7 (Account_ID, Customer_ID, Account_Type, Balance)
VALUES
(101, 1, 'Savings', 5000.00),
(102, 2, 'Current', 10000.00),
(103, 3, 'Savings', 7500.00),
(104, 4, 'Savings', 3000.00);
CREATE TABLE Transactions1 (
    Transaction_ID INT PRIMARY KEY,
    Account_ID INT NOT NULL,
    Transaction_Date DATE,
    Transaction_Type VARCHAR(10),
    Amount DECIMAL(10,2) CHECK (Amount >= 0),
    FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID),
    CHECK (Transaction_Type IN ('Credit', 'Debit'))
);
INSERT INTO Transactions (Transaction_ID, Account_ID, Transaction_Date, Transaction_Type, Amount)
VALUES
(1001, 101, '2026-08-01', 'Credit', 2000.00),
(1002, 101, '2026-08-02', 'Debit', 500.00),
(1003, 102, '2026-08-03', 'Credit', 5000.00),
(1004, 103, '2026-08-04', 'Debit', 1000.00),
(1005, 104, '2026-08-05', 'Credit', 1500.00);
ALTER TABLE Customers91 ADD Address VARCHAR(200);
CREATE TABLE TestTable (
    ID INT PRIMARY KEY,
    Name VARCHAR(50)
);
DROP TABLE TestTable;
SELECT * FROM Customers91;
SELECT * FROM Accounts7;
SELECT * FROM Transactions1;