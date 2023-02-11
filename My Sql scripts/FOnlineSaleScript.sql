Use AdventureWorks2019
Go


Select count(*)
From Sales.SalesOrderDetail
---121317---

Select count(*)
From Sales.SalesOrderHeader
--- 31465----

Select Count (*)
from Sales.SalesOrderDetail sod
inner join Sales.SalesOrderHeader soh
on sod.SalesOrderID = soh.SalesOrderID
inner join sales.SpecialOfferProduct sop
on sod.SpecialOfferID = sop.SpecialOfferID



Select  sod.SalesOrderID
       ,sod.SalesOrderDetailID
	   ,ROW_NUMBER () Over 
	    (Partition by sod.SalesOrderID Order by sod.SalesOrderID) as 'LineItemNumber'
       ,Cast (soh.OrderDate as date) as 'OrderDate'
	   ,Cast (soh.DueDate as date) as 'DueDate'
	   ,Cast (soh.ShipDate as date) as 'ShipDate'
	   ,soh.OnlineOrderFlag
	   ,soh.CustomerID
	   ,soh.SalesPersonID
	   ,sod.CarrierTrackingNumber
	   ,sod.OrderQty
	   ,sod.ProductID
	   ,sod.SpecialOfferID
	   ,sod.UnitPrice
	   ,sod.UnitPriceDiscount
	   ,sod.LineTotal as 'SubTotal'
	   ,tr.TaxRate
---Into ---
from Sales.SalesOrderDetail sod
       inner join Sales.SalesOrderHeader soh
       on sod.SalesOrderID = soh.SalesOrderID
       inner join sales.SpecialOfferProduct sop
       on sod.SpecialOfferID = sop.SpecialOfferID
       and sod.ProductID = sop.ProductID
       inner join Sales.SpecialOffer so
       on sop.SpecialOfferID = so.SpecialOfferID
	   Inner join Sandbox.stg.TaxRate tr
	   on sod.SalesOrderID = tr.SalesOrderID
Order by sod.SalesOrderID, sod.SalesOrderDetailID




With Onlinesales as
(

Select  sod.SalesOrderID
       ,sod.SalesOrderDetailID
	   ,ROW_NUMBER () Over 
	    (Partition by sod.SalesOrderID Order by sod.SalesOrderID) as 'LineItemNumber'
       ,Cast (soh.OrderDate as date) as 'OrderDate'
	   ,Cast (soh.DueDate as date) as 'DueDate'
	   ,Cast (soh.ShipDate as date) as 'ShipDate'
	   ,soh.OnlineOrderFlag
	   ,soh.CustomerID
---	   ,soh.SalesPersonID
---	   ,sod.CarrierTrackingNumber
	   ,sod.OrderQty
	   ,sod.ProductID
	   ,sod.SpecialOfferID
	   ,Cast (sod.UnitPrice as Money) as 'UnitPrice'
	   ,sod.UnitPriceDiscount
	   ,Cast (sod.LineTotal as money) as 'SubTotal'
	   ,tr.TaxRate
from Sales.SalesOrderDetail sod
       inner join Sales.SalesOrderHeader soh
       on sod.SalesOrderID = soh.SalesOrderID
       inner join sales.SpecialOfferProduct sop
       on sod.SpecialOfferID = sop.SpecialOfferID
       and sod.ProductID = sop.ProductID
       inner join Sales.SpecialOffer so
       on sop.SpecialOfferID = so.SpecialOfferID
	   Inner join Sandbox.stg.TaxRate tr
	   on sod.SalesOrderID = tr.SalesOrderID
---Order by sod.SalesOrderID, sod.SalesOrderDetailID---
)
Select *
Into Sandbox.f.Onlinesales
From Onlinesales
Where OnlineOrderFlag = 1
Order by SalesOrderID, LineItemNumber