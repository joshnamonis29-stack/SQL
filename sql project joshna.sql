-- Create the database
CREATE DATABASE FinancialDB;

-- Select the database
USE FinancialDB;
-- Create customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE,
    phone VARCHAR(20),
    city VARCHAR(60),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Create accounts table
CREATE TABLE accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    account_number VARCHAR(30) NOT NULL UNIQUE,
    account_type ENUM('Savings', 'Current') NOT NULL,
    opening_balance DECIMAL(14,2) DEFAULT 0.00,
    account_status ENUM('Active', 'Closed') DEFAULT 'Active',

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);
-- Create sales orders table
CREATE TABLE sales_orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_amount DECIMAL(14,2) NOT NULL,
    order_status ENUM(
        'Pending',
        'Completed',
        'Cancelled'
    ) DEFAULT 'Completed',

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    CHECK (order_amount >= 0)
);
-- Create invoices table
CREATE TABLE invoices (
    invoice_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL UNIQUE,
    invoice_date DATE NOT NULL,
    due_date DATE NOT NULL,
    invoice_amount DECIMAL(14,2) NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES sales_orders(order_id),

    CHECK (invoice_amount >= 0),
    CHECK (due_date >= invoice_date)
);
-- Create payments table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    invoice_id INT NOT NULL,
    payment_date DATE NOT NULL,
    payment_amount DECIMAL(14,2) NOT NULL,
    payment_method ENUM(
        'Cash',
        'UPI',
        'Card',
        'Bank Transfer'
    ) NOT NULL,

    FOREIGN KEY (invoice_id)
        REFERENCES invoices(invoice_id),

    CHECK (payment_amount > 0)
);
-- Create expenses table
CREATE TABLE expenses (
    expense_id INT PRIMARY KEY AUTO_INCREMENT,
    expense_date DATE NOT NULL,
    category VARCHAR(60) NOT NULL,
    description VARCHAR(200),
    amount DECIMAL(14,2) NOT NULL,

    CHECK (amount > 0)
);
-- Create ledger table
CREATE TABLE ledger (
    ledger_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT NOT NULL,
    entry_date DATE NOT NULL,
    entry_type ENUM('Debit', 'Credit') NOT NULL,
    amount DECIMAL(14,2) NOT NULL,
    description VARCHAR(200),

    FOREIGN KEY (account_id)
        REFERENCES accounts(account_id),

    CHECK (amount > 0)
);

-- Insert customer records
INSERT INTO customers
(customer_id, customer_name, email, phone, city)
VALUES
(1, 'Rahul', 'rahul@example.com', '9876500001', 'Bengaluru'),
(2, 'Priya', 'priya@example.com', '9876500002', 'Mysuru'),
(3, 'Arjun', 'arjun@example.com', '9876500003', 'Mangaluru'),
(4, 'Sneha', 'sneha@example.com', '9876500004', 'Hubballi'),
(5, 'Kiran', 'kiran@example.com', '9876500005', 'Belagavi');
-- Insert account records
INSERT INTO accounts
(account_id, customer_id, account_number,
 account_type, opening_balance)
VALUES
(1, 1, 'ACC1001', 'Current', 50000),
(2, 2, 'ACC1002', 'Current', 60000),
(3, 3, 'ACC1003', 'Savings', 40000),
(4, 4, 'ACC1004', 'Current', 30000),
(5, 5, 'ACC1005', 'Savings', 45000);
-- Insert sales orders
INSERT INTO sales_orders
(order_id, customer_id, order_date,
 order_amount, order_status)
VALUES
(101, 1, '2026-01-05', 50000, 'Completed'),
(102, 2, '2026-01-10', 65000, 'Completed'),
(103, 1, '2026-02-15', 42000, 'Completed'),
(104, 3, '2026-03-12', 75000, 'Completed'),
(105, 4, '2026-04-20', 38000, 'Completed'),
(106, 5, '2026-05-18', 55000, 'Completed');
-- Insert invoice records
INSERT INTO invoices
(invoice_id, order_id, invoice_date,
 due_date, invoice_amount)
