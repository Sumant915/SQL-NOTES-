#SUBQUERY

#wasq to fetch maximum amount from payments table 

select customernumber,checknumber,
max(amount) from payments group by 1,2;

select customernumber,checknumber
from payments where amount=(select max(amount) from payments);

#wasq to fetch customer customernumber and amount of a customer 
#whose amount is more than avg amount
select customernumber,amount from payments 
where amount>(select avg(amount) from payments);

#wasq to fetch customer detail who have not placed any order 
select customernumber from customers 
where customernumber not in (select distinct customernumber from orders);

#wasq to fetch product whose buyprice is more than average buy price of all product 
select productname,buyprice from products
where buyprice>(select avg(buyprice) from products);

#wasq to fetch employeenumber,employeename,who have not managed and customer 
select employeenumber,concat_ws(" ",firstname,lastname)as employeename from employees
where employeenumber not in (select salesrepemployeenumber from customers);

#wasq to fetch productname that have not been sold 
select productname from products
where productcode not in (select productCode from orderdetails);

#wasq to fetch productline whose tov is greater 
#than avg order value of all productline 
select productline,sum(quantityordered*priceeach) as tov 
from products inner join orderdetails using(productcode) 
group by 1
having 
sum(quantityordered*priceeach) >
(select sum(quantityordered*priceeach) /(select count(distinct productline) from products) from orderdetails);

select sum(quantityordered*priceeach)/7 from orderdetails;


#1wasq to fetch second and third highest product of each productline 


#2. wasq to fetch customername and their ordercount on basis of ordercount 
# create one custom column customer_type conditions are:-
# if ordercount is 1 than onetime customer
#if ordercount is 2 than repeated customer
#if ordercount is 3 than frequent customer
#if ordercount is >=4 than loyal customer

#3.wasq to fetch first and second least qty sold products of each productline of each year
select * from(
select productline,productname,year(orderdate) as orderyear,
dense_rank() over(partition by productline,year(orderdate) order by sum(quantityordered) asc) as d_rn
from products inner join orderdetails using(productcode)
inner join orders using(ordernumber) group by 1,2,productline,year(orderdate)) derived
where d_rn in(1,2);

#4.wasq to fetch second highest employee by totalsales of each orderyear 

select * from(
select concat_ws(" ",firstname,lastname) as empname ,year(orderdate) as orderyear,
sum(quantityordered*priceeach) as totalsales,
dense_rank() over (partition by year(orderdate) order by sum(quantityordered*priceeach) desc) as d_rn
 from employees e inner join customers c
on e.employeenumber=c.salesrepemployeenumber inner join orders using(customernumber) 
inner join orderdetails using(ordernumber) group by 1,2) as child 
where d_rn =2;

#5.wasq to fetch customername and their tov on the basis of tov create one custom column
# customer_type conditions are:-
# if tov<10k than silver customer
# if tov between 10k and 100k than gold customer 
#if tov >100k than platinum customer 
#final otput will be count of customer_type(using subquery)

select cust_type,count(*) as cust_count 
from
(select *, case 
when tov<10000 then "Silver customer"
when tov>=10000 and tov<100000 then "Gold Customer"
else "Platinum Customer" end as cust_type from
(select customername,sum(quantityordered*priceeach) as tov 
from customers inner join orders using(customernumber) inner join 
orderdetails using(ordernumber) group by 1) as derived1) derived2 group by 1;

#6. wasq to fetch second and third highest customer by amountpaid of each payment year
#  using subquery 
select * from 
(select customername,year(paymentdate) as orderyear,sum(amount),
dense_rank() over(partition by year(paymentdate) order by sum(amount) desc) as d_rn
from customers inner join payments using(customernumber) group by 1,2,year(paymentdate)) as child
where d_rn in (2,3);

#7. wasq to give percentile rank to each customer by ordercount of each orderyear using subquery

select customername,count(ordernumber),year(orderdate) as orderyear,
round(percent_rank() over(partition by year(orderdate) order by count(ordernumber)),2) as percentile_rank
from customers inner join orders using(customernumber) 
group by 1,3;