#                                                       WINDOWS FUNCTION
use dummy;                                               
CREATE TABLE sales1(
    sales_employee VARCHAR(50) NOT NULL,
    fiscal_year INT NOT NULL,
    sale DECIMAL(14,2) NOT NULL,
    PRIMARY KEY(sales_employee,fiscal_year)
);

INSERT INTO sales1(sales_employee,fiscal_year,sale)
VALUES('Bob',2016,100),
      ('Bob',2017,150),
      ('Bob',2018,200),
      ('Alice',2016,150),
      ('Alice',2017,100),
      ('Alice',2018,200),
       ('John',2016,200),
      ('John',2017,150),
      ('John',2018,250);

SELECT * FROM sales1;

# wasq to fetch total sales 
select sum(sale) as totalsales from sales1;

select *,sum(sale) over() as totalsale from sales1;

#wasq to fecth total sales by fiscal_year
select sum(sale) as totalsales ,fiscal_year from sales1 
group by fiscal_year;

select *,sum(sale)  over(partition by fiscal_year) as totalsales from sales1;

#wasq to fetch total sales by sales_employee
select sum(sale) as totalsales ,sales_employee from sales1 
group by sales_employee; 
                                 
select *,sum(sale) over (partition by sales_employee) as totalsales from sales1;

#wasq to fetch total buyprice maximum buyprice and average buyprice of each productline 
#with help of window fun;

select productname,productline,
sum(buyprice) over(partition by productline) as total_buyprice,
max(buyprice) over (partition by productline) as maximum_buyprice,
avg(buyprice) over (partition by productline) as average_buyprice ,
min(buyprice) over (partition by productline) as minimum_buyprice
from products; 

#WASQ TO FETCH ORDERCOUNT OF EACH COUNTRY BU EACH YEAR 
select count(ordernumber) as ordercount,country,year(orderdate) as orderyear from orders inner join customers
using (customernumber) group by country,orderyear;

select ordernumber,customernumber,country,year(orderdate) ,
count(ordernumber) over(partition by country,year(orderdate)) as ordercount
from customers inner join orders using (customernumber);



# RANK WINDOW FUNCTION

#WASQ TO GIVE SEQUENTIAL NUMBER TO PRODUCTS TABLE 
select *, row_number() over () as r_no from products;
select row_number() over () as r_no ,p.* from products p;