VALUES
(2001, 101, '2026-01-05', '2026-01-20', 50000),
(2002, 102, '2026-01-10', '2026-01-25', 65000),
(2003, 103, '2026-02-15', '2026-03-01', 42000),
(2004, 104, '2026-03-12', '2026-03-27', 75000),
(2005, 105, '2026-04-20', '2026-05-05', 38000),
(2006, 106, '2026-05-18', '2026-06-02', 55000);
-- Insert payment records
INSERT INTO payments
(payment_id, invoice_id, payment_date,
 payment_amount, payment_method)
VALUES
(3001, 2001, '2026-01-18', 30000, 'UPI'),
(3002, 2002, '2026-01-22', 65000, 'Bank Transfer'),
(3003, 2003, '2026-02-28', 20000, 'UPI'),
(3004, 2004, '2026-03-25', 75000, 'Bank Transfer'),
(3005, 2005, '2026-05-01', 15000, 'Cash'),
(3006, 2006, '2026-05-30', 55000, 'UPI');
-- Insert expense records
INSERT INTO expenses
(expense_id, expense_date, category,
 description, amount)
VALUES
(4001, '2026-01-08', 'Rent', 'Office rent', 15000),
(4002, '2026-02-10', 'Salary', 'Employee salaries', 30000),
(4003, '2026-03-15', 'Electricity', 'Electricity bill', 8000),
(4004, '2026-04-12', 'Marketing', 'Digital marketing', 12000),
(4005, '2026-05-20', 'Travel', 'Business travel', 7000),
(4006, '2026-06-10', 'Office', 'Office supplies', 5000);
-- Insert ledger records
INSERT INTO ledger
(ledger_id, account_id, entry_date,
 entry_type, amount, description)
VALUES
(5001, 1, '2026-01-05', 'Credit', 50000, 'Sales receipt'),
(5002, 2, '2026-01-10', 'Credit', 65000, 'Sales receipt'),
(5003, 3, '2026-03-12', 'Credit', 75000, 'Sales receipt'),
(5004, 4, '2026-04-20', 'Credit', 38000, 'Sales receipt'),
(5005, 5, '2026-05-18', 'Credit', 55000, 'Sales receipt'),
(5006, 1, '2026-02-10', 'Debit', 30000, 'Salary expense');

-- Display customer records
SELECT * FROM customers;

-- Display account records
SELECT * FROM accounts;

-- Display sales orders
SELECT * FROM sales_orders;

-- Display invoice records
SELECT * FROM invoices;

-- Display payment records
SELECT * FROM payments;

-- Display expense records
SELECT * FROM expenses;

-- Display ledger records
SELECT * FROM ledger;


SELECT *
FROM sales_orders
WHERE order_status = 'Completed';
SELECT *
FROM sales_orders
WHERE order_amount > 50000;
SELECT *
FROM expenses
ORDER BY amount DESC;
SELECT SUM(order_amount) AS total_sales
FROM sales_orders
WHERE order_status = 'Completed';
SELECT SUM(amount) AS total_expenses
FROM expenses;

SELECT
    category,
    COUNT(*) AS expense_count,
    SUM(amount) AS total_expenses,
    AVG(amount) AS average_expenses
FROM expenses
GROUP BY category;

SELECT
    expense_id,
    category,
    amount,
    CASE
        WHEN amount >= 20000 THEN 'High'
        WHEN amount >= 10000 THEN 'Medium'
        ELSE 'Low'
    END AS expense_level
FROM expenses;

SELECT
    customers.customer_id,
    customers.customer_name,
    sales_orders.order_id,
    sales_orders.order_amount
FROM customers
INNER JOIN sales_orders
ON customers.customer_id = sales_orders.customer_id;
SELECT
    customers.customer_id,
    customers.customer_name,
    sales_orders.order_id,
    sales_orders.order_amount
