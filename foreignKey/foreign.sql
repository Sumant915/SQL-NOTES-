create database lotus;
use lotus;

create table products(Pid int primary key,Pname varchar(50),price int);
create table user(uid int primary key,uname varchar(50),city varchar(50));
show tables;
alter table products modify price decimal(10,2);

create table orders(oid int primary key,userid int ,pid int,foreign key(userid) references user(uid));
desc orders;

#add forign key to the existing structure
#alter table childetablename add foreign key (column name) 
#references parenttablename (primary key column);

alter table orders add foreign key(pid) references products(pid);
desc orders;

#alter table tablename drop foreign key foreignkeyname
#alter table tablename drop key nonunique key name;

alter table orders drop foreign key orders_ibfk_1;
desc orders;
alter table orders drop key userid;

alter table orders drop foreign key orders_ibfk_2;
alter table orders drop key pid;
desc orders;

alter table orders add foreign key(userid) references user(uid);

insert into user(uid,uname,city)
value(1,"A","X"),(2,"B","X"),(3,"C","Y"),(4,"D","Y"),(5,"E","X");
select*from user ;
rename table user to users;

insert into orders(oid,userid,pid)
values(102,10,202);
#above query will throw error because userid 10 does not exist in parent table

insert into orders(oid,userid,pid)
value(101,1,201);
insert into orders(oid,userid,pid)
values(102,2,202),(103,1,202),(104,3,201),(105,2,203);
select*from orders;

delete from users where uid=5;
select*from users;

delete from users where uid=1;
#above query throw error because
#uid 1 also exist in child table with column name user id

alter table orders drop foreign key orders_ibfk_1;
alter table orders drop key userid;

alter table orders add foreign key (userid) references users(uid) on delete set null;

delete from users where uid=1;
select *from users;
select*from orders;

delete from orders where oid=105;

update users set uid=40 where uid=4;
select*from users;

update users set uid=20 where uid=2;
#above query will give error because userid=2 exists in child table orders

alter table orders drop foreign key orders_ibfk_1;
alter table orders drop key userid;

alter table orders add foreign key(userid) 
references users(uid) on update cascade;

update users set uid=20 where uid=2;
select*from users;
select*from orders;

alter table orders drop foreign key orders_ibfk_1;
alter table orders drop key userid;
alter table orders add foreign key (userid) references users(uid) on delete cascade;
delete from users where uid=20;
select*from users;
select*from orders;

#task given
create database croma;
use croma;
create table department(pid int primary key,dname varchar(50));
insert into department 
values (1,"HR"),(2,"sales"),(3,"DA"),(4,"marketing");

create table employees(empid int primary key,emp_name varchar(50),deptid int,foreign key (deptid) references department(pid));
insert into employees
values(101,"A",1),(102,"B",2),(103,"C",1),(104,"D",3),(105,"E",3);

alter table employees drop foreign key employees_ibfk_1;
alter table employees drop key deptid;
alter table employees add foreign key (deptid) references department(pid) 
on delete set null on update cascade;

delete from department 
where pid=4;
delete from department 
where pid=1;

update department 
set pid=20 where pid=2;

select*from department;
select*from employees;

#drop primary key from employees and department 
alter table employees drop primary key;
alter table employees drop foreign key employees_ibfk_1;
alter table employees drop key deptid;
alter table department drop primary key;
desc department;
desc employees;

#create user and address table 

create table user (userid int primary key,uname varchar(50));
create table address(uid int ,att_1 varchar(100),att_2 varchar(100),city varchar(50) ,state varchar(50),
country varchar(50),pincode int,foreign key (uid) references user(userid) on delete set null on update cascade);
alter table address modify pincode varchar(10);
desc user;
desc address;