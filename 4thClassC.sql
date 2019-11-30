CREATE TABLE Examples.Invoice
(
	InvoiceId	int NOT NULL CONSTRAINT PKInvoice PRIMARY KEY,
	--Other Columns Omitted
);

CREATE TABLE Examples.DiscountType
(
	DiscountTypeID	int NOT NULL CONSTRAINT PKDiscountType PRIMARY KEY,
	--Other Columns Omitted
)
CREATE TABLE Examples.InvoiceLineItem
 (
	InvoiceLineItemId int NOT NULL CONSTRAINT PKInvoiceLineItem PRIMARY KEY,
	InvoiceId Int NOT NULL
			CONSTRAINT FKInvoiceLineItem$Ref$Invoice
				REFERENCES Examples.Invoice (InvoiceId),
	DiscountTypeId int NOT NULL
			CONSTRAINT FKInvoiceLineItem$Ref$DiscountType
				REFERENCES Examples.DiscountType (DiscountTypeId)
	--Other Columns Omitted
 );