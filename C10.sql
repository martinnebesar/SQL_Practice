DROP TABLE IF EXISTS Examples.Gadget;
CREATE TABLE	Examples.Gadget
(
	GadgetId	int IDENTITY(1,1)	NOT NULL	CONSTRAINT PKGadget	PRIMARY KEY,
	GadgetCode	varchar(10)		NOT NULL
);

INSERT INTO Examples.Gadget(GadgetCode)
VALUES ('Samsung');

DELETE FROM Examples.Gadget WHERE Gadget in (2,3);

ALTER TABLE Examples.Gadget
	ADD CONSTRAINT AKGadget UNIQUE (GadgetCode);

SELECT * FROM Examples.Gadget;

DROP TABLE IF EXISTS Examples.GroceryItem
CREATE TABLE Examples.GroceryItem
(
	ItemId		INT IDENTITY (1,1) PRIMARY KEY,
	ItemDescr	VARCHAR(200) NOT NULL,
	ItemCost	SMALLMONEY NULL
		CONSTRAINT CHKGroceryItem_ItemCostRange
			CHECK (ItemCost > 0 AND ItemCost <1000)
);
SELECT * FROM Examples.GroceryItem;

DROP TABLE IF EXISTS Examples.Message
CREATE TABLE Examples.Message
(
	MessageTag	char(5) NOT NULL,
	Comment nvarchar(max) NULL
);
ALTER TABLE Examples.Message
	ADD CONSTRAINT CHKMessage_MessageTagFormat
	CHECK (MessageTag LIKE '[A-Z]-[0-9][0-9][0-9]');

ALTER TABLE Examples.Message
	ADD CONSTRAINT CHKMessage_CommentNotEmpty
	CHECK (LEN(Comment) > 0);

INSERT INTO Examples.Message (MessageTag, Comment)
VALUES ('nope', '');

INSERT INTO Examples.Message (MessageTag, Comment)
VALUES ('A-001', '');

INSERT INTO Examples.Message (MessageTag, Comment)
VALUES ('A-000', 'This is a comment');
;

SELECT * FROM Examples.Message