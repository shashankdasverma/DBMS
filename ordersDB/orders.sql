create database orders;
use orders;
create table salesman(
    salesman_id int,
    name varchar(30),
    city varchar(30),
    commision varchar(30),
    constraint salesman_id primary key (salesman_id)
);
create table customer(
customer_id int,
salesman_id int,
cust_name varchar(30),
city varchar(30),
grade varchar(10),
constraint cust_cust primary key (customer_id),
constraint cust_sales foreign key (salesman_id) references salesman(salesman_id) on delete cascade on update cascade);

create table orders(
ord_no int,
customer_id int,
salesman_id int,
purchase_amt int ,
ord_date date,
constraint order_ord primary key (ord_no),
constraint order_cust foreign key (customer_id) references customer(customer_id) on delete cascade on update cascade,
constraint order_sales foreign key (salesman_id) references salesman(salesman_id) on delete cascade on update cascade 
);



INSERT INTO SALESMAN VALUES(1000,'JOHN','BANGALORE','25%');
INSERT INTO SALESMAN VALUES(2000,'RAVI','BANGALORE','20%');
INSERT INTO SALESMAN VALUES(3000,'KUMAR','MYSORE','15%');
INSERT INTO SALESMAN VALUES(4000,'SMITH','DELHI','30%');
INSERT INTO SALESMAN VALUES(5000,'HARSHA','HYDERABAD','15%');

INSERT INTO CUSTOMER VALUES(10,1000,'PREETHI','BANGALORE',100);
INSERT INTO CUSTOMER VALUES(11,2000,'VIVEK','MANGALORE',300);
INSERT INTO CUSTOMER VALUES(12,2000,'BHASKAR','CHENNAI',400);
INSERT INTO CUSTOMER VALUES(13,3000,'CHETAN','BANGALORE',200);
INSERT INTO CUSTOMER VALUES(14,2000,'MAMTHA','BANGALORE',400);

INSERT INTO ORDERS VALUES(50,10,1000,5000,'2017-05-04');
INSERT INTO ORDERS VALUES(51,10,2000,450,'2017-01-20');
INSERT INTO ORDERS VALUES(52,13,2000,1000,'2017-02-24');
INSERT INTO ORDERS VALUES(53,14,3000,3500,'2017-04-13');
INSERT INTO ORDERS VALUES(54,12,2000,550,'2017-03-09');
-- 1. Count the customers with grades above Bangalore’s average. 
select count(cu.customer_id) from customer cu where grade>(select avg(c.grade) from customer c where city='BANGALORE');

-- 2. Find the name and numbers of all salesmen who had more than one customer.
select s.salesman_id,s.name from salesman s where exists (select c.salesman_id from customer c where c.salesman_id=s.salesman_id  having count(*)>1);

-- 3. List all salesmen and indicate those who have and don’t have customers in their cities (Use UNION operation.)
select s.name,'have' as customer from salesman s where s.city in (select c.city from customer c where c.salesman_id=s.salesman_id) union select s.name,'dont have' from salesman s where s.city not in (select c.city from customer c where c.salesman_id=s.salesman_id);

-- 4. Create a view that finds the salesman who has the customer with the highest order of a day.
create view max_order(salesman_name,ord_date) as select s.name,ord_date from orders o natural join salesman s  group by o.ord_date having max(o.purchase_amt); 
select * from max_order;

-- 5. Demonstrate the DELETE operation by removing salesman with id 1000. All his orders must also be deleted.
delete from salesman where salesman_id=1000;
select * from salesman;