FROM customers
LEFT JOIN sales_orders
ON customers.customer_id = sales_orders.customer_id;
SELECT
    customers.customer_name,
    sales_orders.order_id,
    sales_orders.order_amount
FROM customers
RIGHT JOIN sales_orders
ON customers.customer_id = sales_orders.customer_id;

SELECT
    c.customer_id,
    c.customer_name,
    COALESCE(SUM(o.order_amount), 0) AS total_sales
FROM customers c
LEFT JOIN sales_orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;
SELECT
    c.customer_name,
    o.order_id,
    i.invoice_id,
    i.invoice_amount,
    p.payment_id,
    p.payment_amount
FROM customers c
INNER JOIN sales_orders o
    ON c.customer_id = o.customer_id
INNER JOIN invoices i
    ON o.order_id = i.order_id
LEFT JOIN payments p
    ON i.invoice_id = p.invoice_id;
    
CREATE OR REPLACE VIEW invoice_balance_view AS
SELECT
    c.customer_id,
    c.customer_name,
    i.invoice_id,
    i.invoice_date,
    i.due_date,
    i.invoice_amount,
    COALESCE(SUM(p.payment_amount), 0) AS paid_amount,
    i.invoice_amount -
        COALESCE(SUM(p.payment_amount), 0) AS balance
FROM customers c
INNER JOIN sales_orders o
    ON c.customer_id = o.customer_id
INNER JOIN invoices i
    ON o.order_id = i.order_id
LEFT JOIN payments p
    ON i.invoice_id = p.invoice_id
GROUP BY
    c.customer_id,
    c.customer_name,
    i.invoice_id,
    i.invoice_date,
    i.due_date,
    i.invoice_amount;
    
SELECT *
FROM invoice_balance_view;

SELECT *
FROM invoice_balance_view
WHERE balance > 0;

SELECT *
FROM invoice_balance_view
WHERE balance > 0
AND due_date < CURRENT_DATE();

SELECT *
FROM sales_orders
WHERE order_amount > (
    SELECT AVG(order_amount)
    FROM sales_orders
);

SELECT *
FROM sales_orders
WHERE order_amount = (
    SELECT MAX(order_amount)
    FROM sales_orders
);

SELECT *
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM sales_orders o
    WHERE o.customer_id = c.customer_id
);

WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
        SUM(order_amount) AS total_sales
    FROM sales_orders
    WHERE order_status = 'Completed'
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
),
monthly_expenses AS (
    SELECT
        DATE_FORMAT(expense_date, '%Y-%m') AS expense_month,
        SUM(amount) AS total_expenses
    FROM expenses
    GROUP BY DATE_FORMAT(expense_date, '%Y-%m')
)
SELECT
    s.sales_month,
    s.total_sales,
    COALESCE(e.total_expenses, 0) AS total_expenses,
    s.total_sales - COALESCE(e.total_expenses, 0)
        AS operating_surplus
FROM monthly_sales s
LEFT JOIN monthly_expenses e
    ON s.sales_month = e.expense_month
ORDER BY s.sales_month;

SELECT
    order_id,
    order_amount,
    RANK() OVER (
        ORDER BY order_amount DESC
    ) AS sales_rank
FROM sales_orders;

SELECT
    order_id,
    order_amount,
    DENSE_RANK() OVER (
        ORDER BY order_amount DESC
    ) AS sales_rank
FROM sales_orders;

SELECT
    order_id,
    order_amount,
    ROW_NUMBER() OVER (
        ORDER BY order_amount DESC
    ) AS row_number
FROM sales_orders;

SELECT
    order_id,
    order_date,
    order_amount,
    LAG(order_amount) OVER (
        ORDER BY order_date, order_id
    ) AS previous_order_amount
FROM sales_orders;

