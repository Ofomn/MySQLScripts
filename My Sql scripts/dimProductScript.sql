Use AdventureWorks2019
Go
Use Sandbox;
Go
Drop Table if exists dim.Products 

Go

Use AdventureWorks2019
Go



Select pr.ProductID as 'kProductID'
      ,pcat.ProductCategoryID
	  ,pcat.[Name] as 'Category'
	  ,prs.ProductSubcategoryID as 'kProductSubCategory'
	  ,prs.[Name] as 'SubCategory'
	  ,pr.*
Into Sandbox.dim.Products
From Production.Product pr
     Left join Production.ProductSubcategory prs
     on pr.ProductSubcategoryID = prs.ProductSubcategoryID
	 Left join Production.ProductCategory pcat
	 on prs.ProductCategoryID = pcat.ProductCategoryID

---504--