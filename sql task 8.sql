use my_database;
CREATE TABLE customers23 (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50)
);
INSERT INTO customers23 (customer_id, customer_name, email, city)
VALUES
(101, 'Rahul', 'rahul@gmail.com', 'Mangalore'),
(102, 'Priya', 'priya@gmail.com', 'Bangalore'),
(103, 'Anu', 'anu@gmail.com', 'Kochi'),
(104, 'Arjun', 'arjun@gmail.com', 'Mysore'),
(105, 'Sneha', 'sneha@gmail.com', 'Chennai');

SELECT * FROM customers23;

CREATE TABLE transactions24 (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    transaction_date DATE,
    FOREIGN KEY (customer_id)
    REFERENCES customers23(customer_id)
);

INSERT INTO transactions24
(transaction_id, customer_id, amount, transaction_date)
VALUES
(1, 101, 5000, '2026-08-01'),
(2, 102, 2500, '2026-08-02'),
(3, 101, 7000, '2026-08-05'),
(4, 103, 1500, '2026-08-06'),
(5, 104, 9000, '2026-08-07'),
(6, 102, 4000, '2026-08-10'),
(7, 103, 2000, '2026-08-11'),
(8, 104, 6000, '2026-08-12'),
(9, 105, 3000, '2026-08-13'),
(10, 105, 2500, '2026-08-14'),
(11, 101, 5000, '2026-08-15'),
(12, 102, 2500, '2026-08-02');

SELECT * FROM transactions24;


CREATE TABLE invoices24 (
    invoice_id INT PRIMARY KEY,
    customer_id INT,
    invoice_amount DECIMAL(10,2),
    invoice_date DATE,
    due_date DATE,
    payment_status VARCHAR(20),
    FOREIGN KEY (customer_id) 
    REFERENCES customers23(customer_id)
);

INSERT INTO invoices24
VALUES
(501, 101, 5000, '2026-08-01', '2026-08-10', 'Unpaid'),
(502, 102, 3000, '2026-08-05', '2026-08-15', 'Paid'),
(503, 103, 7000, '2026-08-10', '2026-08-20', 'Unpaid'),
(504, 104, 4000, '2026-08-12', '2026-08-25', 'Paid'),
(505, 105, 6000, '2026-08-15', '2026-08-28', 'Unpaid');

SELECT * FROM invoices24;

select customer_name from customers23 where customer_id IN
(select customer_id from invoices24 where payment_status="unpaid");

select customer_name from customers23 where customer_id in
(select customer_id from transactions24 where amount>4500);

select customer_name from customers23 where customer_id in(
select customer_id from transactions24 where amount=(
select max(amount) from transactions24));

select customer_id from transactions24 where amount>
(select avg(amount) from transactions24);

select customer_name from customers23 where city="Mangalore" and customer_id in
(select customer_id from transactions24);


select c.customer_id, c.customer_name
from customers23 c
where  exists(
select 1
from invoices24 i
where i.customer_id=c.customer_id and i.payment_status="paid");


select c.customer_id, c.customer_name
from customers23 c
where exists(
select 1
from transactions24 t
where t.customer_id=c.customer_id and t.amount>4500);

select t1.transaction_id,t1.customer_id,t1.amount
from transaction24 t1
where t1.amount>(
select avg(t2.amount)
from transactions24 t2
where t2.customer_id=t1.customer_id);


select c.customer_id, c.customer_name
from customers23 c
where exists(
select 1
from transactions24 t
where c.customer_id=t.customer_id and c.city="Mangalore");

