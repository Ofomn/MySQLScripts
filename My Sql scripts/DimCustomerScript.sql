Use AdventureWorks2019
Go

Select c.CustomerID as 'kCustomerID'
      ,c.PersonID
      ,p.FirstName + ''+ p.LastName as 'CustomerName'
      ,st.[Group]
      ,st.CountryRegionCode as 'CountryCode'
	  ,st.[Name] as 'Region'
	  ,st.TerritoryID
	  ,s.BusinessEntityID as 'StoreID'
	  ,s.[Name] as 'Store'
Into Sandbox.dim.Customer	  
From Sales.Customer c
     Left join Person.Person p
     on c.PersonID = p.BusinessEntityID
	 Left join sales.Store s
	 on c.StoreID = s.BusinessEntityID
	 Left join sales.SalesTerritory st
	 on c.TerritoryID = st.TerritoryID



---19820