SELECT
    order_id,
    order_date,
    order_amount,
    LEAD(order_amount) OVER (
        ORDER BY order_date, order_id
    ) AS next_order_amount
FROM sales_orders;

SELECT
    order_id,
    order_date,
    order_amount,
    SUM(order_amount) OVER (
        ORDER BY order_date, order_id
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS running_total
FROM sales_orders;

DELIMITER //

CREATE PROCEDURE get_customer_summary(
    IN p_customer_id INT
)
BEGIN
    SELECT
        c.customer_id,
        c.customer_name,
        COALESCE(SUM(o.order_amount), 0) AS total_sales
    FROM customers c
    LEFT JOIN sales_orders o
        ON c.customer_id = o.customer_id
    WHERE c.customer_id = p_customer_id
    GROUP BY c.customer_id, c.customer_name;
END //

DELIMITER ;

CALL get_customer_summary(1);

DELIMITER //

CREATE PROCEDURE get_monthly_financial_report(
    IN p_year INT,
    IN p_month INT
)
BEGIN
    SELECT
        p_year AS report_year,
        p_month AS report_month,

        COALESCE((
            SELECT SUM(order_amount)
            FROM sales_orders
            WHERE YEAR(order_date) = p_year
              AND MONTH(order_date) = p_month
              AND order_status = 'Completed'
        ), 0) AS total_sales,

        COALESCE((
            SELECT SUM(amount)
            FROM expenses
            WHERE YEAR(expense_date) = p_year
              AND MONTH(expense_date) = p_month
        ), 0) AS total_expenses,

        COALESCE((
            SELECT SUM(order_amount)
            FROM sales_orders
            WHERE YEAR(order_date) = p_year
              AND MONTH(order_date) = p_month
              AND order_status = 'Completed'
        ), 0)
        -
        COALESCE((
            SELECT SUM(amount)
            FROM expenses
            WHERE YEAR(expense_date) = p_year
              AND MONTH(expense_date) = p_month
        ), 0) AS operating_surplus;
END //

DELIMITER ;
CALL get_monthly_financial_report(2026, 1);

CREATE TABLE financial_audit (
    audit_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    table_name VARCHAR(64) NOT NULL,
    record_id BIGINT NOT NULL,
    action_type VARCHAR(10) NOT NULL,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    details VARCHAR(500)
);

DELIMITER //

CREATE TRIGGER payments_after_insert
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
    INSERT INTO financial_audit (
        table_name,
        record_id,
        action_type,
        details
    )
    VALUES (
        'payments',
        NEW.payment_id,
        'INSERT',
        CONCAT(
            'Invoice=', NEW.invoice_id,
            ', amount=', NEW.payment_amount
        )
    );
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER payments_after_update
AFTER UPDATE ON payments
FOR EACH ROW
BEGIN
    INSERT INTO financial_audit (
        table_name,
        record_id,
        action_type,
        details
    )
    VALUES (
        'payments',
        NEW.payment_id,
        'UPDATE',
        CONCAT(
            'Old amount=', OLD.payment_amount,
            ', new amount=', NEW.payment_amount
        )
    );
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER payments_after_delete
AFTER DELETE ON payments
FOR EACH ROW
BEGIN
    INSERT INTO financial_audit (
        table_name,
        record_id,
        action_type,
        details
    )
    VALUES (
        'payments',
        OLD.payment_id,
        'DELETE',
        CONCAT(
            'Deleted amount=', OLD.payment_amount
        )
    );
END //

DELIMITER ;

-- Insert a test payment
INSERT INTO payments (
    invoice_id,
    payment_date,
    payment_amount,
    payment_method
)
VALUES (
    2001,
    '2026-09-10',
    1000,
    'UPI'
);

-- Update the test payment
UPDATE payments
SET payment_amount = 1500
WHERE payment_id = LAST_INSERT_ID();

-- Display audit records
SELECT *
FROM financial_audit
ORDER BY audit_id DESC;

CREATE USER IF NOT EXISTS
'finance_readonly'@'localhost'
IDENTIFIED BY 'ChangeThisStrongPassword!';

GRANT SELECT
ON FinancialDB.*
TO 'finance_readonly'@'localhost';

CREATE USER IF NOT EXISTS
'finance_operator'@'localhost'
IDENTIFIED BY 'ChangeThisStrongPassword!';

GRANT SELECT, INSERT, UPDATE
ON FinancialDB.payments
TO 'finance_operator'@'localhost';

SHOW GRANTS
FOR 'finance_readonly'@'localhost';

SELECT
    (
        SELECT COALESCE(SUM(order_amount), 0)
        FROM sales_orders
        WHERE order_status = 'Completed'
    ) AS total_sales,

    (
        SELECT COALESCE(SUM(payment_amount), 0)
        FROM payments
    ) AS cash_collected,

    (
        SELECT COALESCE(SUM(amount), 0)
        FROM expenses
    ) AS total_expenses,

    (
        SELECT COALESCE(SUM(order_amount), 0)
        FROM sales_orders
        WHERE order_status = 'Completed'
    )
    -
    (
        SELECT COALESCE(SUM(amount), 0)
        FROM expenses
    ) AS operating_surplus;
    
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month_key,
        SUM(order_amount) AS sales
    FROM sales_orders
    WHERE order_status = 'Completed'
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
),
monthly_collections AS (
    SELECT
        DATE_FORMAT(payment_date, '%Y-%m') AS month_key,
        SUM(payment_amount) AS collections
    FROM payments
    GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
),
monthly_expenses AS (
    SELECT
        DATE_FORMAT(expense_date, '%Y-%m') AS month_key,
        SUM(amount) AS expenses
    FROM expenses
    GROUP BY DATE_FORMAT(expense_date, '%Y-%m')
),
all_months AS (
    SELECT month_key FROM monthly_sales
    UNION
    SELECT month_key FROM monthly_collections
    UNION
    SELECT month_key FROM monthly_expenses
)
SELECT
    m.month_key,
    COALESCE(s.sales, 0) AS sales,
    COALESCE(c.collections, 0) AS cash_collected,
    COALESCE(e.expenses, 0) AS expenses,
    COALESCE(s.sales, 0) - COALESCE(e.expenses, 0)
        AS operating_surplus
