use my_database;
CREATE TABLE financial_transactions (
    transaction_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    invoice_amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    payment_date DATE,
    region VARCHAR(30)
);
INSERT INTO financial_transactions
(transaction_id, customer_name, invoice_amount, payment_status, payment_date, region)
VALUES
(1, 'Anil Kumar', 12500, 'Paid', '2026-01-05', 'South'),
(2, 'Priya Nair', 18500, 'Pending', '2026-01-08', 'South'),
(3, 'Rahul Sharma', 22000, 'Paid', '2026-01-10', 'North'),
(4, 'Sneha Thomas', 9500, 'Paid', '2026-01-12', 'South'),
(5, 'Arjun Mehta', 32000, 'Pending', '2026-01-15', 'West'),
(6, 'Kavya Menon', 15000, 'Overdue', '2026-01-18', 'South'),
(7, 'Rohit Verma', 27500, 'Paid', '2026-01-20', 'North'),
(8, 'Neha Kapoor', 11000, 'Pending', '2026-01-22', 'North'),
(9, 'Amit Patel', 45000, 'Paid', '2026-01-25', 'West'),
(10, 'Divya Rao', 17500, 'Paid', '2026-01-28', 'South'),
(11, 'Sanjay Gupta', 25000, 'Overdue', '2026-02-02', 'North'),
(12, 'Meera Iyer', 13500, 'Paid', '2026-02-05', 'South'),
(13, 'Vikram Singh', 38000, 'Pending', '2026-02-08', 'North'),
(14, 'Pooja Shah', 21000, 'Paid', '2026-02-10', 'West'),
(15, 'Kiran Das', 8500, 'Pending', '2026-02-12', 'East'),
(16, 'Ramesh Kumar', 29500, 'Paid', '2026-02-15', 'South'),
(17, 'Asha Nair', 16000, 'Overdue', '2026-02-18', 'South'),
(18, 'Manish Joshi', 52000, 'Paid', '2026-02-20', 'West'),
(19, 'Lakshmi Rao', 19500, 'Pending', '2026-02-22', 'East'),
(20, 'Deepak Sharma', 27500, 'Paid', '2026-02-25', 'North'),
(21, 'Swathi Menon', 12000, 'Paid', '2026-02-28', 'South'),
(22, 'Naveen Patel', 34000, 'Overdue', '2026-03-03', 'West'),
(23, 'Reshma Thomas', 14500, 'Pending', '2026-03-05', 'South'),
(24, 'Ajay Verma', 41000, 'Paid', '2026-03-08', 'North'),
(25, 'Geetha Iyer', 23000, 'Pending', '2026-03-10', 'East');
select*from financial_transactions;
select*from financial_transactions where customer_name="priya nair";
select*from financial_transactions where payment_status="pending";
select*from financial_transactions where payment_status="paid";
select*from financial_transactions where region="south";
select*from financial_transactions where region="north";
select*from financial_transactions where invoice_amount between 22000 and 35000 ;
select*from financial_transactions where invoice_amount between 9500 and 12500;
select*from financial_transactions where invoice_amount between 32000 and 38000;
select*from financial_transactions where invoice_amount between 18500 and 32000;
select*from financial_transactions where invoice_amount between 25000 and 38000;
select*from financial_transactions where region in ('south','north');
select*from financial_transactions where invoice_amount in (22000,24000);
select*from financial_transactions where region in ('west','north');
select*from financial_transactions where payment_status in ('paid','pending');
select*from financial_transactions where payment_status in ('overdue','north');
select*from financial_transactions where customer_name like 'A%';
select*from financial_transactions where customer_name like '_A%';
select*from financial_transactions where customer_name like '__A%';
select*from financial_transactions where customer_name like 'A_A%';
select*from financial_transactions where customer_name like '%A'; 
select*from financial_transactions order by invoice_amount desc;
select*from financial_transactions order by customer_name;
select distinct region from financial_transactions;
select distinct payment_status from financial_transactions;
select distinct count( region,payment_status) from financial_transactions;





















