use my_database;
create table customers10(
customer_id int primary key,
customer_name varchar(30),
customer_email varchar(40)
);

CREATE TABLE transactions10 (
    transactions_id INT PRIMARY KEY,
    customer_id int,
    amount decimal(10,2),
    transaction_date date,
    foreign key(customer_id) references customers10(customer_id)
);

create table salaries(
employee_id int primary key,
employee_name varchar(30),
salary varchar(40)
);

create user "manager"@"localhost" identified by "manager@123";
create user "accountant"@"localhost" identified by "accountant@123";
create user "clerk"@"localhost" identified by "clerk@123"; 

grant select on my_database.*
to "manager"@"localhost";

grant select,insert,update
on my_database.transactions10
to"accountant"@"localhost";

grant select
on my_database.customers10
to "clerk"@"localhost";

grant delete
on my_database.transactions10
to "accountant"@"localhost";

revoke delete
on my_database.transactions10
from "accountant"@"localhost";

show grants for "manager"@"localhost";
show grants for "accountant"@"localhost";
show grants for "clerk"@"localhost";