FROM all_months m
LEFT JOIN monthly_sales s
    ON m.month_key = s.month_key
LEFT JOIN monthly_collections c
    ON m.month_key = c.month_key
LEFT JOIN monthly_expenses e
    ON m.month_key = e.month_key
ORDER BY m.month_key;

SELECT
    c.customer_id,
    c.customer_name,
    COALESCE(SUM(o.order_amount), 0) AS total_sales
FROM customers c
LEFT JOIN sales_orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_sales DESC;

SELECT
    category,
    COUNT(*) AS number_of_expenses,
    SUM(amount) AS total_expenses,
    AVG(amount) AS average_expenses
FROM expenses
GROUP BY category
ORDER BY total_expenses DESC;

SELECT
    payment_method,
    COUNT(*) AS payment_count,
    SUM(payment_amount) AS total_collected
FROM payments
GROUP BY payment_method
ORDER BY total_collected DESC;

-- Check the number of customers
SELECT COUNT(*) AS customer_count
FROM customers;

-- Check the number of accounts
SELECT COUNT(*) AS account_count
FROM accounts;

-- Check the number of orders
SELECT COUNT(*) AS order_count
FROM sales_orders;

-- Check the number of invoices
SELECT COUNT(*) AS invoice_count
FROM invoices;

-- Check the number of payments
SELECT COUNT(*) AS payment_count
FROM payments;

-- Check the number of expenses
SELECT COUNT(*) AS expense_count
FROM expenses;

-- Check the number of ledger entries
SELECT COUNT(*) AS ledger_entry_count
FROM ledger;