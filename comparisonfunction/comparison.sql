#COMPARISON FUNCTIONS

#ifnull(value1,value2) --It takes two arguments only 
#Coaslesce(value1,value2....valueN) -- It takes n no. of argument 
#both function return first non null value 
#used for null substituion

use dummy;
select ifnull(null,1);
select coalesce(null,1);

select ifnull(null,null,1);
select coalesce(null,null,1);

select customername,city,state,country from customers;
select customername,city,ifnull(state,"N/A") as state ,country from customers;

select customername,city ,coalesce(state,country) as state ,country from customers;

select customername,city,state,country from customers
order by ifnull(state,country);

#wasq to fetch productname , totalnumber of items sold per order 
#and tov of each productline of year 2004 

select productname,sum(quantityordered) as itemsold,sum(quantityordered*priceeach) as tov
,productline from products  inner join orderdetails using(productcode) inner join orders 
using(ordernumber)
where year(orderdate)=2004
group by productline,productname; 


