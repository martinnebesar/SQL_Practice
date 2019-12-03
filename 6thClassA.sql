CREATE VIEW Sales.Orders12MonthsMultipleItems
AS
SELECT OrderId, CustomerId, SalespersonPersonId, OrderDate, ExpectedDeliveryDate
FROM Sales.Orders
WHERE OrderDate >= DATEADD(Month, -12, SYSDATETIME())
	AND (SELECT COUNT(*)
		FROM Sales.OrderLines
		WHERE OrderLines.OrderID =Orders.OrderID) > 1

SELECT TOP 5 *
FROM Sales.Orders12MonthsMultipleItems
ORDER BY ExpectedDeliveryDate DESC    

SELECT PersonId, IsPermittedToLogon, IsEmployee, IsSalesPerson
FROM Application.People

CREATE VIEW Application.PeopleEmployeeStatus
AS
SELECT PersonId, FullName,
		IsPermittedToLogon, IsEmployee, IsSalesPerson,
		CASE WHEN IsPermittedToLogon = 1 THEN 'Can Logon'
			ELSE 'Can''t Logon' END AS LogonRights,
		CASE WHEN IsEmployee = 1 and IsSalesPerson = 1
				THEN 'Sales Person'
			WHEN IsEmployee = 1
				THEN 'Regular'
			ELSE 'Not Employee' END AS EmployeeType
FROM Application.People

SELECT * FROM Application.PeopleEmployeeStatus

CREATE SCHEMA Reports
CREATE VIEW Reports.InvoiceSummaryBasis
AS
SELECT Invoices.InvoiceId, CustomerCategories.CustomerCategoryName,
		Cities.CityName, StateProvinces.StateProvinceName,
		StateProvinces.SalesTerritory,
		Invoices.InvoiceDate,
		--the grain of the report is at the invoice, so total
		--the ammounts for invoice
		SUM(InvoiceLines.LineProfit) as InvoiceProfit,
		SUM(InvoiceLines.ExtendedPrice) as InvoiceExtendedPrice
FROM	Sales.Invoices
		JOIN Sales.InvoiceLines
			ON Invoices.InvoiceID = InvoiceLines.InvoiceID
		JOIN Sales.Customers
			ON Customers.CustomerID = Invoices.CustomerID
		JOIN Sales.CustomerCategories
			ON Customers.CustomerCategoryID = CustomerCategories.CustomerCategoryID
		JOIN Application.Cities
			ON Customers.DeliveryCityID = Cities.CityID
		JOIN Application.StateProvinces
			ON StateProvinces.StateProvinceID = Cities.StateProvinceID
		GROUP BY Invoices.InvoiceId,
		CustomerCategories.CUstomerCategoryName,
		Cities.CityName, StateProvinces.StateProvinceName,
		StateProvinces.SalesTerritory,
		Invoices.InvoiceDate;

		SELECT TOP 5 SalesTerritory, SUM(InvoiceProfit) AS
		InvoiceProfitTotal
		FROM Reports.InvoiceSummaryBasis
		WHERE InvoiceDate > '2016-05-01'
		GROUP BY SalesTerritory
		ORDER BY InvoiceProfitTotal DESC;