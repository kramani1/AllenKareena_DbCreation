/*Select Queries displaying records from every table*/
USE AllenKareena_Db
SELECT * FROM dbo.Location
SELECT * FROM dbo.Product
SELECT * FROM dbo.PurchaseOrder
SELECT * FROM dbo.PurchaseOrderDetail
SELECT * FROM dbo.Store
SELECT * FROM dbo.Store_Products
SELECT * FROM dbo.StoreSales
SELECT * FROM dbo.[Supplier Contact]
SELECT * FROM dbo.Suppliers;

/*Using aggregate function*/
SELECT StoreSizeType, AVG(SqFootage) as AverageSqFootage 
FROM dbo.Store
GROUP BY StoreSizeType;

/*Inner Join*/
SELECT S.SupplierID, S.CompanyName, P.ProductName, P.SuggUnitPrice
FROM Suppliers as S
INNER JOIN Product as P
ON S.SupplierID = P.SupplierID
ORDER BY SupplierID;

/*Full Outer Join*/
SELECT S.StoreID, S.LocationID, S.SqFootage, S.StoreSizeType, L.City, L.[State/Province], L.Country, L.ZipCode
FROM Store as S
FULL OUTER JOIN Location as L
ON S.LocationID = L.LocationID;

/*Subquery*/
SELECT S.LocationID, AVG((SS.TotalRevenue) - (SS.TotalCost)) as AvgProfit
FROM Store as S
INNER JOIN StoreSales as SS
ON S.StoreID = SS.StoreID
GROUP BY S.LocationID
HAVING AVG((SS.TotalRevenue) - (SS.TotalCost)) > (SELECT AVG((TotalRevenue) - (TotalCost)) FROM StoreSales)
ORDER BY AVG((SS.TotalRevenue) - (SS.TotalCost)) DESC;