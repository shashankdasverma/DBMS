create database student_enrollment;
use student_enrollment;
-- i) creating table 
create table student(
  regno varchar(10), 
  name varchar(30), 
  major varchar(10), 
  bdate date, 
  constraint stu_reg primary key (regno)
);
create table course (
  course int, 
  cname varchar(30), 
  dept varchar (30), 
  constraint cou_cou primary key (course)
);
create table enroll (
  regno varchar(10), 
  cname varchar (30), 
  sem int, 
  marks int, 
  constraint en_reg foreign key (regno) references student(regno)
);
create table book_adoption (
  course int, 
  sem int, 
  book_isbn int, 
  constraint book_cou foreign key (course) references course(course) on delete cascade on update cascade, 
  constraint book_book foreign key (book_isbn) references text(book_isbn) on delete cascade on update cascade
);
create table text (
  book_isbn int, 
  book_title varchar(30), 
  publisher varchar(30), 
  author varchar (30), 
  constraint book_book primary key (book_isbn)
);
-- ii. Inserting tuples 
insert into student 
values 
  (
    "CS01", "PRANAV", "DS", "1986-03-12"
  );
insert into student 
values 
  (
    "IS02", "PRATEEK", "USP", "1987-12-23"
  );
insert into student 
values 
  (
    "EC03", "SAURAB", "SNS", "1985-04-17"
  );
insert into student 
values 
  (
    "CS03", "ARKA", "DBMS", "1987-01-01"
  );
insert into student 
values 
  (
    "TC05", "PRANSHU", "EC", "1986-10-06"
  );
insert into course 
values 
  (11, "DS", "CS");
insert into course 
values 
  (22, "USP", "IS");
insert into course 
values 
  (33, "SNS", "EC");
insert into course 
values 
  (44, "DBMS", "CS");
insert into course 
values 
  (55, "EC", "TC");
insert into enroll 
values 
  ("CS01", 11, 4, 85);
insert into enroll 
values 
  ("IS02", 22, 6, 80);
insert into enroll 
values 
  ("EC03", 33, 2, 80);
insert into enroll 
values 
  ("CS03", 44, 6, 75);
insert into enroll 
values 
  ("TC05", 11, 4, 85);
insert into text 
values 
  (
    1, "DS AND C", "PRINCETON", "PADMA REDDY"
  );
insert into text 
values 
  (
    2, "FUNDAMENTALS OF DS", "SPRINGER", 
    "GODSE"
  );
insert into text 
values 
  (
    3, "FUNDAMENTALS OF DBMS", "SPRINGER", 
    "NAVATHE"
  );
insert into text 
values 
  (4, "SQL", "PRINCETON", "FOLEY");
insert into text 
values 
  (
    5, "ELECTRONIC CIRCUITS", "TMH", "ELMASRI"
  );
insert into book_adoption 
values 
  (11, 4, 1);
insert into book_adoption 
values 
  (11, 4, 2);
insert into book_adoption 
values 
  (44, 6, 3);
insert into book_adoption 
values 
  (44, 6, 4);
insert into book_adoption 
values 
  (55, 2, 5);
-- iii. Demonstrate how you add a new text book to the database and make this book be adopted by some department. 
insert into text 
values 
  (
    6, "RELATIONAL ALGEBRA", "ABS", "HUGH DARWIN"
  );
insert into book_adoption 
values 
  (22, 6, 6);
select 
  * 
from 
  book_adoption;
-- iv. Produce a list of text books (include Course #, Book-ISBN, Book-title) in the alphabetical order for courses offered by the ‘CS’ department that use more than two books. 
select 
  b.book_isbn 
from 
  book_adoption b 
where 
  b.course in (
    select 
      c.course 
    from 
      course c 
    where 
      c.dept = "CS"
  ) 
  and (
    select 
      count(*) 
    from 
      book_adoption be 
    where 
      be.course = b.course
  )>= 2;
insert into course 
values 
  (66, "OS", "CS");
insert into text 
values 
  (
    7, "OPERATING SYSTEM", "MC GRAW", 
    "ABRAHAM SILBERSCHATZ"
  );
insert into book_adoption 
values 
  (66, 6, 7);
select 
  * 
from 
  book_adoption;
-- v. List any department that has all its adopted books published by a specific publisher.
select 
  distinct c.dept 
from 
  course c 
where 
  not exists (
    select 
      t.book_isbn 
    from 
      text t 
    where 
      t.publisher = "SPRINGER"
  ) not in (
    select 
      b.book_isbN 
    from 
      book_adoption b 
    where 
      b.course in (
        select 
          ce.course 
        from 
          course ce 
        where 
          ce.dept = c.dept
      )
  );
