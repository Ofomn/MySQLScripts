/*Data Validation Exercise*/

Use Sandbox
Go


Select soh.SalesOrderID  -------this is the grain
      ,soh.SubTotal
	  ,soh.TaxAmt
	  ,soh.SubTotal + soh.TaxAmt as 'SaleAmtTaxIn'
	  ,soh.Freight
	  ,soh.TotalDue
From AdventureWorks2019.Sales.SalesOrderHeader soh

----31465

/* 
For SandBox
What is the grain on the fact table?
How many total rows should I get back after a Union on the set
And how can I do a compare?
Calculate SubTotal * TaRate and Compare toHeader (SalesAmtTaxIn)
*/

Select os.SalesOrderID
--    ,os.SubTotal
--	  ,os.TaxRate
	  ,Sum (os.SubTotal + (os.SubTotal * os.TaxRate)) as 'SalesAmtTaxIn'
From f.Onlinesales os
Group by os.SalesOrderID

Union

Select rs.SalesOrderID
--    ,rs.SubTotal
--	  ,rs.TaxRate
	  ,Sum (rs.SubTotal + (rs.SubTotal * rs.TaxRate)) as 'SalesAmtTaxIn'
From f.RetailerSales rs
Group by rs.SalesOrderID
order by 1




With SourceSales (SrcOrderID, SrcSubTotal, SrcTaxAmt, SrcSalesAmt)
as
(
Select soh.SalesOrderID 
      ,soh.SubTotal
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
	  ,ss.SrcSubTotal as 'SourcePreTax'
	  ,ms.MartSubTotal as 'TotalSalesPreTax'
	  ,ss.SrcSubTotal - ms.MartSubTotal as 'SubDiffy'
	  ,'From Join' as 'TotalSalesPostTax'
	  ,ss.SrcSalesAmt - ms.MartSalesAmt as 'PreDiffy'
From SourceSales ss
     Inner join MartSales ms
	 on ss.SrcOrderID = ms.MartOrderID




	 

With SourceSales (SrcOrderID, SrcSubTotal, SrcTaxAmt, SrcSalesAmt)
as
(
Select soh.SalesOrderID 
      ,soh.SubTotal
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
Select Sum (ss.SrcSubTotal - ms.MartSubTotal) as 'RoundErrPost'
      ,Sum (ss.SrcSalesAmt - ms.MartSalesAmt) as 'RoundErrPre'
From SourceSales ss
     inner join MartSales ms
	 on ss.SrcOrderID = ms.MartOrderID