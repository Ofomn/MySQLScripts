USE tempdb;
GO

----Drop table if exist dim.Calender;--
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
----INTO dim.Calendar
FROM src
  ORDER BY Date
  OPTION (MAXRECURSION 0);
GO

---- Creating the Calendar Dim View ----
/*
CREATE OR ALTER VIEW vw.dCalendar
AS
SELECT *
FROM dim.Calendar;
GO
*/