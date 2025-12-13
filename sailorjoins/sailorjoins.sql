create database joinques;
use joinques;

CREATE TABLE `Sailors` (
  `sid` integer NOT NULL,
  `sname` varchar(10) NOT NULL,
  `rating` integer NOT NULL,
  `age` double NOT NULL
);
INSERT INTO Sailors ( sid, sname, rating, age) 
VALUES 
( 22, 'Dustin', 7, 45.0),
( 29, 'Brutus', 1, 33.0),
( 31, 'Lubber', 8, 55.5),
( 32, 'Andy', 8, 25.5),
( 58, 'Rusty', 10, 35.0),
( 64, 'Horatio', 7, 35.0),
( 71, 'Zorba', 10, 16.0),
( 74, 'Horatio', 9, 35.0),
( 85, 'Art', 3, 25.5),
( 95, 'Bob', 3, 63.5);


CREATE TABLE `Reserves` (
  `sid` integer NOT NULL,
  `bid` integer NOT NULL,
  `day` date NOT NULL
);

INSERT INTO Reserves ( sid, bid, day) 
VALUES 
( 22, 101, '1998-10-10'),
( 22, 102, '1998-10-10'),
( 22, 103, '1998-10-8'),
( 22, 104, '1998-10-7'),
( 31, 102, '1998-11-10'),
( 31, 103, '1998-11-6'),
( 31, 104, '1998-11-12'),
( 64, 101, '1998-9-5'),
( 64, 102, '1998-9-8'),
( 74, 103, '1998-9-8');


CREATE TABLE `Boats` (
  `bid` integer NOT NULL,
  `bname` varchar(10) NOT NULL,
  `color` varchar(10) NOT NULL
);
INSERT INTO Boats ( bid, bname, color) 
VALUES 
(101, 'Interlake', 'blue'),
(102, 'Interlake', 'red'),
(103, 'Clipper', 'green'),
(104, 'Marine', 'red');

#Find the names of sailors who have
#reserved boat 103?
select distinct sname from sailors s inner join reserves r
on s.sid=r.sid  where r.bid=103;

#Find the colors of boats reserved by Lubber?
select color from boats b inner join reserves r 
on b.bid=r.bid inner join sailors s 
on s.sid=r.sid where s.sname="lubber";

#Find the names of sailors who have reserved a red or a green boat?
select sname from sailors s inner join reserves r
on s.sid=r.sid inner join boats b on b.bid=r.bid 
where (b.color="red" or b.color="green");