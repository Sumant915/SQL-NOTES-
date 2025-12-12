use dummy;

#select 
select 1+1;
select 10*5;
select now();

select concat("decode"," ","data"," ","bhopal") as fullname;

#select from
#used to fetch data/records from particular table
#synatax
#select columnlist/*/expression from tablename;

#order of execution
# from---->select;

#wasq to fetch customername and customernumber from customers table;

select customername,customernumber from customers;

#wasq to fetch employees emp fullname , employee number , job title from emplyees table;
select employeenumber,concat(firstname," ",lastname) as empfullname,jobtitle from employees;

#wasq to fetch order number and their order value from order details
select ordernumber,productcode,(quantityordered*priceeach) as ordervalue from orderdetails;

#wasq to fetch customer full name ,city,state ,country,creditlimit from customers table;
#wasq to fetch product name, product line ,msrp,buyprice from products table
#wasq to fetch customer number ,check numbler,amount and payment date from payments table 
#wasq to fetch order number ,order date , ship date ,status from orders table
#wasq to fetch order number ,order line number,quantity ordered and order value 
select concat(contactfirstname," ",contactlastname) as fullname,city ,state ,country,creditlimit from customers;
select productname ,productline,msrp,buyprice from products;
select customernumber,checknumber,amount,paymentdate from payments;
select ordernumber,orderdate,shippeddate,status from orders;
select ordernumber,orderlinenumber,quantityordered,(priceeach*quantityordered) as ordervalue from orderdetails;
