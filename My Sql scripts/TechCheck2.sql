Use AWDWpt2;
Go

Select c.[Year]
      ,p.ProductCategory
      ,Sum (f.SubTotal) as 'totalsale'
From vw.fSales f
inner join vw.dProduct p
on f.ProductID = p.ProductID
inner join dim.Calendar c
on f.bkDateKey = c.bkDateKey
Group by p.ProductCategory, c.[Year]
Order by Sum (f.SubTotal)



Select *
From vw.pr



Select p.ProductSubCategory
      ,Sum (f.SubTotal) as 'totalsale'
From vw.fSales f
inner join vw.dProduct p
on f.ProductID = p.ProductID
Group by p.ProductSubCategory

Select p.ProductSubCategory
      ,Sum (f.SubTotal) as 'totalsale'
From vw.fSales f
inner join vw.dProduct p
on f.ProductID = p.ProductID
inner join dim.Calendar c
on f.bkDateKey = c.bkDateKey
Where c.[Year] = 2014
Group by p.ProductCategory, c.[Year], p.ProductSubCategory
Order by Sum (f.SubTotal) Desc


