#standard insertion method
#single record insertion
#insert into tablename(colname1,colname2,colname3.....colnameN)
#values(dv1,dv2....dvN);

insert into stu(stu_id,sname,city,fees,d_o_b,mobile)
values(1,"abc","bhopal",45000,"2000-10-02","+916264410764");

select * from stu;

#multiple record insertion 

insert into stu(stu_id,sname,city,fees,d_o_b,mobile)
values (2,"pqr","bhopal",46000,"2000-12-23","+919263723456"),(3,"xyz","indore",47000,"2000-07-16","+919876543218"),
(4,"ast","ujjain",50000,"2000-10-16","+919162364578");

select * from stu;

#extension method
insert into stu 
set stu_id=5,sname="rrr",city="sehore",fees=50000,d_o_b="2000-02-02",mobile="+916478378787";

#update
#update tablename set columnname="newdatavalue"
#where primarykeycol=value;

update stu set sname="decode"
where stu_id=1;

#by default sql_safe_updates=1 so this update command will give error 1175

set sql_safe_updates=0;
select*from stu;

#delete 
#delete from tablename where primarykeycolname=dv;
delete from stu where stu_id=1;

select*from stu;
rollback;

start transaction;
delete from stu;
rollback;

#truncate table tablename

truncate table stu;
select*from stu;

#drop table
#drop table tablename

drop table stu;

#drop database database name 

drop database schooldb1;
