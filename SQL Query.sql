use DWH_Project;
select * from [dbo].[DimCustomer];
select * from [dbo].[DimProduct];
select * from [dbo].[DimStatusOrder];
select * from [dbo].[FactSalesOrder];

use Staging;
select * from status_order;
select * from product;
select * from customer;
select * from sales_order;


CREATE OR ALTER PROCEDURE summary_order_status
	@StatusID INT
as
Begin
	select 
		sale.OrderID, 
		cust.FullName, 
		prod.ProductName, 
		sale.Quantity, 
		stat.StatusOrder
	from FactSalesOrder sale
		JOIN DimCustomer cust on sale.CustomerID = cust.CustomerID
		JOIN DimProduct prod ON sale.ProductID = prod.ProductID
		JOIN DimStatusOrder stat on sale.StatusID = stat.StatusID
	WHERE sale.StatusID = @StatusID
END;

EXEC summary_order_status @StatusID = 3
