create database college;
	use college;
	create table student (
	usn varchar(10),
	sname varchar(10),
	address varchar (30),
	phone varchar(10),
	gender varchar(1),
	constraint stu_usn primary key (usn)
	);
	create table semsec (
		ssid varchar(5),
		sem varchar(2),
		sec varchar(1),
		constraint sem_ssid primary key (ssid) 
	);
	create table class(
	usn varchar(10),
	ssid varchar(5),
	constraint class_usn primary key (usn),
	constraint class_usn foreign key (usn) references student (usn) on delete cascade on update cascade,
	constraint class_ssid foreign key (ssid) references  semsec(ssid) on delete cascade on update cascade
	);
	create table subjects(
	subcode varchar(10),
	title varchar (20),
	sem int,
	credits int,
	constraint sub_sub primary key (subcode)
	);
	create table iamarks(
	usn varchar(10),
	subcode varchar(10),
	ssid varchar(5),
	test1 int,
	test2 int,
	test3 int,
	finalia int,
	constraint ia primary key (usn,subcode,ssid),
	constraint ia_usn foreign key (usn) references  student(usn) on delete cascade on update cascade ,
	constraint ia_subcode foreign key (subcode) references  subjects(subcode) on delete cascade on update cascade,
	constraint ia_ssid foreign key (ssid) references  semsec(ssid) on delete cascade on update cascade
	);

	INSERT INTO STUDENT VALUES ('1BM19CS020','AKSHAY','BELAGAVI', 8877881122,'M'); 
	INSERT INTO STUDENT VALUES ('1BM19CS062','SANDHYA','BENGALURU', 7722829912,'F'); 
	INSERT INTO STUDENT VALUES ('1BM19CS091','TEESHA','BENGALURU', 7712312312,'F'); 
	INSERT INTO STUDENT VALUES ('1BM19CS066','SUPRIYA','MANGALURU', 8877881122,'F'); 
	INSERT INTO STUDENT VALUES ('1BM20CS010','ABHAY','BENGALURU', 9900211201,'M'); 
	INSERT INTO STUDENT VALUES ('1BM20CS032','BHASKAR','BENGALURU', 9923211099,'M'); 
	INSERT INTO STUDENT VALUES ('1BM20CS025','ASMI','BENGALURU', 7894737377,'F'); 
	INSERT INTO STUDENT VALUES ('1BM20CS011','AJAY','TUMKUR', 9845091941,'M');


	INSERT INTO SEMSEC VALUES ('CSE4A', 4,'A'); 
	INSERT INTO SEMSEC VALUES ('CSE4B', 4,'B'); 
	INSERT INTO SEMSEC VALUES ('CSE4C', 4,'C'); 
	INSERT INTO SEMSEC VALUES ('CSE6A', 6,'A'); 
	INSERT INTO SEMSEC VALUES ('CSE6B', 6,'B'); 
	INSERT INTO SEMSEC VALUES ('CSE6C', 6,'C'); 
	INSERT INTO SEMSEC VALUES ('CSE8A', 8,'A'); 
	INSERT INTO SEMSEC VALUES ('CSE8B', 8,'B'); 
	INSERT INTO SEMSEC VALUES ('CSE8C', 8,'C'); 

	INSERT INTO CLASS VALUES ('1BM19CS020','CSE8A'); 
	INSERT INTO CLASS VALUES ('1BM19CS062','CSE4A'); 
	INSERT INTO CLASS VALUES ('1BM19CS066','CSE8B'); 
	INSERT INTO CLASS VALUES ('1BM19CS091','CSE8C'); 
	INSERT INTO CLASS VALUES ('1BM20CS010','CSE4A'); 
	INSERT INTO CLASS VALUES ('1BM20CS025','CSE4B'); 
	INSERT INTO CLASS VALUES ('1BM20CS032','CSE4C'); 

	INSERT INTO SUBJECTS VALUES ('10CS81','ACA', 8, 4); 
	INSERT INTO SUBJECTS VALUES ('10CS82','SSM', 8, 4); 
	INSERT INTO SUBJECTS VALUES ('10CS83','NM', 8, 4); 

	INSERT INTO IAMARKS (USN, SUBCODE, SSID, TEST1, TEST2, TEST3) VALUES ('1BM19CS091','10CS81','CSE8C', 15, 16, 18); 
	INSERT INTO IAMARKS (USN, SUBCODE, SSID, TEST1, TEST2, TEST3) VALUES ('1BM19CS091','10CS82','CSE8C', 12, 19, 14); 
	INSERT INTO IAMARKS (USN, SUBCODE, SSID, TEST1, TEST2, TEST3) VALUES ('1BM19CS091','10CS83','CSE8C', 19, 15, 20); 
    
    
	-- i. List all the student details studying in fourth semester ‘C’ section. 
	select * from student s  where s.usn 
    in (select c.usn from class c where c.ssid in 
    (select ssid from semsec where sem='4' and sec='C'));

	-- ii. Compute the total number of male and female students in each semester and in each section 
	select se.sem,se.sec,gender,count(gender) as 'number of students' from class c natural join student s natural join semsec se group by sem,sec,gender;

	-- iii. Create a view of Test1 marks of student USN ‘1BI15CS101’ in all subjects. 
	create view marks(test1) as select i.test1 from iamarks i where i.usn='1BM19CS091'; 

	-- iv.calculate finalia marks and update the respective column for all student;
	-- select ia.usn,test1,test2,test3,(case 
	-- 		when test1>test3 and test2>test3 then (test1+test2)/2 
	-- 		when test2>test1 and test3>test1 then (test2+test3)/2 
	-- 		else (test1+test3)/2 end) as finalia from iamarks ia;
	
    update iamarks set finalia= case  when test1>test2 and test2>test3 then (test1+test2)/2 
			when test2>test3 and test3>test1 then (test2+test3)/2 
			else (test1+test3)/2 end; 
	
    select * from  iamarks; 
    
    -- v. Categorize students based on the following criterion: 
	-- If FinalIA = 17 to 20 then CAT = ‘Outstanding’ 
	-- If FinalIA = 12 to 16 then CAT = ‘Average’ 
	-- If FinalIA< 12 then CAT = ‘Weak’ 
	-- Give these details only for 8th semester A, B, and C section students. 
	
    select s.usn,s.sname,s.address,s.phone,s.gender,
	(case 
	when ia.finalia between 17 and 20 then 'outstanding'
	when ia.finalia between 12 and 16 then 'average'
	else 'weak' 
	end) as cat from iamarks ia,student s where s.usn=ia.usn and ia.ssid in (select ss.ssid from semsec ss where sem='8');
    select test1,test2,test3,finalia,subcode from iamarks group by subcode;
    select s.usn,s.sname,s.address,s.phone,s.gender from student s,iamarks i where i.finalia >45;
 create view subject as (select test1,test2,test3,finalia,subcode from iamarks group by subcode);
 select avg(test1),avg(test2),avg(test3) from iamarks group by subcode;
