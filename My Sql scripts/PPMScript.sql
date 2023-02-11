/*
Grain - Subcategory and date of the customer's complaint
Tables to be created
Fact table (Contains all details of every customers in relation to the dimension tables)
Dimension table :
channel source
location
customer
subcategory
calendar - (Daily complaints - hierarchy) 
*/



------Creating stg.fPPM ---------------------------------- 28,570

Drop Table if exists stg.fPPM;
Go

Select ROW_NUMBER() OVER (ORDER BY C.SRNumber) AS 'CUSTOMERID'
      ,C.SRNumber
	  ,C.AccountNo
	  ,C.MajorCategory
	  ,C.CRMSubCategory
	  ,C.ChannelSource
	  ,C.Status as 'ComplaintStatus'
	  ,C.StatusN AS 'ResolutionStatus'
	  ,CAST (C.DateCreated AS DATE) AS 'DateCreated'
	  ,dc.bkDateKey
	  ,dc.DayName
	  ,dc.MonthName
	  ,dc.MonthAbbrev
	  ,C.BU AS 'BusinessUnit'
	  ,C.UT AS 'Undertaking'
	  ,C.AssignedDept
INTO CRM.stg.fPPM
FROM DBO.CRMDash C
INNER JOIN dim.Calendar dc
on c.DateCreated = dc.Date

GO



------Creating stg.customer ---------------------------------- 28,570 rows
Drop Table if exists stg.customer;
Go

Select ROW_NUMBER() OVER (ORDER BY C.SRNumber) AS 'CUSTOMERID'	
	  ,C.Status as 'ComplaintStatus'
	  ,C.StatusN AS 'ResolutionStatus'
	  ,CAST (C.DateCreated AS DATE) AS 'DateCreated'
	  ,C.BU AS 'BusinessUnit'
	  ,C.UT AS 'Undertaking'
	  ,C.AssignedDept
INTO CRM.stg.customer
From dbo.CRMDash c

Go



------Creating stg.location ---------------------------------- 
Drop Table if exists stg.location;
Go

 Select Distinct (c.BU) as 'BusinessUnit'
       ,c.UT AS 'Undertaking'
INTO CRM.stg.location
 From dbo.CRMDash c

 Go


 ------Creating stg.SubCategory ---------------------------------- 
Drop Table if exists stg.SubCategory;
Go

 Select Distinct (c.CRMSubCategory) as 'SubCategory'
       ,c.MajorCategory
INTO CRM.stg.SubCategory
 From dbo.CRMDash c


 Go

  ------Creating stg.ChannelSource ---------------------------------- 
  Drop Table if exists stg.ChannelSource;
Go

  Select Distinct (c.ChannelSource) as 'ChannelSource'
        ,c.MajorCategory
INTO CRM.stg.ChannelSource
  From dbo.CRMDash c

  Go


-----Creating views ------

------Creating stg.fPPM ----------------------------------
CREATE or ALTER VIEW vw.fPPM
as
Select *
      ,1 as 'Count'
From stg.fPPM

Go

----Creating dim.calendar

Drop table if exists dim.Calendar;
GO

DECLARE @StartDate  date = '20220101';
DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, 1, @StartDate));

--CHANGE NOTHING BELOW THIS LINE--
;WITH seq(n) AS
(
  SELECT 0 UNION ALL SELECT n + 1 FROM seq
  WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
),
d(d) AS
(
  SELECT DATEADD(DAY, n, @StartDate) FROM seq
),
src AS
(
  SELECT
      bkDateKey     = CAST(REPLACE(CONVERT(varchar(10), d),'-','') as INT),
    Date         = CONVERT(date, d),
    Day          = DATEPART(DAY,       d),
    DayName      = DATENAME(WEEKDAY,   d),
    Week         = DATEPART(WEEK,      d),
    DayOfWeek    = DATEPART(WEEKDAY,   d),
    Month        = DATEPART(MONTH,     d),
    MonthName    = DATENAME(MONTH,     d),
    MonthAbbrev  = LEFT(DATENAME(MONTH, d),3),
    FirstOfMonth = DATEFROMPARTS(YEAR(d), MONTH(d), 1),
	EndOfMonth    = EOMONTH(CONVERT(date, d ))
  FROM d
)

SELECT *
INTO dim.Calendar
FROM src
  ORDER BY Date
  OPTION (MAXRECURSION 0);
GO

---- Creating the Calendar Dim View ----

CREATE OR ALTER VIEW vw.dCalendar
AS
SELECT *
FROM dim.Calendar;
GO

------Creating vw.customer ---------------------------------- 
CREATE OR ALTER VIEW vw.customer
AS
Select *
from stg.customer c

Go

------Creating vw.location ---------------------------------- 
CREATE OR ALTER VIEW vw.location
AS
Select *
From stg.location
Go

------Creating vw.ChannelSource ---------------------------------- 
CREATE OR ALTER VIEW vw.ChannelSource
AS

Select *
From stg.ChannelSource

GO

------Creating vw.SubCategory ---------------------------------- 
CREATE OR ALTER VIEW vw.SubCategory
AS

Select *
From stg.SubCategory

GO