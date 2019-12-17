CREATE FUNCTION Sales.Customers_ReturnOrderCount
(
	@CustomerID int,
	@OrderDate date = NULL
)
RETURNS INT
WITH RETURNS NULL ON NULL INPUT,
	SCHEMABINDING
AS
	BEGIN
		DECLARE	@OutputValue int

		SELECT	@OutputValue = COUNT(*)
		FROM	Sales.Orders
		WHERE	CustomerID = @CustomerID
		AND		(OrderDate = @OrderDate
				OR @OrderDate IS NULL);

		RETURN @OutputValue
	END;
GO

SELECT Sales.Customers_ReturnOrderCount(905, '2013-01-01');
GO

SELECT Sales.Customers_ReturnOrderCount(905, DEFAULT);
GO

SELECT CustomerID,
Sales.Customers_ReturnOrderCount(CustomerID, DEFAULT) AS TotalOrders
FROM	Sales.Customers;
GO

SELECT N'CPO' + RIGHT(N'00000000' + CustomerPurchaseOrderNumber,8)
FROM Sales.Orders;
GO

CREATE FUNCTION Sales.Orders_ReturnFormattedCPO
(
	@CustomerPurchaseOrderNumber nvarchar(20)
)
RETURNS nvarchar(20)
WITH RETURNS NULL ON NULL INPUT,
	SCHEMABINDING
AS
	BEGIN
		RETURN (N'CPO' + RIGHT(N'00000000' + @CustomerPurchaseOrderNumber,8));
	END;
GO

SELECT Sales.Orders_ReturnFormattedCPO('12345') as CustomerPurchaseOrderNumber;
GO

SELECT Sales.Orders_ReturnFormattedCPO(CustomerPurchaseOrderNumber) as FormattedCPO
FROM Sales.Orders
GO

SELECT OrderId
FROM Sales.Orders
WHERE Sales.Orders_ReturnFormattedCPO(CustomerPurchaseOrderNumber)='CPO00019998';
GO

SELECT Sales.Orders_ReturnFormattedCPO(CustomerPurchaseOrderNumber)
FROM Sales.Orders;
GO

CREATE FUNCTION Sales.Customers_ReturnOrderCountSetSimple
(
	@CustomerID int,
	@OrderDate date = NULL
)
RETURNS TABLE
AS
RETURN (SELECT COUNT(*) AS SalesCount, 
				CASE WHEN MAX(BackorderOrderId) IS NOT NULL
					THEN 1 ELSE 0 END AS HasBackorderFlag
				FROM Sales.Orders
				WHERE CustomerID = @CustomerID
				AND	(OrderDate = @OrderDate
					OR @OrderDate IS NULL));
GO