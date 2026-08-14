use my_database;
CREATE TABLE studentss(
student_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    course VARCHAR(20),
    Age INT,
    marks int,
    city varchar(40)
);
select*from studentss;
insert into studentss values(21,'joshna','BBA',18,45,'bangalore'),(22,'alriya','BCOM',20,56,'kochi'),(23,'andrea','BCA',45,99,'mangolre'),(24,'lakshmi','BCOM',22,66,'mangolre'),(25,'sweedal','BCA',45,78,'kochi');
select*from studentss;
update studentss 
set course='BBA(DA)' 
where student_ID=4;
update studentss 
set course='Bcom(ai)' 
where student_ID=3;
update studentss 
set age=23
where student_id=10;
update studentss 
set course='BBA(DA)' 
where student_ID=4;
update studentss 
set age=100
where student_ID=11;
select*from studentss;
update studentss 
set course='BBA(DA)' 
where student_ID=4;
delete from studentss where course='bcom';
delete from studentss where course='bba';
delete from studentss where marks=72;
delete from studentss where age=21;
delete from studentss where city='kochi';
select*from studentss;
