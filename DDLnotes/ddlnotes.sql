show databases;
use sakila;
show tables;
desc actor;

create database schooldb1;
use schooldb1;

#create table without constraints
#create table tablename(column name datatype,col2name datatype...colNname datatype)

create table student(sid int,sname varchar(40),city varchar(40),
fees decimal(10,2),d_o_b date,mobile varchar(20));

desc student;

#rename structure or table;
#rename table tableoldname to table new name 

rename table student to stu;

#alter
#add column to existing structure
#alter table tablename add column columnname datatype
alter table stu add column pincode varchar(20);

desc stu;

#remove column from an existing structure
#alter table tablename drop column columnname;

alter table stu drop column pincode;

#rename column to existing structure
#alter table tablename rename column columnoldname to columnnewname;

alter table stu rename column sid to stu_id;

desc stu;

#change datatype in an existing structure
#alter table tablename modify columnname newdatatype;

alter table stu modify stu_id tinyint;

alter table stu modify sname varchar(50);

alter table stu modify fees decimal(8,2);