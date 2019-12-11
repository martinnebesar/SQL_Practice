CREATE TABLE	Examples.Parent
(
	ParentId	int		NOT NULL	CONSTRAINT	PKParent	PRIMARY KEY
);
CREATE TABLE	Examples.Child
(
	ChildId		int		NOT NULL	CONSTRAINT	PKChild		PRIMARY KEY,
	ParentId	int		NULL
);
SELECT * FROM	Examples.Parent
INSERT INTO		Examples.Parent		VALUES (10);

DELETE FROM		Examples.Child
INSERT INTO		Examples.Child		VALUES (1,10);
SELECT * FROM	Examples.Child

ALTER TABLE		Examples.Child
ADD CONSTRAINT	FKChild_Ref_ExamplesParent
FOREIGN KEY		(ParentId)			REFERENCES Examples.Parent(ParentId);

SELECT * FROM	Examples.Parent;
SELECT * FROM	Examples.Child;

CREATE TABLE Examples.TwoPartKey
(
	KeyColumn1	int NOT NULL,
	KeyColumn2	int NOT NULL,
	CONSTRAINT	PKTwoPartKey	PRIMARY KEY	(KeyColumn1, KeyColumn2)

INSERT INTO Examples.TwoPartKey	VALUES (10, 10); -- ID = 1010
);
SELECT * FROM Examples.TwoPartKey

INSERT INTO Examples.TwoPartKey	(KeyColumn1, KeyColumn2)
VALUES (1, 1), (NULL, NULL);
DROP TABLE IF EXISTS Examples.TwoPartKeyReference

CREATE TABLE	Examples.TwoPartKeyReference
(
	KeyColumn1	int	NOT NULL,
	KeyColumn2	int	NOT NULL,
	CONSTRAINT	FKTwoPartKeyReference_Ref_ExamplesTwoPartKey
		FOREIGN KEY (KeyColumn1, KeyColumn2)
			REFERENCES Examples.TwoPartKey (KeyColumn1, KeyColumn2)
			);
SELECT * FROM Examples.TwoPartKey;
SELECT * FROM Examples.TwoPartKeyReference;

INSERT INTO Examples.TwoPartKeyReference (KeyColumn1, KeyColumn2)
VALUES (10, 10), (NULL, NULL)

INSERT INTO Examples.TwoPartKeyReference (KeyColumn1, KeyColumn2)
VALUES (2, 2), (NULL, NULL)
;

CREATE TABLE Examples.Invoice
(
	InvoiceId	int	NOT NULL CONSTRAINT PKInvoice PRIMARY KEY
);
CREATE TABLE Examples.Invoice
(
	InvoiceId	int NOT NULL CONSTRAINT PKInvoice PRIMARY KEY
	);
CREATE TABLE Examples.InvoiceLineItem
(
	InvoiceLineItemId int NOT NULL CONSTRAINT PKInvoiceLineItem PRIMARY KEY,
	InvoiceLineNumber smallint NOT NULL,
	InvoiceId	int NOT NULL
		CONSTRAINT FKInvoiceLineItem_Ref_ExamplesInvoice
		REFERENCES Examples.Invoice(InvoiceId)
			ON DELETE CASCADE
			ON UPDATE NO ACTION,
	CONSTRAINT AKInvoiceLineItem UNIQUE (InvoiceId, InvoiceLineNumber)
);
SELECT * FROM Examples.InvoiceLineItem;

INSERT INTO Examples.Invoice(InvoiceId)
VALUES (1),(2),(3);
INSERT INTO Examples.InvoiceLineItem(InvoiceLineItemId, InvoiceId, InvoiceLineNumber)
VALUES (1,1,1),(2,1,2),(3,2,1);

SELECT Invoice.InvoiceId, InvoiceLineItem.InvoiceLineItemId
FROM	Examples.Invoice
	FULL OUTER JOIN Examples.InvoiceLineItem
	ON Invoice.InvoiceId = InvoiceLineItem.InvoiceId;

DELETE Examples.Invoice
WHERE InvoiceId = 1;

CREATE TABLE Examples.Code
(
	Code	varchar(10) NOT NULL CONSTRAINT PKCode PRIMARY KEY
);
CREATE TABLE Examples.CodedItem
(
	Code	varchar(10) NOT NULL
		CONSTRAINT FKCodedItem_Ref_ExampleCode
			REFERENCES Examples.Code (Code)
				ON UPDATE CASCADE
);
SELECT * FROM Examples.Code
SELECT * FROM Examples.CodedItem

INSERT INTO Examples.Code (Code)
VALUES ('Blacke');
INSERT INTO Examples.CodedItem (Code)
VALUES ('Blacke');

SELECT Code.Code, CodedItem.Code AS CodedItemCode
FROM	Examples.Code
	FULL OUTER JOIN Examples.CodedItem
		ON Code.Code = CodedItem.Code;

UPDATE Examples.Code
SET	Code = 'Black';

DROP TABLE IF EXISTS Examples.Attendee
CREATE TABLE Examples.Attendee
(
	ShirtSize	varchar(10) NULL
);

ALTER TABLE Examples.Attendee
	ADD CONSTRAINT CHKAttendee_ShirtSizeDomain
		CHECK (ShirtSize in ('S','M','L','XL','XXL'));

SELECT* FROM Examples.Attendee

CREATE TABLE Examples.ShirtSize
(
	ShirtSize varchar(10) NOT NULL CONSTRAINT PKShirtSize PRIMARY KEY
);
INSERT INTO Examples.ShirtSize(ShirtSize)
VALUES ('S'),('M'),('L'),('XL'),('XXL');

SELECT* FROM Examples.ShirtSize

ALTER TABLE Examples.Attendee
	DROP CONSTRAINT CHKAttendee_ShirtSizeDomain;
ALTER TABLE	Examples.Attendee
	ADD CONSTRAINT FKAttendee_Ref_ExamplesShirtSize
		FOREIGN KEY (ShirtSize) REFERENCES Examples.ShirtSize(ShirtSize);
INSERT INTO Examples.Attendee
	VALUES ('S')

INSERT INTO Examples.Attendee
	VALUES ('XS')

SELECT* FROM Examples.Attendee