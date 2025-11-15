create database office;
use  office;
create table employees(empid int , empname varchar(50),salary int , city varchar(50),d_o_j date);

#alter
alter table employees add column mobile varchar(20);
select*from employees;
alter table employees drop city;
alter table employees rename column empid to eid;
alter table employees modify  eid tinyint;

#insert
insert into  employees(eid,empname,salary,d_o_j,mobile)
values(1,"xyz",300000,"2024-12-21","+916264410764");
insert into  employees(eid,empname,salary,d_o_j,mobile)
values(2,"abc",200000,"2024-02-01","+916264410478");
insert into employees(eid,empname,salary,d_o_j,mobile)
values(3,"pqr",40000,"2023-11-09","+912345678978"),(4,"ast",50000,"2025-10-30","+916565656578");

#update
update employees set empname="aviral"
where eid=1;
set sql_safe_updates=0;

#delete
start transaction;
delete from employees where eid=1;
rollback;

#rename 
rename table employees to emp;

select*from emp;

truncate table emp;
drop table emp;
drop database office;