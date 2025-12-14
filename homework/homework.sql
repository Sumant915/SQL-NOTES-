use dummy;

# question1 - display no. of customer in each country 
select count(customernumber) ,country from customers group by country;

# question2 -Show total quantity ordered for each productCode from the
#orderdetails table.
select sum(quantityordered),productcode from orderdetails group by productcode;

#question3 -Find the total sales amount (quantityOrdered * priceEach) for
#each orderNumber.
select ordernumber,sum(quantityOrdered * priceEach) as totalsales from orderdetails
group by ordernumber;

#question4-List each employee (salesRepEmployeeNumber) and the
#number of customers they manage.
select concat(firstname," ",lastname) as empname ,count(customernumber) as customercount 
from employees e inner join customers c on e.employeenumber = c.salesrepemployeenumber
group by empname;

#question5-Show the count of customers in each country, but only include
#countries having more than 5 customers. (GROUP BY + HAVING)
select count(customernumber) as customercount,country from customers 
group by country having customercount>5;

#question6 -Display productCode and average priceEach, but only include
#products where average price is greater than 100..
select productcode,avg(priceeach) as avgprice from products inner join orderdetails using(productcode)
group by productcode having avgprice>100;

#question7 -Show the total quantity ordered per productCode, but only
#include products ordered more than 500 units.
select sum(quantityordered) as totalqty,productcode from products 
inner join orderdetails using(productcode) group by productcode having totalqty>500;

#question8- Display each country and total sales value generated from
#customers in that country.
select country,sum(quantityordered*priceeach) as totalsales from customers 
inner join orders using(customernumber) inner join orderdetails using(ordernumber)
group by country;

#question9 -Show count of customers grouped by both country and city.
select count(customernumber) as customercount ,country,city from customers
group by country,city;

#question10 -Show the number of orders placed for each productCode
#and include only those products having more than 20 total
#orders.
select count(ordernumber) as ordersplaced ,productcode
from products inner join orderdetails using(productcode) 
group by productcode having ordersplaced>20;

#question11- Display total order value grouped by year of orderDate
#(use YEAR() + GROUP BY).
select sum(quantityordered*priceeach) as tov ,year(orderdate) as orderyear from
orders inner join orderdetails using(ordernumber) group by orderyear;

#questions12- Show each employeeNumber and total sales generated
#from their assigned customers (no subqueries allowed →
#requires multi-table join + GROUP BY only).
select employeenumber ,sum(quantityordered*priceeach) as tov,customername from customers c 
inner join employees e on c.salesrepemployeenumber=e.employeenumber inner join orders using(customernumber)
inner join orderdetails using(ordernumber) group by employeenumber,customername;

#question13- Show the count of products ordered for each
#orderNumber, but only include orders having more than 10
#distinct products.
select count(distinct productcode) as productcount ,ordernumber 
from orderdetails group by ordernumber having productcount>10;

#question14- Show total sales grouped by country and city, and include
#ROLLUP so output contains: (country, city totals + country
#totals + grand total).
select sum(quantityordered*priceeach) as totalsales ,country,city
from customers inner join orders using(customernumber) inner join orderdetails 
using(ordernumber) group by country,city with rollup;

#question15 -Display total quantity ordered for each productCode with
#ROLLUP (show each product total + final total).
select sum(quantityordered) as totalqty,productcode from orderdetails
group by productcode with rollup;

#question16- Show number of customers grouped by country, city, and
#state, and include ROLLUP for all 3 levels.
select count(customernumber) as customercount ,country,city,state from customers 
group by country,city,state with rollup;

#question17- Show the number of employees per officeCode, including
#office total and grand total using ROLLUP.
select count(employeenumber) as empcount ,officecode from employees 
group by officecode with rollup;

#question18- Show total sales per employeeNumber and include
#ROLLUP to show grand total sales for all employees.
select sum(quantityordered*priceeach) as totalsales , employeenumber from 
employees e inner join customers c on c.salesrepemployeenumber=e.employeenumber 
inner join orders using(customernumber) inner join orderdetails using(ordernumber) 
group by employeenumber with rollup;

#question19 -Show total quantity ordered grouped by productCode and
#orderNumber using GROUP BY with ROLLUP (should produce
#product totals and full grand total).
select sum(quantityordered) as totalqty ,productcode,ordernumber
from orderdetails group by productcode,ordernumber with rollup;

#question20- Show the number of products ordered per orderNumber
#but include a ROLLUP to show a final summary row for total
#records.
select count(productcode) as totalorder,
ordernumber from orderdetails
group by ordernumber with rollup;