#wasq to give seqential number to each product line in products table
 select row_number() over(partition by productline ) as r_no 
 ,p.* from products p;
 
 #wasq to fetch top buy price products of each productline
 with cte as(
 select productline,productname,buyprice,
 row_number() over (partition by productline order by buyprice desc) as r_no
 from products)
 select * from cte where r_no=1;
 
 # wasq to fetch highest ordervalue customer of each country
 with cte as (
 select 
 dense_rank() over (partition by country order by sum(quantityordered*priceeach) desc) as dr,
 c.customername,o.ordernumber,o.quantityordered,c.country,sum(quantityordered*priceeach) as ordervalue
 from customers c
 inner join orders  using(customernumber) 
 inner join orderdetails o using(ordernumber) group by o.ordernumber,o.quantityordered)
 select * from cte where dr=1;
 
 #wasq to fetch least selling product of each productline 
 with cte as(
 select 
 rank() over(partition by productline order by sum(o.quantityordered)) as rn ,
 p.productname ,sum(o.quantityordered),p.productline from products p inner join orderdetails o using(productcode) group by 1,3)
 select * from cte where rn=1;
 
 
 #wasq to fetch second and third highest quantity ordered product of each product line 
 
 with cte as(
 select 
 dense_rank() over(partition by productline order by sum(quantityordered) desc) as dr,
 p.productline,p.productname,sum(o.quantityordered) as totalquantity from products p inner join orderdetails o using(productcode)
 group by p.productline,p.productname)
 select * from cte where dr=2 or dr=3;
 
 #wasq to fetch third highest ordercount customer of each year 
 
 with cte as(
 select count(o.ordernumber) as ordercount,year(o.orderdate) as order_year,c.customername ,
 dense_rank() over(partition by year(o.orderdate) order by count(o.ordernumber) desc) as dr
 from customers c inner join orders o using(customernumber) group by c.customername,year(o.orderdate))
 select * from cte where dr=3;
 
 
 # wasq to fetch least ordercount customer of each year of each country 
 with cte as(
 select 
 dense_rank() over(partition by c.country,year(o.orderdate) order by count(ordernumber)) as dr,
 c.customername,c.country,year(o.orderdate) as orderyear ,count(ordernumber) as ordercount 
 from customers c inner join orders o using(customernumber)
 group by c.customername,orderyear,c.country)
 select * from cte where dr=1;
 
 #wasq to fetch second highest employee (according to total sales ) of each year 
 with cte as(
 select 
 concat_ws(" ",e.firstname,e.lastname) as empname,sum(od.quantityordered*od.priceeach) as totalsales,
 year(o.orderdate) as orderyear ,
 dense_rank() over(partition by year(o.orderdate) order by sum(od.quantityordered*od.priceeach) desc) as dr
 from employees e inner join customers c on e.employeenumber=c.salesrepemployeenumber
 inner join orders o using(customernumber) inner join orderdetails od using(ordernumber)
 group by empname,orderyear)
 select * from cte 
 where dr=2;
 
 #WASQ TO FETCH ORDERNUMBER,PRODUCTCODE AND THEIR ORDERVALUE ONLY FETCH THE RECORD WHOSE ORDERVALUE BETWEEN 2K AND 3K
 # AND SORT THE DATA BY ORDERVALUE IN DESC 
 
 select ordernumber,productcode,
 quantityordered*priceeach as ordervalue 
 from orderdetails where quantityordered*priceeach between 2000 and 3000
 order by ordervalue desc;
 
 #wasq to fetch top 2 manager name by number of employee they manage 
 #with help of dense rank 
 
 with cte as(
 select 
 concat_ws(" ",m.firstname,m.lastname) as managername,
 count(e.reportsto) as empcount,
 dense_rank() over(order by count(e.reportsto) desc) as dr
 from employees e inner join employees m
 on e.reportsto=m.employeenumber group by 1)
 select * from cte where dr<3;
 
 
 # WASQ TO FETCH  CUSTOMERNAME,AND THEIR TOV OF EACH QUARTER OF EACH COUNTRY(FETCH SECOND AND THIRD HIGHEST)
 with cte as(
 select 
 c.customername,sum(od.quantityordered*od.priceeach) as tov ,c.country,quarter(o.orderdate),
 dense_rank() over 
 (partition by c.country,quarter(o.orderdate) order by sum(od.quantityordered*od.priceeach) desc) as dr
 from customers c inner join orders o using(customernumber) inner join orderdetails od using(ordernumber)
 group by c.customername,c.country,quarter(o.orderdate))
 select * from cte where dr in (2,3);
 
 #wasq to find percentile rank of every productline by total sales 
 # and also round off the percent rank upto 2 decimal places 
 
 select productline,sum(quantityordered*priceeach) as totalsales,
 round(percent_rank() over( order by sum(quantityordered*priceeach)),2) as percentrank
 from orderdetails inner join products using(productcode) group by 1;
 
 
 #wasq to find percentile rank of employees by total sales of each orderyear 
 
 select 
 concat_ws(" ",firstname,lastname) as empname ,
 sum(quantityordered*priceeach) as totalsales ,year(orderdate) as orderyear,
 round(percent_rank() over (partition by year(orderdate) order by sum(quantityordered*priceeach)),2)
 as percentrank from employees inner join customers on salesrepemployeenumber=employeenumber
 inner join orders using(customernumber) inner join orderdetails using (ordernumber)
 group by 1,3;
 
 #wasq to find percentile rank of usa each year totalsales
 with cte as(
 select 
 country,sum(quantityordered*priceeach) as totalsales,customername,
 round(percent_rank() over (partition by year(orderdate) order by sum(quantityordered*priceeach)),2)
 as percentrank 
 from customers inner join orders using(customernumber) inner join orderdetails using(ordernumber) 
 where country='usa'
 group by 1,3,year(orderdate))
 select * from cte where percentrank>=0.50;
 
 # WASQ TO FETCH TOTAL SALES DIFFERENCE BETWEEN CURRENT YEAR AND THE PREVIOUS YEAR
 #OF EACH PRODUCTLINE OF EACH YEAR 
 
 with cte as(
 select 
 productline,year(orderdate),sum(quantityordered*priceeach) as currentsales ,
 lag(sum(quantityordered*priceeach),1,0) over (partition by productline  order by year(orderdate) asc) as lastyearsales
 from orderdetails inner join orders using(ordernumber) inner join products using(productcode)
 group by 1,year(orderdate))
 select *,currentsales-lastyearsales as sales_diff from cte;
 
 
 
 # WASQ FOR EACH CUSTOMERORDER FIND THE ORDERAMOUNT ALONG WITH PREVIOUS ORDER AMOUNT 
 select customername,(quantityordered*priceeach) as currorderamt,
 lag((quantityordered*priceeach),1,0) over (partition by customername order by (quantityordered*priceeach) ) as prevordamt
 from customers inner join orders using(customernumber) inner join orderdetails using(ordernumber);
 
 
 
  # FOR EACH ORDER SHOW THE DAYDIFFEERNENCE BETWEEN CURRENT ORDERDATE AND PREVIOUS ORDERDATE OF SAME CUSTOMER
  with cte as(
  select ordernumber,customername,orderdate as currorderdate,
  lag((orderdate),1,0) over (partition by customername order by orderdate) as prevorderdate
  from customers inner join orders using(customernumber) )
  select *,datediff(currorderdate-prevorderdate) as day_difference
  from cte;
  
  
  #FOR EACH PAYMENTS DISPLAY THE PAYMENT AMOUNT AND PREVIOUS PAYMENT AMOUNT MADE BY THAT CUSTOMER 
  select customername,paymentdate,amount as currpaymentamt,
  lag(amount,1,0) over(partition by customername order by paymentdate) as prevpaymentamt
  from payments inner join customers using(customernumber);
  
  
  #1. Retrieve all employees and the customers they manage
  #but also include employees who manage no customers.
   #Additionally, show the number of orders placed by each
   #managed customer.
   select concat_ws(" ",firstname,lastname) as empname,customername,count(ordernumber) as totalorders 
   from customers c left join employees e on c.salesrepemployeenumber=e.employeenumber
   inner join orders using(customernumber) group by 1,2;

