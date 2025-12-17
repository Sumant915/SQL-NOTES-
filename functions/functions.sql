#control flow functions

#question 1:-
#wasq to fetch customername and their ordercount 
#on the basis of ordercount create one custom column 
#name customer_type conditions are :-
#if ordercount is 1 then onetime customer
#if ordercount is 2 then repeated customer
#if ordercount is 3 then frequent customer
#if ordercount >=4 then loyal customer

with cte as (select customername,count(ordernumber)
as ordercount from customers 
inner join orders using(customernumber) group by customername)
select * ,
case ordercount 
when 1 then "one time customer"
when 2 then "Repeated customer"
when 3 then "Frequent customer"
else "Loyal customer"
end as customer_type from cte;


#question 2:-
#wasq to fetch customername and their tov on the basis of tov
#create one custom column customer_type 
#if tov<10000 then silver customer 
#if 10000<tov<100k then gold customer 
#if tov>100000 then platinum customer 

with cty as(
select customername,sum(quantityordered*priceeach) as tov
from customers inner join orders using(customernumber)
inner join orderdetails using(ordernumber) group by customername)
select *,
case 
when tov<10000 then "silver customer"
when tov between 10000 and 100000 then "gold customer"
when tov>100000 then "platinum customer"
end as customer_type from cty;


#QUESTION3
#WASQ TO FETCH TOTAL SALES OF EACH EMPLOYEE ON THE BASIS OF TOTAL SALES
#CREATE ONE CUSTOM COLUMN EMPLOYEE_TYPE 
#top,average,begineer 
#also return their count 

with cte as(
select sum(quantityordered*priceeach) as totalsales ,
concat(firstname,"",lastname) as empname from employees e
inner join customers c on c.salesrepemployeenumber=e.employeenumber
inner join orders using(customernumber) inner join orderdetails using(ordernumber)
group by empname),
cte1 as (
select * ,
case 
when totalsales>200000 and totalsales<500000 then "BEGINEER Employee"
when totalsales>500000 and totalsales<1000000 then "Good Employee"
else "experienced" 
end as emptype from cte)
select emptype,count(*) as typecount from cte1
group by emptype;

#QUESTION4
#wasq to fetch totalordervalue of each productline 
#on the basis of tov create on custom column
#productline_type 
#highest selling product line ,average selling and lowest selling
#product line 
with cte1 as(
select sum(quantityordered*priceeach) as tov ,productline
from products inner join orderdetails using(productcode)
group by productline)
select * ,
case 
when tov>1500000 then "HIGHEST SELLING PRODUCTLINE"
when tov>500000 and tov<1500000 then "AVERAGE SELLING PRODUCTLINE"
else "LOWEST SELLING PRODUCTLINE"
end as Selling_status from cte1;

with cte1 as(
select sum(quantityordered*priceeach) as tov ,productline
from products inner join orderdetails using(productcode)
group by productline),
cte2 as (select * ,
case 
when tov>=1500000 then "HIGHEST SELLING PRODUCTLINE"
when tov>500000 and tov<1500000 then "AVERAGE SELLING PRODUCTLINE"
else "LOWEST SELLING PRODUCTLINE"
end as Selling_status from cte1)
select selling_status ,count(*) as sellingcount
from cte2 group by selling_status;

#QUESTION 5:-
#WASQ TO FETCH ORDER COUNT OF EACH STATUS 
use dummy;
#wasq to fetch ordercount of each status in a single row 
select distinct(status) from orders;

select 
sum(case when status="resolved" then 1 else 0 end) as "resolved",
sum(case when status="cancelled" then 1 else 0 end) as "cancelled",
sum(case when status="on hold" then 1 else 0 end) as "on hold",
sum(case when status="disputed" then 1 else 0 end) as "disputed",
sum(case when status="in process" then 1 else 0 end) as "in process",
sum(case when status="shipped" then 1 else 0 end) as "shipped",
count(*) as ordercount from orders;


#question 6:-

#wasq to fetch no. of products count pf each productline in a single row 
select distinct(productline) from products;

