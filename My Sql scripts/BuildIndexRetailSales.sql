USE [Sandbox]
GO

/****** Object:  View [dev].[RetailStg]    Script Date: 2022-11-22 2:08:49 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER   View [dev].[RetailStg]
With Schemabinding
as

Select rs.SalesOrderID
      ,rs.LineItemNumber
---	  ,rs.OrderDate
	  ,cal.DateKey
	  ,DATEDIFF(Day, OrderDate, ShipDate) as 'DaysToship'
	  ,DATEDIFF (Day, ShipDate, DueDate) as 'DateToDeliver'
	  ,rs.CustomerID
	  ,rs.ProductID
	  ,rs.SpecialOfferID
	  ,200 as 'Ordertype'
---all facts below line ---
	  ,rs.OrderQty
	  ,rs.UnitPrice
	  ,rs.UnitPriceDiscount
	  ,rs.SubTotal
	  ,rs.TaxRate
From f.RetailerSales rs
Inner join  dim.Calendar cal
on rs.OrderDate = cal.[Date]

Go
Create Unique Clustered Index IDX_RetailSales
on dev.RetailStg (SalesOrderID, LineItemNumber)
;
GO


