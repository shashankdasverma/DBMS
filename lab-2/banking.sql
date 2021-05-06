create database bank;
use bank;
create table Branch(branchname varchar(30),branchcity varchar(30),assets real,primary key(branchname));
desc Branch;
create table BankAccount(accno int,branchname varchar(30),balance real,primary key(accno),foreign key(branchname) references Branch(branchname));
desc BankAccount;
create table BankCustomer(customername varchar(30), customerstreet varchar(30), customercity varchar(30), primary key(customername));
desc BankCustomer;
create table Depositer(customername varchar(30),accno integer, primary key(customername,accno),foreign key(customername) references BankCustomer(customername), foreign key(accno) references BankAccount (accno));
desc Depositer; 
create table Loan (loannumber int, branchname varchar(30),amount real, primary key(loannumber), foreign key (branchname) references Branch(branchname));
desc Loan;

insert into Branch values('SBI_Chamrajpet','Bangalore',50000);
insert into Branch values('SBI_ResidencyRoad','Bangalore',10000);
insert into Branch values('SBI_ShivajiRoad','Bombay',20000);
insert into Branch values('SBI_ParlimentRoad','Delhi',10000);
insert into Branch values('SBI_Jantarmantar','Delhi',20000);
commit;
select * from Branch;

insert into Loan values(1, 'SBI_Chamrajpet',1000);
insert into Loan values(2, 'SBI_ResidencyRoad',2000);
insert into Loan values(3, 'SBI_ShivajiRoad',3000);
insert into Loan values(4, 'SBI_ParlimentRoad',4000);
insert into Loan values(5, 'SBI_Jantarmantar',5000);
commit;
select * from Loan;


insert into BankAccount values(1,'SBI_Chamrajpet',2000);
insert into BankAccount values(2,'SBI_ResidencyRoad',5000);
insert into BankAccount values(3,'SBI_ShivajiRoad',6000);
insert into BankAccount values(4,'SBI_ParlimentRoad',9000);
insert into BankAccount values(5,'SBI_Jantarmantar',8000);
insert into BankAccount values(6,'SBI_ShivajiRoad',4000);
insert into BankAccount values(8,'SBI_ResidencyRoad',4000);
insert into BankAccount values(9,'SBI_ParlimentRoad',3000);
insert into BankAccount values(10,'SBI_ResidencyRoad',5000);
insert into BankAccount values(11,'SBI_Jantarmantar',2000);
commit;
select * from BankAccount;

insert into BankCustomer values("Avinash","Bull_Temple_Road","Bangalore");
insert into BankCustomer values("Dinesh","Bannergatta_Road","Bangalore");
insert into BankCustomer values("Mohan","NationalCollege_Road","Bangalore");
insert into BankCustomer values("Nikil","Akbar_Road","Delhi");
insert into BankCustomer values("Ravi","Prithiviraj_Road","Delhi");
commit;
select * from BankCustomer;

insert into Depositer values("Avinash",1);
insert into Depositer values("Dinesh",2);
insert into Depositer values("Nikil",4);
insert into Depositer values("Ravi",5);
insert into Depositer values("Avinash",8);
insert into Depositer values("Nikil",9);
insert into Depositer values("Dinesh",10);
insert into Depositer values("Nikil",11);
commit;
select * from Depositer;

SELECT c.customername FROM BankCustomer c WHERE EXISTS(SELECT
d.customername,COUNT(d.customername) FROM Depositer d, BankAccount ba WHERE
d.accno=ba.accno AND c.customername=d.customername AND ba.branchname='SBI_ResidencyRoad' GROUP BY d.customername HAVING COUNT(d.customername)>=2);


select BC.customername from BankCustomer BC where not exists( select branchname from Branch where branchcity='Delhi'
and not exists (select BA.branchname from Depositer D, BankAccount BA where D.accno=BA.accno and BC.customername=D.customername));


DELETE FROM BankAccount WHERE branchname IN (SELECT branchname FROM BRANCH
WHERE branchcity='Bombay');
select * from BankAccount;