select 
sum(case when productline="classic cars" then 1 else 0 end) as "classic cars",
sum(case when productline="motorcycles" then 1 else 0 end) as "motorcycles",
sum(case when productline="planes" then 1 else 0 end) as "planes",
sum(case when productline="ships" then 1 else 0 end) as "ships",
sum(case when productline="trains" then 1 else 0 end) as "trains",
sum(case when productline="trucks and buses" then 1 else 0 end) as "trucks and buses",
sum(case when productline="vintage cars" then 1 else 0 end) as "vintage cars",
count(*) as productcount from products;


#QUESTION 7:-

#wasq to fetch customernumber,customername ,city,state ,country from customers table 
#sort the customers by state if state is not  null or sort the country in case state is null
use dummy;
with cte as 
(select customername,count(ordernumber) as ordercount from customers 
inner join orders using(customernumber) group by 1),
cte1 as (
select *,
if(ordercount=1,"one time customer",
if(ordercount=2,"repeated customer",
if(ordercount=3,"frequent customer","loyal customer")))
as customer_type from cte)
select customer_type, count(*) as custcount 
from cte1 group by customer_type;


# question 1:-
# wasq to fetch customername and thier ordercount?
# on the basis of ordercount create 1 custom column
# name customer_type conditions are if ordercount is 1
# then 1 time customer,if orderc is 2 then repeated customer
# if oc is 3 then frequent customer
# if ordercount>=4 then loyal customer?

with cte as
(select customername,count(ordernumber)as ordercount from 
customers inner join orders using(customernumber)
group by customername),
cte1 as(
select *,
if(ordercount=1,"one time customer",
  if(ordercount=2,"repeated customer",
    if(ordercount=3,"frequent customer","loyal customer")))
  as customer_type  from cte )
  select customer_type,count(*)as cust_count
  from cte1 group by customer_type;
  
# question 2:-
# wasq to fetch customername and their tov on the basis of tov
# create one custom column customer_type conditions are
# if tov<10k then silver customer
# if tov btw 10k and  100k then gold customer
# if tov>100k then platinum customer?

with cte as
(select customername,sum(quantityordered*priceeach)as tov from
customers inner join orders using(customernumber) inner join orderdetails using(ordernumber)
group by customername),
cte1 as(
select *,
if(tov<10000,"silver customer",
 if(tov between 10000 and 100000,"gold customer","platinum customer"))
 as customer_type from cte)
 select customer_type,count(*)as cust_count
 from cte1 group by customer_type;

# question 3;-
# wasq to fetch total sales of each employee on the basis of ts
# create 1 custom column employee_type
# condtions apne hisab se?

with cte as(
select sum(quantityordered*priceeach)as totalsales,concat(firstname," ",lastname)as empname from
employees e inner join customers c on e.employeenumber=c.salesrepemployeenumber
inner join orders using(customernumber) inner join orderdetails using (ordernumber)
group by empname),
cte1 as(
select *,
if(totalsales between 300000 and 500000,"beginner employee",
  if(totalsales between 500000 and 1000000,"intermediate employee","experienced employee"))
  as employee_type from cte)
select employee_type,count(*)as ecount from cte1
group by employee_type;
 
 
#QUESTION4
#wasq to fetch totalordervalue of each productline 
#on the basis of tov create on custom column
#productline_type 
#highest selling product line ,average selling and lowest selling
#product line 

WITH cte AS (
    SELECT 
        p.productLine,
        SUM(o.quantityOrdered * o.priceEach) AS tov
    FROM 
        products AS p
        INNER JOIN orderdetails AS o 
        USING (productCode)
    GROUP BY 
        p.productLine
)
SELECT 
    productLine,
    tov,
    IF(
        tov >= 1500000,
        'HIGHEST SELLING PRODUCTLINE',
        IF(
            tov > 500000 AND tov < 1500000,
            'AVERAGE SELLING PRODUCTLINE',
            'LOWEST SELLING PRODUCTLINE'
        )
    ) AS selling_status
FROM 
    cte;
    