#2. Find customers who have never placed an order and also
#show their assigned sales representative (if any).
select customername,concat_ws(" ",firstname,lastname) as empname
from customers c inner join employees e on c.salesrepemployeenumber=e.employeenumber
left join orders o using(customernumber) where o.customernumber is null;

#3. List all products and the orders they appear but also
#include products that have never been ordered.
select productname,ordernumber
from products p left join orderdetails o using(productcode);

#4. Using a SELF JOIN on the employees table, display each
#employee and the name of their direct manager.
select concat_ws(" ",e.firstname,e.lastname) as empname,concat_ws(" ",m.firstname,m.lastname) as mangername
from employees e inner join employees m on m.employeenumber=e.reportsto;

#5. Identify employees who have the same manager and
#group them together using GROUP_CONCAT.
select concat_ws(" ",m.firstname,m.lastname) as managername,
group_concat(concat_ws(" ",e.firstname,e.lastname)) as empname
from employees m inner join employees e on m.employeenumber=e.reportsto group by 1;

#6. For each customer, calculate the total order value and
#return only customers whose total value is greater than
#the average order value of all customers.

with cte as(
select customername,sum(quantityordered*priceeach) as tov
from customers inner join orders using(customernumber)
inner join orderdetails using(ordernumber) group by 1)
select customername ,tov
from cte where tov>avg(sum(tov));

#7. Find all product lines where the total revenue exceeds
#100,000 and at least 10 different products are sold .
select productline,sum(quantityordered*priceeach) as total_revenue ,count(distinct productname) as uniqueorder
from products inner join orderdetails using(productcode)
group by 1 having total_revenue>100000 and count(distinct productname) >10;

#8For each order, show a comma-separated list of product
#codes (GROUP_CONCAT) and order them by quantity
#ordered (highest first).
select ordernumber,group_concat(productcode order by quantityordered desc) as productcodes
from orderdetails inner join products using(productcode) 
group by 1;

#9. Show each employee and a comma-separated list of all
#the distinct product lines their customers have
#purchased.
select concat_ws(" ",firstname,lastname) as empname,
group_concat(distinct productline) as productlines
from employees e inner join customers c on e.employeenumber=c.salesrepemployeenumber
inner join orders using(customernumber) inner join orderdetails using(ordernumber)
inner join products using(productcode) group by 1;

#10Extract the country code (first 3 letters) from each
#customer’s phone number, and group customers by
#country code, showing total orders placed.
select substr(phone,1,3) as countrycode,
sum(quantityordered*priceeach) as tov from customers
inner join orders using(customernumber)inner join orderdetails using(ordernumber)
group by countrycode;

#11 display the customername reversed and show first 3 characters
select substr(reverse(customername),1,3) as custo_name from customers;

#12 for each year find the month with maximum totalrevenue and display that month along with revenue
with cte as (
select year(orderdate),monthname(orderdate),sum(quantityordered*priceeach) as tov,
dense_rank() over(partition by year(orderdate) order by sum(quantityordered*priceeach) desc) as d_rn
from orderdetails inner join orders using(ordernumber) group by year(orderdate),monthname(orderdate))
select * from cte where d_rn=1;

#13. List all customers whose first order was placed in
#the first quarter (Q1) of any year, and also show the day
#of the week they first ordered.

with cte as(
select customername,quarter(orderdate) as quarter_no,year(orderdate),
dense_rank() over(partition by customername,year(orderdate) order by year(orderdate)) as d_rn
from customers innner join orders using(customernumber))
select * from cte where d_rn=1 and quarter_no=1;
 
#14.Rank customers by total purchase amount (using
#RANK()), then classify them into quartiles (Q1, Q2, Q3,
#Q4) using CASE WHEN.



#15For each customer, display their order history along
#with the difference in days between consecutive orders
#(using LAG()), and highlight with CASE WHEN if the gap is
#more than 30 days.
