use TSQLV4;

create table Departments 
(
	deptid int not null primary key identity(1,1),
	deptname varchar(25) not null,
	mgrid int not null,
	validfrom datetime2(0) 
	generated always as row start hidden not null,
	validto datetime2(0) 
	generated always as row end hidden not null,
    period for SYSTEM_TIME(validfrom, validto)
)
with (system_versioning = on (history_table = dbo.DepartmentHistory));

go

select SYSUTCDATETIME();

insert into Departments values
('HR', 7),
('IT', 5),
('Sales', 11),
('Marketing', 13);

go

begin transaction;

declare @p2 as DateTime2(0);
set @p2 = SYSUTCDATETIME();

update Departments
set deptname = 'Sales and Marketing'
where deptid = 3;

delete from Departments where deptid = 4;

select @p2;

commit transaction;



begin transaction;

update Departments
set mgrid = 13
where deptid = 3

select SYSUTCDATETIME();

commit transaction;

select * , validfrom, validto
from Departments;

select *, validfrom, validto from Departments
for SYSTEM_TIME as of '2019-05-24 14:44:45';

select *, validfrom , validto  from Departments;

 SELECT * FROM dbo.DepartmentHistory;