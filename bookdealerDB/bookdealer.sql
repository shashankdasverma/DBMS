create database book_dealer;
use book_dealer;
create table author(
  author_id int, 
  name varchar(30), 
  city varchar(20), 
  country varchar(20), 
  constraint auth_id primary key (author_id)
);
create table publisher(
  publisher_id int, 
  name varchar(30), 
  city varchar (30), 
  country varchar(30), 
  constraint pub_id primary key (publisher_id)
);
create table catalog(
  book_id int, 
  title varchar(30), 
  author_id int, 
  publisher_id int, 
  category_id int, 
  year int, 
  price int, 
  constraint cat_id primary key(book_id), 
  constraint cat_auth foreign key (author_id) references author(author_id) on delete cascade on update cascade, 
  constraint cat_pub foreign key (publisher_id) references publisher(publisher_id) on delete cascade on 
  update 
    cascade, 
    constraint cat_log foreign key (category_id) references category(category_id) on delete cascade on 
  update 
    cascade
);
create table category(
  category_id int, 
  description varchar(30), 
  constraint primary key (category_id)
);
create table order_details (
  order_no int, 
  book_id int, 
  quantity int, 
  constraint ord_no primary key (order_no), 
  constraint ord_id foreign key (book_id) references catalog(book_id) on delete cascade on update cascade
);
-- ii. Inserting tuples
insert into author 
values 
  (1001, 'TERAS CHAN', 'CA', 'USA');
insert into author 
values 
  (
    1002, 'STEVENS', 'ZOMBI', 'UGANDA'
  );
insert into author 
values 
  (1003, 'M MANO', 'CAIR', 'CANADA');
insert into author 
values 
  (
    1004, 'KARTHIK B.P.', 'NEW YORK', 
    'USA'
  );
insert into author 
values 
  (
    1005, 'WILLIAM STALLINGS', 'LAS VEGAS', 
    'USA'
  );
insert into publisher 
values 
  (1, 'PEARSON', 'NEW YORK', 'USA');
insert into publisher 
values 
  (
    2, 'EEE', 'NEW SOUTH VALES', 'USA'
  );
insert into publisher 
values 
  (3, 'PHI', 'DELHI', 'INDIA');
insert into publisher 
values 
  (4, 'WILLEY', 'BERLIN', 'GERMANY');
insert into publisher 
values 
  (5, 'MGH', 'NEW YORK', 'USA');
insert into category 
values 
  (1001, 'COMPUTER SCIENCE');
insert into category 
values 
  (1002, 'ALGORITHM DESIGN');
insert into category 
values 
  (1003, 'ELECTRONICS');
insert into category 
values 
  (1004, 'PROGRAMMING');
insert into category 
values 
  (1005, 'OPERATING SYSTEMS');
insert into catalog 
values 
  (
    11, 'Unix System Prg', 1001, 1, 1001, 
    2000, 251
  );
insert into catalog 
values 
  (
    12, 'Digital Signals', 1002, 2, 1003, 
    2001, 425
  );
insert into catalog 
values 
  (
    13, 'Logic Design', 1003, 3, 1002, 1999, 
    225
  );
insert into catalog 
values 
  (
    14, 'Server Prg', 1004, 4, 1004, 2001, 
    333
  );
insert into catalog 
values 
  (
    15, 'Linux OS', 1005, 5, 1005, 2003, 
    326
  );
insert into catalog 
values 
  (
    16, 'C++ Bible', 1005, 5, 1001, 2000, 
    526
  );
insert into catalog 
values 
  (
    17, 'COBOL Handbook', 1005, 4, 1001, 
    2000, 658
  );
insert into order_details 
values 
  (1, 11, 5);
insert into order_details 
values 
  (2, 12, 8);
insert into order_details 
values 
  (3, 13, 15);
insert into order_details 
values 
  (4, 14, 22);
insert into order_details 
values 
  (5, 15, 3);
insert into order_details 
values 
  (6, 17, 10);
-- iii. Give the details of the authors who have 2 or more books in the catalog and the price of the books in the catalog and the year of publication is aftcataloger 2000.select * from author a where a.author_id in
(
  select 
    c.author_id 
  from 
    catalog c 
  where 
    c.author_id = a.author_id 
    and year > 2000 
  having 
    count(*)>= 2
);
insert into catalog 
values 
  (
    18, 'CP Handbook', 1005, 4, 1001, 2003, 
    658
  );
select 
  * 
from 
  author a 
where 
  a.author_id in (
    select 
      c.author_id 
    from 
      catalog c 
    where 
      c.author_id = a.author_id 
      and year > 2000 
    having 
      count(*)>= 2
  );
-- iv. Find the author of the book which has maximum sales.
select 
  a.name 
from 
  author a 
where 
  a.author_id =(
    select 
      c.author_id 
    from 
      catalog c 
    where 
      c.book_id = (
        select 
          o.book_id 
        from 
          order_details o 
        group by 
          o.book_id 
        order by 
          sum(quantity) desc 
        limit 
          1
      )
  );
-- v. Demonstrate how you increase the price of books published by a specific publisher by 10%.
select 
  c.book_id, 
  (1.10 * price) as price 
from 
  catalog c 
where 
  c.publisher_id in (
    select 
      p.publisher_id 
    from 
      publisher p 
    where 
      P.name = "MGH"
  );
