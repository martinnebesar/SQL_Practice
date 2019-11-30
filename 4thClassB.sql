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