create database joins;
use joins;

create table table1(id int);
insert into table1(id)
values (1),(1),(1),(2),(3),(3),(3),(null);

create table table2(id int);
insert into table2(id)
values (1),(1),(2),(4),(null),(null);

#cross join: product of no. of records of table1 and no. of recors of table2
#syntax
#select columnlist/* from tablename1 cross join tablename2;

select * from table1 cross join table2;
select count(*) from table1 cross join table2;

#inner join: Matched record between table1 and table2
#syntax:-
#select columnlist/* from tablename 1 inner join tablename2 
#on tablename1.common column=tablename2.common column

select * from table1 t1 inner join table2 t2
on t1.id=t2.id;
select count(*) from table1 t1 inner join table2 t2
on t1.id=t2.id;
select count(*) from table1 t1 inner join table2 t2;

# NOTE:- inner join without common column condition(on) behaves like a cross join
#         Similarly cross join with ON condition behaves like a inner join

#left join
select * from table1 t1 left join table2 t2
on t1.id=t2.id;
select count(*) from table1 left join table2
on table1.id=table2.id;

#right join
select * from table1 t1 right join table2 t2
on t1.id=t2.id;
select count(*) from table1 t1 right join table2 t2
on t1.id=t2.id;

#NATURAL JOIN
use joins;
select * from table1 natural join table2;
select count(*) from table1 natural join table2;

alter table table1 rename column id to eid;
select count( *) from table1 natural join table2;
alter table table1 rename column eid to id;

#FULL JOIN:- ALL the remaining records of left table + inner join + All the remaining records of right table

#left exclusive + right join
select * from table1 t1
left join table2 t2 on t1.id=t2.id
union all
select * from table1 t1 right join table2 t2 
on t1.id=t2.id
where t1.id is null;

#left join +right exclusive
select * from table1 t1 left join table2 t2
on t1.id=t2.id where t2.id is null
union all
select * from table1 t1 right join table2 t2
on t1.id=t2.id;

use dummy;

#cross join
select * from customers cross join orders;
select count(*) from customers cross join orders;

#INNER JOIN
# wasq to fetch customers who have either placed orders or not
select * from customers c inner join orders o 
on c.customernumber=o.customernumber;
select count(*) from customers c inner join orders o 
on c.customernumber=o.customernumber;

#LEFT JOIN
select count(*) from customers c left join orders o 
on c.customernumber=o.customernumber;

#LEFT EXCLUSIVVE
#WASQ to fetch customers who have not placed order
select count(*) from customers c left join orders o
on c.customernumber=o.customernumber
where o.customernumber is null;

#right JOIN
#wasq
select count(*) from customers c right join orders o 
on c.customernumber=o.customernumber;

#RIGHT EXCLUSIVE 
select count(*) from customers c right join orders o
on c.customernumber=o.customernumber where c.customernumber is null;

#NATURAL JOIN
select count(*) from customers natural join orders ;

#FULL JOIN
select count(*) from customers c left join orders o 
on c.customernumber=o.customernumber
union all
select count(*) from customers c right join orders o
on c.customernumber=o.customernumber
where c.customernumber is null;

select count(*) from customers c left join orders o 
on c.customernumber=o.customernumber
where o.customernumber is null
union all
select count(*) from customers c right join orders o
on c.customernumber=o.customernumber;
 
use dummy;

#wasq to fetch productname and their order value 
select productname,(quantityordered*priceeach) as ordervalue 
from orderdetails o inner join products p
on o.productcode=p.productcode;

#wasq to fetch customername and their respective sales representative name 
select customername from customers c inner join employees e
on c.salesrepemployeenumber=e.employeenumber;

#wasq to fetch employs name who does not represent any customer 
select concat(firstname," ",lastname) as employ_name from 
employees left join customers on employeenumber=salesrepemployeenumber
where salesrepemployeenumber is null;


#wasq to fetch customer details who have not placed any order
select * from customers c left join orders o
on c.customernumber=o.customernumber 
where o.customernumber is null;

#wasq to find products name that have not been sold 
select productname from products p left join orderdetails o
on p.productcode=o.productcode where o.productcode is null;

#wasq to fetch customername who have sales representative but have not placed any order (ans=2 records)
select customername from customers c left join orders o
on c.customernumber=o.customernumber where 
(o.customernumber is null and salesrepemployeenumber is not null);

