create database joins10;
use joins10;

create table table1(id int);
insert into table1 (id)
values(1),(1),(1),(2),(3),(null),(null),(null);

create table table2(eid int);
insert into table2 (eid)
values (1),(1),(2),(4),(null),(null);

select * from table1 cross join table2 ;

select * from table1 inner join table2
on table1.id=table2.eid;

select * from table1 left join table2
on table1.id=table2.eid;

select * from table1 right join table2
on table1.id=table2.eid;

select * from table1 left join table2
on table1.id=table2.eid where table2.eid is null;

select * from table1 right join table2
on table1.id=table2.eid where table1.id is null;

#GROUP BY
#GROUP BY IS A CLAUSE which is used to group rows that have the same values 
#in one or more specified column into a summary row it is typically used with agrregate function
#like (max,min,sum,count,average) to perform calculation on each group and return a single result for each group 

#order of execution in mysql
#from-->where-->groupby-->select-->distinct-->orderby-->limit 

#EXCEPTION IN MYSQL
#aliasing works in group by also 
#from-->where-->select-->distinct-->groupby-->orderby-->limit 

#wasq to fetch customername and their order count
use dummy;
select customername,count(ordernumber) as ordercount from 
customers c inner join orders o 
using (customernumber)
group by customername order by ordercount desc;

#wasq to fetch customername and their total order value 
select customername,sum(quantityordered*priceeach) as ordervalue 
from customers c inner join orders o using(customernumber)
inner join orderdetails od using(ordernumber) group by customername;


#wasq to fetch total no. of orders by each status 
select status ,count(ordernumber) from orders 
group by status;

#wasq to fetch total order value by product line by each order year 
select productline,sum(quantityordered*priceeach) as ordervalue,year(orderdate) as orderyear 
from orderdetails od inner join orders o using(ordernumber) inner join products p using(productcode)
group by productline,orderyear;

#wasq to fetch 	customer count of each country 
select country ,count(customernumber) as customercount from customers
group by country;

#wasq to fetch manager name and their direct reportee count
select concat (m.firstname," ",m.lastname) as manager ,
count(e.employeenumber)  as "direct reportee count"
from employees m inner join employees e 
on m.employeenumber= e.reportsto
group by manager;

#wasq to fetch empfullname and their customer count 
select concat(firstname," ",lastname) as empfullname,count(salesrepemployeenumber) as customercount 
from employees e inner join customers c on e.employeenumber=c.salesrepemployeenumber 
group by empfullname;

#wasq to fetch empfullname and their ordervalue 
select concat(firstname," ",lastname) as empfullname , sum(quantityordered*priceeach) as ordervalue 
from orders o inner join customers c using(customernumber) inner join orderdetails od using(ordernumber) 
inner join employees e on e.employeenumber=c.salesrepemployeenumber
group by empfullname;

#WASQ to fetch status from orders table
select status from orders;

#wasq to fetch distinct status from order table 
select distinct status from orders;

#BASIC GROUP BY CLAUSE 
select status from orders group by status ;

#GROUP BY WITH AGRREGATE FUNCTION 
#SINGLE COLUMN GROUP BY 

#wasq to fetch no. of orders per orderstatus
select status ,count(*) as ordercount from orders
group by status;

#WASQ TO FETCH TOTALORDERVALUE BY STATUS 
select status ,sum(quantityordered*priceeach) as 
totalordervalue from orders inner join orderdetails 
using(ordernumber) group by status ;

#WASQ TO FETCH TOV BY ORDERNUMBER
select ordernumber,sum(quantityordered*priceeach) as tov 
from orderdetails group by 1;

#wasq to fetch totalsales of each orderyear 
select year(orderdate) as orderyear ,sum(quantityordered*priceeach) as tov 
from orders inner join orderdetails 
using(ordernumber)
group by orderyear;

#wasq to fetch customer name and total ampount paid (of each year)
#wasq to fetch productname and their total quantity ordered 
#wasq to fetch product name and their count
#wasq to fetch total sales of each employee in the year 2004
use dummy; 
select customername,sum(amount),year(paymentdate) as paymentyear from customers inner join payments
using (customernumber) group by customername,paymentyear;

select productname,sum(quantityordered) from products inner join orderdetails 
using(productcode) group by productname;

select productname,count(quantityordered) from products inner join orderdetails 
using(productcode) group by productname;

select concat(firstname," ",lastname) as employeename ,sum(quantityordered*priceeach) as totalsales 
from employees e inner join customers c on e.employeenumber=c.salesrepemployeenumber
inner join orders o using(customernumber) inner join orderdetails using(ordernumber)
where year(orderdate)="2004" group by employeename;

#wasq to fetch ordernumber and the no. of items sold per order and total sales 
select ordernumber,sum(quantityordered) as itemsold,
sum(quantityordered*priceeach) as totalsales
from orderdetails group by ordernumber;

#HAVING
#syntax:- select columnlist from tablename 
#         where search condition group by columnname 
#         having grouping condition order by column;

#order of execution :-
#from-->where-->group by-->having-->select-->distinct-->order by-->limit

#wasq to fetch ordernumber , status and totalsales (only fetch the order whose status are shipped
# and totalsales>10000)
select ordernumber,status,sum(quantityordered*priceeach) as totalsales
from orders inner join orderdetails using(ordernumber) group by ordernumber
having status="shipped" and totalsales>10000 ;

