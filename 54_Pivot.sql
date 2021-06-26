

use PracticeDB


Create Table tblProductSales
(
 SalesAgent nvarchar(50),
 SalesCountry nvarchar(50),
 SalesAmount int
)

Insert into tblProductSales values('Tom', 'UK', 200)
Insert into tblProductSales values('John', 'US', 180)
Insert into tblProductSales values('John', 'UK', 260)
Insert into tblProductSales values('David', 'India', 450)
Insert into tblProductSales values('Tom', 'India', 350)
Insert into tblProductSales values('David', 'US', 200)
Insert into tblProductSales values('Tom', 'US', 130)
Insert into tblProductSales values('John', 'India', 540)
Insert into tblProductSales values('John', 'UK', 120)
Insert into tblProductSales values('David', 'UK', 220)
Insert into tblProductSales values('John', 'UK', 420)
Insert into tblProductSales values('David', 'US', 320)
Insert into tblProductSales values('Tom', 'US', 340)
Insert into tblProductSales values('Tom', 'UK', 660)
Insert into tblProductSales values('John', 'India', 430)
Insert into tblProductSales values('David', 'India', 230)
Insert into tblProductSales values('David', 'India', 280)
Insert into tblProductSales values('Tom', 'UK', 480)
Insert into tblProductSales values('John', 'US', 360)
Insert into tblProductSales values('David', 'UK', 140)


select * from tblProductSales


select
SalesAgent,
SalesCountry,
sum(SalesAmount)

from tblProductSales

group by
SalesAgent,
SalesCountry




select
SalesAgent,
India,
US,
UK

from tblProductSales
Pivot
(
	sum(SalesAmount)
	for SalesCountry 
	in (India,US,UK)
)
as PivotTable


---------------------------------------- Dynamic Pivot ----------------------------------------

IF OBJECT_ID('tempdb..##TBL_TEMP') IS NOT NULL
DROP TABLE ##TBL_TEMP

declare @col as nvarchar(max)
declare @Query as nvarchar(max)


select @col = coalesce(@col + ',', '') + QUOTENAME(SalesCountry) 
 
	from (select distinct SalesCountry from tblProductSales) as City

print @col


Set @Query = N'select SalesAgent,' + @col + 'Into ##TBL_TEMP from tblProductSales 


Pivot
(
	sum(SalesAmount) 
	for SalesCountry IN	('+@col+')) as query ' 


select * from ##TBL_TEMP


exec sp_executesql @Query





select
SalesAgent,
(
	select SalesCountry from tblProductSales	
)


from tblProductSales
Pivot
(
	sum(SalesAmount)
	for SalesCountry in ([India], [US], [UK])
)
as PivotTable