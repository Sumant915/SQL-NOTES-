#string functions

#concat(string1,string2.....stringN)
select customername,
concat(city,"",state,"",country,"",postalcode) as customerfulladd 
from customers;

#concat_ws(separator,string1,string2,.....stringN)
#WS:- with separator
#it works on non null values only
select customername,
concat_ws(" ",city,state,country,postalcode) as custfullad 
from customers;

#upper(string) :- converts string to uppercase 
select upper(customername) from customers;


#lower(string):-converts string to lowercase 
select lower(customername) from customers;

#len(string):- counts length of characters 
select length(textdescription),productline from productlines;

#reverse(string)
select reverse("decode");

#trim(string)
#is used for removing unwanted leading and trail white
#spaces from given string 
select trim("   decode   data   ");
select length(trim("   decode   data   "));

#ltrim
select ltrim("   decode   data   ");
select length(ltrim("   decode   data   "));

#rtrim
select rtrim("   decode   data   ");
select length(rtrim("   decode   data   "));


#replace (string,oldsubstring,newsubstring)
select replace("welcome to bhopal","bhopal","city of lakes");
select replace("welcome to bhopal","o","a");

#wasq to fecth employee fullname and their respective customer fullname 
#and also fetch their total ov of year 2003

select concat_ws(" ",contactfirstname,contactlastname) as custfullname,
concat_ws(" ",firstname,lastname) as empfullname ,sum(quantityordered*priceeach) as tov 
from employees e inner join customers c on e.employeenumber=c.salesrepemployeenumber
inner join orders using(customernumber) inner join orderdetails using(ordernumber)
where year(orderdate)=2003
group by custfullname,empfullname;


# extract substring from given string.
# left(string,length)- 
# extract substring from left hand side of string.
#right(string,length)
# extract substring from right side side of the string.
# substring(string,offset,length)
# extract substring from given string.
use dummy;
select left("decode",3);
select right("bhopal",3);
select substring("decode",1,3);
select substring("decode",-3,3);

# wasq to fetch customername whose name start and end with vowels?
select customername from customers
where left(customername,1) in ("a","e","i","o","u")
and right(customername,1) in ("a","e","i","o","u");

select customername from customers
where substring(customername,1,1) in ("a","e","i","o","u") 
and substring(customername,-1,1) in ("a","e","i","o","u");

#wasq to fetch employees fullname whose firstname start with
# vowel and last name ends with consonant
#with help of substring function
select concat_ws(" ",firstname,lastname) as empfullname from 
employees where substring(firstname,1,1) in ("a","e","i","o","u") and
substring(lastname,-1,1) not in ("a","e","i","o","u");

#instr(string,substring):

select instr("welcome to bhopal","w");
select instr("welcome to bhopal","bho");
select instr("welcome to bhopal","bhopal");
select instr("welcome to bhopal","o");
select instr("decode","z");   #if not found it returns 0

#wasq to fetch prodcutname that contain car keyword in it (with help if instr())
select productname from products 
where instr(productname,"car");