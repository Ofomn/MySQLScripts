
Create Schema dev

Create or Alter View dev.RetailStg
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