#wasq to fetch customername along with their ordernumber and status (only fetch data who have placed any order)-(ans=326)
select customername,ordernumber,status 
from customers c inner join orders o
on c.customernumber=o.customernumber;

#wasq to fetch customername paymentdate and amount from customers and payments table
select customername,paymentdate,amount from
customers c inner join payments p
on c.customernumber=p.customernumber;

         #OR 
select customername,paymentdate,amount from
customers c inner join payments p using(customernumber);
#NOTE: use "using" when column name is same also it does not throw ambiguity error

#wasq to fetch emp fullname, customer name ,order date ,product name from multiple tables 
select concat(firstname," ",lastname) as empfullname,customername,orderdate,productname from
employees e inner join customers c on c.salesrepemployeenumber=e.employeenumber inner join orders o on c.customernumber=o.customernumber inner join orderdetails od
on o.ordernumber=od.ordernumber inner join products p on od.productcode=p.productcode;

#wasq to fetch total number of records if we perform full join between two tables product and orderdetails
select count(*) from products p left join orderdetails o
on p.productcode=o.productcode 
union all 
select count(*) from products p right join orderdetails o
on p.productcode=o.productcode where p.productcode is null;

#wasq to fetch emp fullname customer name and product name from different tables
select concat(firstname," ",lastname) as empfullname,customername,productname
from employees e inner join customers c on e.employeenumber=c.salesrepemployeenumber
inner join orders o on o.customernumber=c.customernumber inner join orderdetails od 
on o.ordernumber=od.ordernumber inner join products p 
on od.productcode=p.productcode;

#wasq to retrive the name of customers and eployees who belongs to same city
select customername,concat(firstname," ",lastname) as empname,c.city as shared_city from
customers c inner join employees e on e.employeenumber=c.salesrepemployeenumber
inner join offices o on o.officecode=e.officecode 
where c.city=o.city;

#wasq to fetch cusyomers who have placed order but did not make any payment yet 
select customername from customers c inner join orders o 
on c.customernumber=o.customernumber
left join payments p on c.customernumber=p.customernumber
where o.customernumber is null;

#wasq to fetch employeenumber,empfullname,and customername from customers and employees
#(only fetch the record who belongs to usa and order palced between 2003 and 2004 sort the data by order date 
#most recent to least one);
select employeenumber,concat(firstname," ",lastname)as empfullname,customername
from employees e inner join customers c on c.salesrepemployeenumber=e.employeenumber 
inner join orders o on c.customernumber=o.customernumber 
where c.country="usa" and orderdate between "2003-01-01" and "2004-12-31"
order by orderdate desc;

#SELF JOIN 
select* from employees;
#wasq to fetch manager name along with
#their direct reportee employee name 
SELECT m.employeenumber,concat (m.firstname," ",m.lastname) as manager ,
e.employeenumber ,concat (e.firstname," ",e.lastname) as "direct reportee"
from employees m inner join employees e 
on m.employeenumber= e.reportsto;

#find employees along with jobtitle whose customer have ordered product that start with s18
#display employees who work in same country as any of their customer 

select distinct concat(firstname," ",lastname) as empname,jobtitle
from customers c inner join employees e on c.salesrepemployeenumber=e.employeenumber
inner join orders o on c.customernumber=o.customernumber inner join orderdetails od 
on od.ordernumber=o.ordernumber inner join products p on p.productcode=od.productcode
where p.productcode like "s18%";

select distinct concat(firstname," ",lastname) as empname from
employees e inner join customers c on c.salesrepemployeenumber=e.employeenumber 
inner join offices o on o.officecode=e.officecode
where c.country=o.country;

#wasq to fetch customers who fetch same product as another customer but belongs from a different country --> ans=68420

select distinct c1.customername as customer1,c1.country as country1 ,
c2.customername as customer2,c2.country as country2 ,
od1.productcode from orderdetails od1 join orders o1 on od1.ordernumber=o1.ordernumber
join customers c1 on c1.customernumber=o1.customernumber 
join orderdetails od2 on od1.productcode=od2.productcode 
join orders o2 on od2.ordernumber=o2.ordernumber
join customers c2 on o2.customernumber=c2.customernumber 
where c1.country!=c2.country;