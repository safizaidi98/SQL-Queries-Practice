

use PracticeDB

CREATE TABLE Students
(
	Id INT PRIMARY KEY IDENTITY,
	StudentName VARCHAR (50),
	Math INT,
	English INT,
	History INT,
	Science INT
)
GO

INSERT INTO Students VALUES ('Sally', 78, 85, 91, 76 )
INSERT INTO Students VALUES ('Edward', 87, 90, 82, 87)
INSERT INTO Students VALUES ('Ullu', 60, 70, 80, 90)


select * from Students

select * from 
(
	select Column_Name
	from INFORMATION_SCHEMA.COLUMNS
	where TABLE_NAME = N'Students'
) as AllCols
where AllCols.COLUMN_NAME != 'id'



select * from Students


select
StudentName, Courses, Nums, dense_rank() over(order by StudentName) as Ranks

from
(
	select StudentName, Math, English, History, Science from Students
) as Derive
Unpivot
(
	Nums for Courses in (Math, English, History, Science)
) as newcols









use PracticeDB

CREATE TABLE Students
(
	Id INT PRIMARY KEY IDENTITY,
	StudentName VARCHAR (50),
	Math INT,
	English INT,
	History INT,
	Science INT
)
GO

INSERT INTO Students VALUES ('Sally', 78, 85, 91, 76 )
INSERT INTO Students VALUES ('Edward', 87, 90, 82, 87)
INSERT INTO Students VALUES ('Ullu', 60, 70, 80, 90)


select * from Students


select * from 
(
	select Column_Name
	from INFORMATION_SCHEMA.COLUMNS
	where TABLE_NAME = N'Students'
) as AllCols
where AllCols.COLUMN_NAME != 'id'




declare @new	nvarchar(max),
		@var	nvarchar(max),
		@query	nvarchar(max)


select @new = coalesce( @new + ',', '') + QUOTENAME(Column_Name) 
from
(
	select Column_Name
	from INFORMATION_SCHEMA.COLUMNS
	where TABLE_NAME = N'Students'
) as AllCols
where AllCols.COLUMN_NAME != 'id'


select @new = coalesce( @new + ',', '') + QUOTENAME(Column_Name) 
from
(
	select Column_Name
	from INFORMATION_SCHEMA.COLUMNS
	where TABLE_NAME = N'Students'
) as AllCols
where AllCols.COLUMN_NAME != 'id' and AllCols.COLUMN_NAME != 'StudentName'




print @new
print @var


set @query = N'select StudentName, Courses, Nums, dense_rank() over(order by StudentName) as Ranks

from
(
	select '+ @new+' from Students
)

Unpivot
(
	Nums for Courses in ( '+ @var +' )
) as newcols
'


exec sp_executesql @query




select * from Students



select
StudentName, Courses, Nums, dense_rank() over(order by StudentName) as Ranks

from
(
	select StudentName, Math, English, History, Science from Students
) as Derive
Unpivot
(
	Nums for Courses in (Math, English, History, Science)
) as newcols




------------------------------------ Dynanmic Unpivot ------------------------------------------

--declare @new	nvarchar(max),
--		@var	nvarchar(max),
--		@query	nvarchar(max)




select @new = coalesce( @new + ',', '') + Column_Name 
from
(
	select Column_Name
	from INFORMATION_SCHEMA.COLUMNS
	where TABLE_NAME = N'Students'
) as AllCols
where AllCols.COLUMN_NAME != 'id'


select @var = coalesce( @var + ',', '') + Column_Name 
from
(
	select Column_Name
	from INFORMATION_SCHEMA.COLUMNS
	where TABLE_NAME = N'Students'
) as AllCols
where AllCols.COLUMN_NAME != 'id' and AllCols.COLUMN_NAME != 'StudentName'




--print @new
--print @var


set @query = N'select StudentName, Courses, Nums, dense_rank() over(order by StudentName) as Ranks

from
(
	select '+ @new +' from Students
) as Derive

Unpivot
(
	Nums for Courses in ( '+ @var +' )
) as newcols
'


exec sp_executesql @query



--select
--StudentName, Courses, Nums, dense_rank() over(order by StudentName) as Ranks

--from
--(
--	select StudentName, Math, English, History, Science from Students
--) as Derive
--Unpivot
--(
--	Nums for Courses in (Math, English, History, Science)
--) as newcols

