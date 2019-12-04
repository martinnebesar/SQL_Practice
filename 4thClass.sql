CREATE INDEX InvoiceId ON Examples.InvoiceLineItem (InvoiceId);

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

CREATE SCHEMA Examples;
GO

CREATE TABLE Examples.UniquenessConstraint
(
	PrimaryUniqueValue int NOT NULL,
	AlternateUniqueValue1 int NULL,
	AlternateUniqueValue2 int NULL,
);

INSERT INTO Examples.UniquenessConstraint VALUES (1, NULL);
SELECT * FROM Examples.UniquenessConstraint;
DROP TABLE Examples.UniquenessConstraint;

ALTER TABLE Examples.UniquenessConstraint
	ADD CONSTRAINT PKUniquenessConstraint PRIMARY KEY
	(PrimaryUniqueValue);

CREATE DATABASE MyNewDatabase;
GO

CREATE SCHEMA MyCategory1;
GO

CREATE TABLE MyCategory1.NewTableName(
	MyTableId int PRIMARY KEY,
	SomeTextValue varchar (100) NOT NULL,
	SomeIntValue int NULL
)
GO

ALTER TABLE MyCategory1.NewTableName
	ADD NewValue varchar (100) NOT NULL
GO

SELECT * FROM MyCategory1.NewTableName;
