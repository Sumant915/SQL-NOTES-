# where is a clause used to filter records on the basis of search condition

#syntax:-
#select columnlist from tablename
#where search condition
#orderby columnname asc/desc;

#order of execution
#from-->where--->select-->orderby
#aliasing will not work here because of order of execution

#where clause with equality operator

#wasq to fetch employees detail where job title is sales rep

select*from employees 
where jobtitle="sales rep";

#wasq to fetch employees detail where job title is sales rep and orderby officecode in decending 

select*from employees
where jobtitle="sales rep"
order by officeCode desc;

#wasq to fetch customernumber,customername,and creditlimit belongs to USA
#sort creditlimit in descending order

select customernumber,customername,creditlimit from customers
where country="usa" order by creditlimit desc;

#not equals:- <> or !=

select customernumber,customername,creditlimit from customers
where country!="usa" order by creditlimit desc;

#logical operator:and ,or

#and:-
select employeenumber,firstname,lastname,jobtitle,officecode
from employees where officecode="1" and jobtitle="sales rep";

#or:-
select employeenumber,firstname,lastname,jobtitle,officecode
from employees where officecode="1" or jobtitle="sales rep";

#wasq to fetch the employeenumber,empfullname,officecode
#who belongs to officecode=1,2,3
#and sort data by empfullname in desc;
select employeenumber,concat(firstname," ",lastname) as empfullname,officecode
from employees where officecode="1" or officecode="2 "or officecode="3" 
order by empfullname desc;

#wasq to fetch customernumber and customername
#who belongs to usa,japan and france
select customernumber,customername from customers
where country="usa" or country="japan" or country="france";

#between operator
#between low and high
#and both low and high values are inclusive

#wasq to fetch the employeenumber,empfullname,officecode
#who belongs to officecode=1,2,3
#and sort data by empfullname in desc;
select employeenumber,concat(firstname," ",lastname) as empfullname,officecode
from employees where officecode between 1 and 3
order by empfullname desc;

#wasq to fetch ordernumber,orderdate and status 
#from orders table only fetch records who placed in 2003 and 2004
select ordernumber,orderdate,status from orders 
where orderdate between "2003-01-01" and "2004-12-31";

select ordernumber,orderdate,status from orders 
where orderdate>="2003-01-01" and orderdate<="2004-12-31";

select customername,phone,city,state,country from customers
where creditlimit>10000 and creditlimit<20000;

#wasq to fetch employees detail who belongs to office code 1,3 and 5
#wasq to fetch payment made in 2003 (fetch customernumber,check number ,amount)
#wasq to fetch customers who belongs to usa and have credit limt greater than 15000
#wasq to fetch productname,whose msrp greater than 100

#wasq to fetch employeenumber,empfullname from employees table who belongs to
#office code 1,2,3 and job title are sale representative 
use dummy;

select * from employees
where officecode=1 or officecode=3 or officecode=5;
select * from employees
where officecode in (1,3,5);


#wasq to fetch customername,city,state
#country from customers table who belong to usa ,japan,france
select customername,city,state,country from customers 
where country in ("usa","japan","france");

#IS/ISNOT:-used to fetch null values equality operator ignores null

#wasq to fetch employee number,employee fullname ,job title
#who does not reports to anyone
select employeenumber,concat(firstname," ",lastname) as empfullname,
jobtitle from employees where reportsto is null;

select customername,customernumber,
state,country from customers 
where state is not null order by state asc;

#distinct :-works on single column only
#order of execution:- from-->where--->select-->distinct--->order by

select country from customers;
select distinct country from customers;

select status from orders;
select distinct status from orders;

#LIKE OPERATOR
#pattern matching
#wildcard operator two types:-
#1. %
#2. _underscore

#wasq to fetch customer name whose name start with vowel 
select customername from customers 
where  customername like  "a%" or customername like "e%" or customername like "i%" or customername like"o%" or customername  like"u%";

#wasq to fetch customer name whose name end with vowel 
select customername from customers 
where customername like  "%a" or customername like "%e" or customername like "%i" or customername like"%o" or customername  like"%u";

#wasq to fetch customer name whose name start and end with vowel 
select customername from customers 
where (customername like  "a%" or customername like "e%" or customername like "i%" or customername like"o%" or customername  like"u%") and
(customername like  "%a" or customername like "%e" or customername like "%i" or customername like"%o" or customername  like"%u");

#wasq to fetch customer name whose name do not start with vowel 
select customername from customers 
where (customername not like  "a%" and customername not like "e%" and customername not like "i%" and customername not like"o%" and customername not  like"u%");

#limit:- row count
#order of execcution:- from-->where-->select-->distinct-->order by--->limit

#wasq to fetch customer's detail only fetch first 10 records
select * from customers limit 10;

#wasq to fetch customer name, customer number, and credit limit from customers 
#that return top 5 highest credit limit customer
select customername,customernumber,creditlimit from customers
order by creditlimit desc limit 2 offset 1;

select customername,customernumber,creditlimit from customers
order by creditlimit desc limit 1,2;


select * from customers limit 10 offset 10;

#wasq to fetch customername ,customer number,city,ctsate ,country,and credit limit 
#who belongs to usa france japan and have credit limit morethan 50000 and whose name start with vowel

#wasq to fetch ordernumber,orderdate,status from the orders table only fetch
#the orders placed in 2003 and have shipped status sort the data by orderdate  in ascending order

#wasq to fetch employeenumber,empname,email,officecode,jobtitle from the employees table
#only fetch the record whose name starts with consonant and sort the data by first name in ascending order and then by lastname
# descending

select customername,customernumber,city,state,country,creditlimit from customers
where country in ("usa","japan","france") and creditlimit>50000 and (customername like "a%" or customername like "e%"
or customername like "i%" or customername like "o%" or customername like "u%");

select ordernumber,orderdate,status from orders
where orderdate between "2003-01-01" and "2003-12-31" and status="shipped" order by orderdate asc;

select employeenumber,concat(firstname," ",lastname)as empname,email,officecode
,jobtitle from employees where (firstname not like "a%" and firstname not like "e%" and firstname not like "i%" and
firstname not like "o%"  and firstname not like "u%"  ) order by firstname asc ,lastname desc ;