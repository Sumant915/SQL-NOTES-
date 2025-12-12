#order by is a clause used to sort the result set
#syntax--> select col1,col2....colN from tablename 
#          order by col1[asc/desc],col2[asc/desc]...colN[asc/desc]
#order of execution: from-->select-->order by (note: aliasing works in orderby)
#by default:ascending order
use dummy;
#single column sorting

#wasq to fetch contactlastname,contactfirstname from the customers table and sort the data 
# by contact last name in ascending order
select contactfirstname,contactlastname  from customers 
order by contactlastname;

#wasq to fetch customername , city state country and credit limit from customers table and sort the data by highest to lowest credit 
#limit 
select customername,city,state,country,creditlimit from customers
order by creditlimit desc;

#MULTIPLE COLUMN SORTING

#wasq to fetch contactlastname,contactfirstname from customers table and sort
#the record by contactlastname in descending order then by contactfirstname in ascending order
select contactlastname ,contactfirstname from customers
order by contactlastname desc,contactfirstname;

#wasq to fetch ordernumber and their ordervalue from orderdetails table sort the
#data by ordervalue in descending order
select ordernumber,(quantityordered*priceeach) as ordervalue from orderdetails 
order by ordervalue desc;

#wasq to fetch employfullname,jobtitle,officecode from employees table
#sort the data by officecode in ascending order then by jobtitle in descending order and then 
#by employfullname in alphabetical order
select concat(firstname," ",lastname) as fullname,jobtitle,officecode from employees
order by officecode asc,jobtitle desc,fullname  asc;

#order by 
#null smallest

#wasq to fetch employees detail and sort the result set by reportsto in ascending order
select * from employees 
order by reportsto asc;

#wasq that fetch ordernumber ,orderdate,and status sort the data by order date from most recent to earliest
select ordernumber,orderdate,status from orders 
order by orderdate desc;