#wasq to fetch all the employees and customers they manage but also include 
# employees whose manage no customers additionaly show no. of orders placed by each managed customer 
select concat(firstname," ",lastname) as empname,customername,sum(quantityordered) as NOoforders from employees e 
left join customers c on c.salesrepemployeenumber=e.employeenumber left join orders o using(customernumber)
left join orderdetails using(ordernumber) group by customername,empname;

#find all the productlines where totalrevenue exceed 1 lakh and atleast 10 different product are sold 
select productline,sum(quantityordered*priceeach) as totalsales,count(distinct productname) as td 
from products inner join orderdetails using(productcode)
group by productline
having totalsales>100000 and td>9;

#wasq to fetch customers who placed more than 4 order 
select customername ,count(quantityordered) as ordersplaced from customers inner join orders using(customernumber)
inner join orderdetails using(ordernumber) group  by customername having ordersplaced>4;

#wasq to fetch total ordervalue of each productline of each year
create table sales 
select productline,sum(quantityordered*priceeach) as ordervalue,year(orderdate) as orderyear  from orderdetails 
inner join products using(productcode) inner join orders using(ordernumber) group by productline,orderyear;

select * from sales;

#wasq to fetch totalsales from sales table 
select sum(ordervalue) as grandtov from sales ;

#wasq to fetch gtov of each product line
select productline,sum(ordervalue) as gtov from sales 
group by productline;

#wasq to fetch gtov of each order year
select orderyear,sum(ordervalue) as gtov from sales 
group by orderyear;

#ROLL UP :- only works with group by clause 
select productline,sum(ordervalue) as grandtov from sales
group by productline
union 
select null,sum(ordervalue) from sales;

select productline,sum(ordervalue) from sales
group by productline with rollup;

#wasq to fetch grandtotalorder value by productline of each orderyear 
select productline,orderyear,sum(ordervalue) from sales 
group by productline,orderyear with rollup;

#wasq to fetch grandtotalorder value by orderyear of each productline 
select productline,orderyear,sum(ordervalue) from sales 
group by orderyear,productline with rollup;

#wasq to fetch productline,productname,and total buyprice(also return the grandtotal) of each productline
select productline ,productname,sum(buyprice) as price from products 
group by productline,productname with rollup;
#wasq to fetch  number of customers of each country 
select country,count(customernumber) as totalcustomer from customers 
group by country;

#wasq to fetch totalordervalue of each order number
# of each year (also return grand total)
select sum(quantityordered*priceeach) as tov ,ordernumber,
year(orderdate) as orderyear from orders inner join orderdetails using(ordernumber)
group by orderyear,ordernumber with rollup;

use dummy;
#wasq to fetch total number of customers by each country and filter 
#only those country who have more than 5 customers
 
select count(customernumber) as
totalcustomer,country from 
customers group by
country having totalcustomer>5;

#display total sales for each employee include grandtotal at the end 

select concat(firstname," ",lastname) as empname
,sum(quantityordered*priceeach)
as tov from employees e inner join customers c 
on e.employeenumber=c.salesrepemployeenumber
inner join orders using(customernumber) 
inner join orderdetails using(ordernumber)
group by empname with rollup;

#show total number of orders placed per country and 
#include and include rollup total 

select sum(ordernumber) as totalorder,
country from customers 
inner join orders using(customernumber)
group by country with rollup;

#display average order value per employee based on customers order 
# and list only those with the average above 2500

select avg(quantityordered*priceeach) as avgordervalue,
concat(firstname," ",lastname) as empname ,customername 
from employees e inner join customers c 
on e.employeenumber=c.salesrepemployeenumber 
inner join orders using(customernumber) 
inner join orderdetails 
using(ordernumber) group by empname,
customername having avgordervalue>2500;

#wasq to fetch average buyprice of each product line 

#wasq to fetch sum of total buyprice of each productline 
select avg(buyprice) as averageprice,productline from products 
group by productline;

#wasq to fetch sum of total buyprice of each productline 
select sum(buyprice) as totalbuyprice ,productline from products 
group by productline ;

#wasq to fetch maximum minimum and total order value of each product line
select max(quantityordered*priceeach) as maxivalue,
min(quantityordered*priceeach) as minvalue,
sum(quantityordered*priceeach) as totalvalue 
,productline from orderdetails inner join
products using(productcode)
group by productline;

#wasq to fecth employee fullname and their respective customer name (fetch 
# customer name in a single row as comma separated values)

select concat(firstname," ",lastname) as empname ,customername 
from customers c inner join employees e
on e.employeenumber=c.salesrepemployeenumber;

select concat(firstname," ",lastname) as empname ,group_concat(
distinct customername) as customername 
from customers c inner join employees e
on e.employeenumber=c.salesrepemployeenumber
group by empname;

select concat(firstname," ",lastname) as empname ,group_concat(
distinct customername order by customername desc separator "/") as customername 
from customers c inner join employees e
on e.employeenumber=c.salesrepemployeenumber
group by empname;

#wasq to fecth country and their customer name 
#fetch custoname in single row 
#as csv
select country,group_concat(customername) as customername  
from customers group by country;
