-- CREATE SCHEMA Examples;
-- GO

CREATE TABLE Examples.Widget (
	WidgetCode varchar(10) NOT NULL CONSTRAINT PKWidget PRIMARY KEY,
	WidgetName varchar(100) NULL,
	WidgetPrice varchar(10) NULL
);

select * from examples.widget

DROP TABLE Examples.Widget;