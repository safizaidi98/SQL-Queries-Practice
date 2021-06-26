

use [AdventureWorks2014]



select 
*
from Sales.SalesOrderHeader




select 
ROW_NUMBER() over( partition by SalesPersonID Order by OrderDate asc) as RowNum,
SalesPersonID, 
OrderDate

from Sales.SalesOrderHeader

where
SalesPersonID is not Null
and DATEPART(Month, OrderDate) = 5


----------------------------------------------------------------------------------------------------------------

select * from Sales.SalesOrderHeader


select
OrderDate,
SalesOrderID,
cast(TotalDue as int),
cast(sum(TotalDue) over (partition by OrderDate) as int) as TotalSum,
TotalDue / sum(TotalDue) over (partition by OrderDate) * 100 as PCT

from Sales.SalesOrderHeader
