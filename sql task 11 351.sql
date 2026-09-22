use my_database;
CREATE TABLE monthly_finance (
    id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    month_name VARCHAR(20),
    sales DECIMAL(10,2),
    expenses DECIMAL(10,2),
    tax_rate DECIMAL(5,2)
    );
    
INSERT INTO monthly_finance
VALUES
(1, 'Rahul', 'January', 50000, 30000, 10),
(2, 'Priya', 'January', 60000, 35000, 10),
(3, 'Anu', 'January', 45000, 25000, 10),
(4, 'Rahul', 'February', 55000, 32000, 10),
(5, 'Priya', 'February', 65000, 38000, 10),
(6, 'Anu', 'February', 50000, 27000, 10),
(7, 'Rahul', 'March', 60000, 34000, 10),
(8, 'Priya', 'March', 70000, 40000, 10),
(9, 'Anu', 'March', 55000, 30000, 10);
select*from monthly_finance;

DELIMITER  //
create procedure calculatetax(
	in p_sales decimal(10.2),
    in p_tax_rate decimal(10,2)
    )
    
BEGIN
	select p_sales as sales,
    p_tax_rate as tax_rate,
    p_sales*p_tax_rate/100 as tax_amount;
END //
DELIMITER ;

call calculatetax(50000,3);
call calculatetax(22000,5);

create table month_end_closing2(
month varchar(30),
total_sales decimal(10,2),
total_expenses decimal(10,2),
profit_lose decimal(10,2)
);

INSERT INTO month_end_closing2
VALUES
('January', 50000, 30000, 10),
('January', 60000, 35000, 10),
('January', 45000, 25000, 10),
('February', 55000, 32000, 10),
('February', 65000, 38000, 10),
('February', 50000, 27000, 10),
('March', 60000, 34000, 10),
('March', 70000, 40000, 10),
('March', 55000, 30000, 10);
select*from month_end_closing1;

DELIMITER  //
create procedure month_end_closing2(
in p_month varchar(20))
BEGIN
insert into month_end_closing2 (month,total_sales,total_expenses,profit_lose)
select month_name,sum(sales),sum(expenses),sum(sales)-sum(expenses)
from monthly_finance
where month_name=p_month
group by month_name;

END //
DELIMITER ;

call month_end_closing2('March');
call month_end_closing2('February');
select*from month_end_closing2;  

CREATE TABLE customers6 (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

INSERT INTO customers6
VALUES
(1, 'Rahul'),
(2, 'Priya'),
(3, 'Arun'),
(4,'Aaron'),
(5,'Riya');
select*from customers6;

CREATE TABLE customer_transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    transaction_type VARCHAR(20),
    amount DECIMAL(10,2)
);

INSERT INTO customer_transactions
VALUES
(101, 1, 'Credit', 50000),
(102, 1, 'Debit', 20000),
(103, 2, 'Credit', 60000),
(104, 2, 'Debit', 25000),
(105, 3, 'Credit', 40000),
(106, 3, 'Debit', 15000);
select*from customer_transactions;

DELIMITER //
create procedure customer_account_summary1(
in p_customer_id int)
BEGIN
SELECT c.customer_id,c.customer_name,SUM(CASE WHEN t.transaction_type = 'Credit'
THEN t.amount ELSE 0
END) AS total_credit,SUM(CASE WHEN t.transaction_type = 'Debit'
THEN t.amount ELSE 0
END) AS total_debit,SUM(CASE WHEN t.transaction_type = 'Credit'
THEN t.amount ELSE -t.amount
END) AS balance
FROM customers6 c
JOIN customer_transactions t ON c.customer_id = t.customer_id
WHERE c.customer_id = p_customer_id
GROUP BY c.customer_id, c.customer_name;

END //
DELIMITER ;
 
 call customer_account_summary1(1);
 call customer_account_summary1(3);
 
DELIMITER //
create procedure year_end_profit()
BEGIN
select SUM(sales) AS total_sales,SUM(expenses) AS total_expenses,SUM(sales) - SUM(expenses) AS net_profit
FROM monthly_finance;

END //
DELIMITER ;

call year_end_profit();