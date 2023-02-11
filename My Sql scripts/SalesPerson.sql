
SELECT sp.[BusinessEntityID] as 'SalesPersonID'
      ,emp.JobTitle
	  ,pp.FirstName + '' + pp.LastName as 'Employee'
      ,isnull (sp.[TerritoryID], -99) as 'TerritoryID'
	  ,Isnull (st.[Name], 'No Territory') as 'Territory'
	  ,Isnull (st.CountryRegionCode, 'NT') as 'CountryRegionCode'
      ,Isnull (sp.[SalesQuota],  0) as 'SalesQuota'
      ,sp.[Bonus]
      ,sp.[CommissionPct]
	  ,emp.CurrentFlag
--Into Sandbox.dim.Salesperson
FROM [Sales].[SalesPerson] sp
Inner join person.Person pp
on sp.BusinessEntityID = pp.BusinessEntityID
Inner join HumanResources.Employee emp
on sp.BusinessEntityID = emp.BusinessEntityID
Left join sales.SalesTerritory st
on sp.TerritoryID = st.TerritoryID