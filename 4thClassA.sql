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