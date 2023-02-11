Use Sandbox
Go






With SourceSales (SrcOrderID, SrcSubTotal, SrcTaxAmt, SrcSalesAmt)
as
(
Select soh.SalesOrderID 
      ,Sum(soh.SubTotal)
	  ,soh.TaxAmt
	  ,soh.SubTotal + soh.TaxAmt as 'SaleAmtTaxIn'
From AdventureWorks2019.Sales.SalesOrderHeader soh
),

MartSales (MartOrderID, MartSubTotal, LineItemCount, MartSalesAmt)
As
(
Select os.SalesOrderID
      ,Sum (os.SubTotal)
      ,Count (*) as 'LineItemCount'
	  ,Sum (os.SubTotal + (os.SubTotal * os.TaxRate)) as 'SalesAmtTaxIn'
From f.Onlinesales os
Group by os.SalesOrderID

Union All

Select rs.SalesOrderID
	  ,Sum (rs.SubTotal)
      ,Count (*) as 'LineItemCount'
	  ,Sum (rs.SubTotal + (rs.SubTotal * rs.TaxRate)) as 'SalesAmtTaxIn'
From f.RetailerSales rs
Group by rs.SalesOrderID
)
Select ss.SrcOrderID
      ,ms.LineItemCount
      ,ss.SrcSalesAmt
	  ,ms.MartSalesAmt
	  ,ss.SrcSalesAmt - ms.MartSalesAmt as 'Diffy'
From SourceSales ss
     Inner join MartSales ms
	 on ss.SrcOrderID = ms.MartOrderID
Order by Diffy