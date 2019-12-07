DROP TABLE IF EXISTS Examples.Widget;

CREATE TABLE Examples.Widget(
	WidgetId	int CONSTRAINT PKWidget PRIMARY KEY,
	RowLastModifiedTime DATETIME2(0) NOT NULL
)

INSERT INTO Examples.Widget VALUES (1, '1990-01-01');

ALTER TABLE Examples.Widget
	ADD CONSTRAINT DFLTWidget_RowLastModifiedTime
		DEFAULT	(SYSDATETIME())	FOR RowLastModifiedTime

INSERT INTO Examples.Widget (WidgetId) VALUES (2);
UPDATE Examples.Widget SET RowLastModifiedTime = DEFAULT

SELECT * FROM Examples.Widget