


use AdventureWorks2014

select * from Sales.SalesOrderDetail
where SalesOrderID = 60074


select 
SalesOrderID,
count(SalesOrderID)

from Sales.SalesOrderDetail

group by
SalesOrderID

having count(SalesOrderID) > 1



select * into #temp from Sales.SalesOrderDetail


select * from #temp

select *, ROW_NUMBER() over(partition by SalesOrderID order by SalesOrderID) as RNum from Sales.SalesOrderDetail



;with cte
as
(
	select *, ROW_NUMBER() over(partition by SalesOrderID order by SalesOrderID) as rNum from #temp
)	
delete from cte where rNum > 1

select * from #temp




