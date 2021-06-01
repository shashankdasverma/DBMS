create database Supplier;
use Supplier;

create table SUPPLIERS (
sid integer
primary key,
sname varchar(20),
city varchar(20)
);

desc SUPPLIERS;

create table PARTS(
pid integer primary key,
pname varchar(20),
color varchar(10)
);

desc PARTS;

create table CATALOG (
sid integer,
pid integer,
foreign key(sid) references SUPPLIERS(sid),
foreign key(pid) references PARTS(pid),
cost float(6),
primary key(sid,pid)
);

desc CATALOG;


insert into suppliers value (10001,'Acme Widget','Bangalore');
insert into suppliers value (10002,'Johns','Kolkata');
insert into suppliers value (10003,'Vimal','Mumbai');
insert into suppliers value (10004,'Reliance','Delhi');
insert into suppliers value(10005,'Mahindra','Mumbai');

select * from SUPPLIERS;

commit;

insert into PARTS values(20001,'Book','Red');
insert into PARTS values(20002,'Pen','Red');
insert into PARTS values(20003,'Pencil','Green');
insert into PARTS values(20004,'Mobile','Green');
insert into PARTS values(20005,'Charger','Black');

select * from PARTS;

commit;

insert into CATALOG values(10001,'20001','10');
insert into CATALOG values(10001,'20002','10');
insert into CATALOG values(10001,'20003','30');
insert into CATALOG values(10001,'20004','10');
insert into CATALOG values(10001,'20005','10');

insert into CATALOG values(10002,'20001','10');
insert into CATALOG values(10002,'20002','20');

insert into CATALOG values(10003,'20003','30');

insert into CATALOG values(10004,'20003','40');

select * from CATALOG;
 
 commit;

 -- i. Find the pnames of parts for which there is some supplier.

insert into parts values(5,'tiles','blue');
select p.pname from parts p where p.pid in
 (select pid from catalog c group by c.pid having count(c.sid)>0);
insert into catalog values(1,5,140);
select p.pname from parts p where p.pid in
 (select pid from catalog c group by c.pid having count(c.sid)>0);
delete from catalog where pid=5;
delete from parts where pid=5;


-- ii. Find the snames of suppliers who supply every part. 

select s.sname from suppliers s where s.sid in 
(select c.sid from catalog c 
group by c.sid having count(distinct (c.pid))=(select count(p.pid) from parts p));


-- iii. Find the snames of suppliers who supply every red part.

select s.sname from suppliers s where s.sid in
 (select ca.sid  from catalog ca,
 parts p where ca.pid=p.pid and p.color='red'
 group by ca.sid having count(ca.pid)=(select count(*) from parts p where p.color='red'));



-- iv. Find the pnames of parts supplied by Acme Widget Suppliers and by no one else.

select ca.pid from catalog ca 
 where ca.sid=(select s.sid from suppliers s where s.sname ='Acme Widget') 
 having (select count(c.pid) from catalog c where c.pid=ca.pid)=1;




-- v. Find the sids of suppliers who charge more for some part than the average cost of that part (averaged over
-- all the suppliers who supply that part).

select distinct c.sid,
c.pid from catalog c where c.cost > (select avg(ca.cost)
 from catalog ca where ca.pid=c.pid);



-- vi. For each part, find the sname of the supplier who charges the most for that part.

select s.sname from suppliers s where s.sid in 
(select c.sid from catalog c where c.cost=(select max(cost) from catalog ca where ca.pid=c.pid));





-- vii. select supplier who sell only red parts 

select s.sname from suppliers s where s.sid in(select c.sid from catalog c where c.sid not in (select distinct(ca.sid) from catalog ca,parts p where ca.pid=p.pid and p.color!='red'));
insert into catalog values(5,1,140); 
select s.sname from suppliers s where s.sid in(select c.sid from catalog c where c.sid not in (select distinct(ca.sid) from catalog ca,parts p where ca.pid=p.pid and p.color!='red'));
delete from catalog where sid=5;
