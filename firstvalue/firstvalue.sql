CREATE TABLE overtime (
    employee_name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    hours INT NOT NULL,
     PRIMARY KEY (employee_name,department)
);
INSERT INTO overtime(employee_name, department, hours)
VALUES('Diane Murphy','Accounting',37),
('Mary Patterson','Accounting',74),
('Jeff Firrelli','Accounting',40),
('William Patterson','Finance',58),
('Gerard Bondur','Finance',47),
('Anthony Bow','Finance',66),
('Leslie Jennings','IT',90),
('Leslie Thompson','IT',88),
('Julie Firrelli','Sales',81),
('Steve Patterson','Sales',29),
('Foon Yue Tseng','Sales',65),
('George Vanauf','Marketing',89),
('Loui Bondur','Marketing',49),
('Gerard Hernandez','Marketing',66),
('Pamela Castillo','SCM',96),
('Larry Bott','SCM',100),
('Barry Jones','SCM',65);

# LEAD
#For each order, find the order date and the next order date of the
#same customer.
select customername,orderdate,
lead (orderdate,1,0) over(partition by customername order by orderdate ) as next_orderdate 
from customers inner join orders using(customernumber);

#For each customer, show the order value and the next order’s value.
select customername,sum(quantityordered*priceeach) as ordervalue ,
lead(sum(quantityordered*priceeach),1,0) over (partition by customername order by orderdate) as nextordervalue
from customers inner join orders using(customernumber) inner join orderdetails using(ordernumber)
group by 1,orderdate;

#For each payment, display the payment amount and the next
#payment amount made by that customer.
select customername,amount,
lead(amount,1,0) over (partition by customername order by orderdate asc) as nextamount
from customers inner join payments using(customernumber) inner join orders using(customernumber);

#For each order, show the order date along with the first purchase
#date of that customer.


#For each customer, list the orders along with the first product they
#ever ordered.


#wasq to get employeename overtime and the leastovertime employee
select employee_name,hours,
first_value(employee_name) over(order by hours range between unbounded preceding and current row)
as least_overtime_employee from overtime;

#wasq to fetch employee name overtime and least and highest overtime employee
select employee_name,hours,
first_value(employee_name) over(order by hours asc range between unbounded preceding and current row) as leastovertime_emp,
last_value(employee_name) over(order by hours asc range between current row and unbounded following) as mostovertime_emp 
from overtime;

#wasq to fetch employeename overtime and least and highest overtime employee 
#of each departement
select employee_name,hours,department,
first_value(employee_name) over(partition by department order by hours asc range between unbounded preceding and current row) as leastovertime_emp,
last_value(employee_name) over(partition by department order by hours asc range between current row and unbounded following) as mostovertime_emp 
from overtime;