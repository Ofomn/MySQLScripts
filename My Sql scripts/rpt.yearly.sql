Use Sandbox;
Go


Create or Alter view rpt.YearlySales
As
With onlineCTE (OrderYear, OnlineSales)
As
(

select cal.Year
      ,Sum(os.SubTotal)
From dim.Calendar cal
    Inner join f.Onlinesales os
	on cal.Date =os.OrderDate
Group by cal.Year
),

retailCTE (OrderYear, RetailSales)
As
(
Select cal.Year
      ,Sum(rs.SubTotal)
From dim.Calendar cal
     inner join f.RetailerSales rs
	 on cal.Date = rs.OrderDate
Group by cal.Year
)
Select o.*
      ,r.RetailSales
From onlineCTE o
     inner join retailCTE r
	 on o.OrderYear = r.OrderYear
;
