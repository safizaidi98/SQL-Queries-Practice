

use [AdventureWorks2014]


select 
*

from Sales.SalesOrderHeader






use AdventureWorks2014

select min(OrderDate) from Sales.SalesOrderHeader

select max(OrderDate) from Sales.SalesOrderHeader


create database testDB

create table ProductInfo
(
ProductID int,
EmailID char(50),
ProductDescription char(100)
)


Declare @num int
set @num = 1
while @num < 100
begin
	Insert into ProductInfo values(@num, 'user' + LTRIM(STR(@num)) + 'gmail.com', 'Sample Description' + LTRIM(STR(@num)))
	set @num = @num + 1
end 



select * from ProductInfo


--------------------------------------------------- PARTITION FUNCTION --------------------------------------------------------------------

create partition function [pfn_ProductInfo](int) as range left for values(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)

-------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------- PARTITION SCHEME --------------------------------------------------------------------

create partition scheme [pshm_ProductInfo] as partition [pfn_ProductInfo] all to ([primary])
-------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------- CLUSTERED INDEX --------------------------------------------------------------------

create clustered Index [CX_TP_ProductInfo] on [dbo].[ProductInfo]
(
	ProductID ASC
) with
(
pad_index = off,
Statistics_norecompute = off,
sort_in_TEMPDB = off,
ignore_DUP_KEY = off,
Drop_Existing = off,
Online = off,
allow_row_locks = on,
allow_page_locks = on,
Maxdop = 8
) on [pshm_ProductInfo](ProductID)
-------------------------------------------------------------------------------------------------------------------------------------------

