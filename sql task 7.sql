use my_database;
CREATE TABLE Customer7 (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    phone_number bigint
);
INSERT INTO Customer7 (customer_id, customer_name, phone_number)
VALUES
(1, 'alisha', 5694295729),
(2, 'princia', 9273715047),
(3,'rita',6363287561),
(4,'riya',9936281534),
(5,'priyal',5472417283);
SELECT * FROM Customer7;

CREATE TABLE Invoices7(
    invoice_id INT PRIMARY KEY,
    customer_id INT,
    invoice_amount int,
    due_date date,
    FOREIGN KEY (customer_id)
    references customer7(customer_id)
    );
INSERT INTO Invoices7 (invoice_id, customer_id, invoice_amount, due_date)
VALUES
(101, 1, 50000, '2026-09-21'),
(102, 2, 75000, '2026-09-22'),
(103, 3, 30000, '2026-09-29'),
(104, 4, 20000, '2026-09-19'),
(105, 5, 22000, '2026-09-3');
SELECT * FROM Invoices7;

CREATE TABLE Payments7 (
    payment_id INT PRIMARY KEY,
    invoice_id INT,
    payment_amount DECIMAL(10,2),
	FOREIGN KEY (invoice_id) 
    references Invoices7(invoice_id)
    );
INSERT INTO Payments7 (payment_id, invoice_id, payment_amount)
VALUES
(1001, 101, 50000),
(1002, 102, 40000),
(1003, 103, 30000),
(1004, 104, 45000),
(1005, 105, 60000);
SELECT * FROM Payments7;

create view big_invoices as
select customer_id,invoice_amount from Invoices7 where invoice_amount>35000;
select*from big_invoices;

create view customer_balances7 as 
select c.customer_name,
	   i.invoice_amount,
       p.payment_amount,
       i.invoice_amount - p.payment_amount as balance 
from Customer7 c
join Invoices7 i on c.customer_id=i.customer_id
join Payments7 p on i.invoice_id = p.invoice_id;
select * from customer_balances7;


create view customer_overdue7 as 
select c.customer_name,
       i.invoice_amount - p.payment_amount as overdue 
from Customer7 c
join Invoices7 i on c.customer_id=i.customer_id
join Payments7 p on i.invoice_id = p.invoice_id
where invoice_amount> payment_amount;
select * from customer_overdue7;

create view customer_overdue_balance as 
select c.customer_name,
	   i.invoice_amount,
       p.payment_amount,
       i.invoice_amount - p.payment_amount as balance ,
       DATEDIFF(CURDATE(),i.due_date) as days_overdue
from Customer7 c
join Invoices7 i on c.customer_id=i.customer_id
join Payments7 p on i.invoice_id = p.invoice_id;
select * from customer_overdue_balance; 

CREATE VIEW customer_restrict7 AS
SELECT c.Customer_Name,
       i.Invoice_Amount,
       p.Payment_Amount,
       i.Invoice_Amount - p.Payment_Amount AS balance
FROM Customer7 c
JOIN Invoices7 i ON c.customer_id = i.customer_id
JOIN Payments7 p ON i.invoice_id = p.invoice_id
where i.Invoice_Amount - p.Payment_Amount > 0;
select*from customer_restrict7;