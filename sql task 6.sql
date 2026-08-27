use my_database;
CREATE TABLE Customers444 (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Orders55(
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Order_Date DATE,
    Order_Amount DECIMAL(10,2),
    FOREIGN KEY (Customer_ID)
    REFERENCES Customers(Customer_ID)
);

CREATE TABLE Invoices22 (
    Invoice_ID INT PRIMARY KEY,
    Order_ID INT,
    Invoice_Date DATE,
    Invoice_Amount DECIMAL(10,2),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);

CREATE TABLE Payments (
    Payment_ID INT PRIMARY KEY,
    Invoice_ID INT,
    Payment_Date DATE,
    Payment_Amount DECIMAL(10,2),
    FOREIGN KEY (Invoice_ID) REFERENCES Invoices(Invoice_ID)
);

CREATE TABLE Ledger (
    Ledger_ID INT PRIMARY KEY,
    Customer_ID INT,
    Transaction_Date DATE,
    Debit DECIMAL(10,2),
    Credit DECIMAL(10,2),
    Description VARCHAR(100),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

insert into customers444
values
(1,"alriya","mangalore"),
(2,"joshna","bangalore"),
(3,"andrea","mysore"),
(4,"lakshmi","mumbai"),
(5,"manvi","kirem");
select*from customers44;

insert into Orders55
values
(101,1,9-19-2008,45000),
(102,2,2-15-2001,26000),
(103,3,4-25-1998,67857),
(104,4,1-9-2010,50000),
(105,5,7-6-1990,85000);
select*from Orders45;

insert into Invoices22
values
(101,1,"2026-4-8",60000),
(102,2,"2025-7-2",50000),
(103,3,"2023-5-2",45000),
(104,4,"2027-3-7",65000),
(105,5,"2022-9-2",34000);
select*from Invoices22;


INSERT INTO Payments VALUES
(201,1001,'2025-04-17',2500),
(202,1002,'2022-07-29',5000),
(203,1001,'2027-18-25',25700),
(204,1002,'2026-09-08',45500),
(205,1004,'2029-15-14',60900);
select*from Payments;

INSERT INTO Ledger VALUES
(1,1,'2026-08-01',5000,0,'Purchases'),
(2,2,'2026-08-02',0,8000,'Sales'),
(3,3,'2026-08-03',2500,0,'Office Expenses'),
(4,4,'2026-08-04',0,6000,'Payment Received'),
(5,1,'2026-08-05',1500,0,'Electricity Bill');
select * from Ledger;

SELECT 
    c.Customer_ID,
    c.Customer_Name,
    o.Order_ID,
    o.Order_Amount
FROM Customerss c
INNER JOIN Orders o
ON c.Customer_ID=o.Customer_ID;

SELECT 
    c.Customer_ID,
    c.Customer_Name,
    o.Order_ID,
    o.Order_Amount
FROM Customerss c
LEFT JOIN Orders o
ON c.Customer_ID=o.Customer_ID;

SELECT 
    c.Customer_ID,
    c.Customer_Name,
    o.Order_ID,
    o.Order_Amount
FROM Customerss c
RIGHT JOIN Orders o
ON c.Customer_ID=o.Customer_ID;



SELECT 
     c.Customer_ID,
    c.Customer_Name,
    o.Order_ID,
    o.Order_Amount,
    i.Invoice_ID,
    i.Invoice_Amount,
    p.Payment_ID,
    p.Payment_Amount,
    l.Ledger_ID,
    l.Debit,
    l.Credit
from Customerss c
LEFT JOIN Orders o
ON c.Customer_ID=o.Customer_ID
LEFT JOIN Invoices i
ON o.Order_ID=i.Order_ID
LEFT JOIN Payments p
ON i.Invoice_ID=p.Invoice_ID
LEFT JOIN Ledger l
ON c.Customer_ID=l.Customer_ID;


