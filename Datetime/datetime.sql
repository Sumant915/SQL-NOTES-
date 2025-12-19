#DATE TIME FUNCTION 
select sysdate();
select now(); #datetime server 
select current_timestamp();  #timestamp 

select current_date();
select current_time();

#now() and sysdate()
select sysdate(),sleep(10),sysdate();
select now(),sleep(10),now();

#datediff()
#datediff(enddate,startdate) :- return no. of days 

select datediff(now(),'2023-11-12'); #return days
select datediff(now(),'2023-11-12')/365; #return year
select datediff(shippeddate,orderdate),status from orders;

#extract
select year(now());
select quarter(now());
select month(now());
select monthname(now());
select week(now());
select weekday(now());
select day(now());
select dayname(now());
select date(now());
select time(now());
select hour(now());
select minute(now());
select second(now());

#find no of days between required date and ship date of each order 
select datediff(requireddate,shippeddate),ordernumber from orders;

#wasq to get all orders whose status are in process and calculate the no. of days between orderdate 
#and required date 
select ordernumber,datediff(requireddate,orderdate) from orders 
where status='in process';

#calculate the days between orderadte and shipdate and display "N/A" when ship date isnull
select ifnull(datediff(shippeddate,orderdate ),'N/A') as countdays from orders;

#wasq to get ordercount for each quarter of the year 2004 
select count(ordernumber) as ordercount ,quarter(orderdate) as quarter
from orders where year(orderdate)='2004' group by quarter;

#wasq to get ordercount of each quarter of each year 
select count(ordernumber) as ordercount ,quarter(orderdate) as quarter,year(orderdate) as orderyear 
from orders  group by orderyear,quarter;

#wasq to get ordercount of each quarter 
select count(ordernumber) as ordercount ,quarter(orderdate) as quarter
from orders  group by quarter;

#wasq to fetch tov by monthname of each year 
select sum(quantityordered*priceeach) as tov , monthname(orderdate) as ordermonth,
year(orderdate) as orderyear from orderdetails inner join orders using(ordernumber)
group by orderyear,ordermonth;

#wasq to get no. of orders per week in the year 2003 and 2004 
select count(ordernumber) as ordercount ,week(orderdate) as orderweek,year(orderdate) as orderyear
from orders where year(orderdate)='2004' or year(orderdate)='2003' group by orderyear,orderweek;

select count(ordernumber) as ordercount ,week(orderdate) as orderweek,year(orderdate) as orderyear
from orders group by orderyear,orderweek having orderyear in (2003,2004);

#string to date 

select str_to_date("12112000","%d%m%Y");
select str_to_date("12/11/2000","%d/%m/%Y");
select str_to_date("201234","%H%i%s");
select str_to_date("14","%H");

select ordernumber,
date_format(orderdate,"%Y-%m-%d"),
date_format(requireddate,"%a %d %b %Y"),
date_format(shippeddate,"%W %d %M %Y") 
from orders;