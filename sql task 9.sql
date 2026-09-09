create database fin_db;
use fin_db;
use my_database;
create table transactionsss (
    transaction_id INT PRIMARY KEY,
    transaction_date DATE,
    department varchar(50),
    transaction_type varchar(40),
    amount decimal(10,2)
);

INSERT INTO transactionsSS
(transaction_id,transaction_date,department,transaction_type,amount)
VALUES
(1,'2024-03-01',"sales","income",50000),
(2,'2025-07-02',"HR","Expenses",30000),
(3,'2026-01-05',"Sales","income",45000),
(4,'2024-11-06',"IT","income",20000),
(5,'2025-04-07',"sales","expenses",80000),
(6,'2026-09-10',"HR","income",67000),
(7,'2024-06-11',"IT","expenses",45000),
(8,'2025-12-12',"Sales","income",89000),
(9,'2026-02-13',"HR","expenses",90000),
(10,'2024-08-14',"IT","income",23000),
(11,'2025-05-15',"Sales","expenses",55000),
(12,'2026-10-02',"HR","income",76000);

SELECT * FROM transactionsss;

select year(transaction_date) as year,month(transaction_date) as month,sum(amount) as total_amount
from transactionsss
group by year(transaction_date),month(transaction_date);

select year(transaction_date)as year,month(transaction_date)as month,sum(amount) as total_amount
from transactionsss
group by year(transaction_date),month(transaction_date);

with monthly_summary as(
select year(transaction_date)as year,month(transaction_date)as month,sum(amount) as total_amount
from transactionsss
group by year(transaction_date),month(transaction_date)
)
select*from monthly_summary; 

select year(transaction_date)as year,month(transaction_date)as month,sum(amount) as total_amount
from transactionsss
where transaction_type="income"
group by year(transaction_date),month(transaction_date);
select*from transactionsss;


select year(transaction_date)as year,sum(amount) as total_income
from transactionsss
where transaction_type="income"
group by year(transaction_date);  

select department,sum(amount) as total_expenses
from transactionsss
where transaction_type="expenses"
group by department;

select year(transaction_date)as year,department,sum(amount) as total_expenses
from transactionsss
where transaction_type="expenses"
group by year(transaction_date),department; 
  
 
 
 
 