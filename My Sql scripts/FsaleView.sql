Create or Alter View f.sales
as

Select os.SalesOrderID
      ,os.LineItemNumber
---	  ,os.OrderDate
	  ,cal.DateKey
	  ,DATEDIFF(Day, OrderDate, ShipDate) as 'DaysToship'
	  ,DATEDIFF (Day, ShipDate, DueDate) as 'DateToDeliver'
	  ,os.CustomerID
	  ,os.ProductID
	  ,os.SpecialOfferID
	  ,100 as 'Ordertype'
---all facts below line ---
	  ,os.OrderQty
	  ,os.UnitPrice
	  ,os.UnitPriceDiscount
	  ,os.SubTotal
	  ,os.TaxRate
From f.Onlinesales os
Inner join  dim.Calendar cal
on os.OrderDate = cal.[Date]

Union all

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

