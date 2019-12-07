----Identify the steps necessary to design an updatable view
------Modifying views that reference one table
CREATE TABLE Examples.Gadget
(
	GadgetId	int NOT NULL CONSTRAINT PKGadget PRIMARY KEY,
	GadgetNumber	char(8) NOT NULL CONSTRAINT AKGadget UNIQUE,
	GadgetType	varchar(10) NOT NULL
);
GO

INSERT INTO Examples.Gadget(GadgetId, GadgetNumber, GadgetType)
VALUES	(1, '00000001','Electronic'),
		(2, '00000002','Manual'),
		(3, '00000003','Manual');
GO

SELECT * FROM Examples.Gadget

CREATE VIEW	Examples.ElectronicGadget
AS
	SELECT GadgetId, GadgetNumber, GadgetType,
		UPPER(GadgetType) AS UpperGadgetType
	FROM	Examples.Gadget
	WHERE GadgetType = 'Electronic';
	-- COMPARISONS
	-- LIKE, IN,
	-- = MEANS EQUAL
	-- < MEAN LESSER THAN
	-- > MEANS GREATER THAN
	-- <> or != BOTH MEAN 'NOT EQUAL'

GO

SELECT * FROM Examples.Gadget;
SELECT * FROM Examples.ElectronicGadget;

SELECT ElectronicGadget.GadgetNumber AS FromView,
		Gadget.GadgetNumber AS FromTable,
		Gadget.GadgetType, ElectronicGadget.UpperGadgetType
FROM	Examples.ElectronicGadget
		 FULL OUTER JOIN Examples.Gadget
			ON ElectronicGadget.GadgetId = Gadget.GadgetId;

--Update the row we could see to values that could not be seen

INSERT INTO	Examples.ElectronicGadget(GadgetId, GadgetNumber, GadgetType)
VALUES (4,'00000004','Electronic'),
	   (5,'00000005','Manual');

--Update the row we could see to the values that could not be seen
UPDATE	Examples.ElectronicGadget
SET		GadgetType		= 'Manual'
WHERE	GadgetNumber	= '00000004';
GO

--Update the row we could NOT see to values that could actually see
UPDATE	Examples.ElectronicGadget
SET		GadgetType		= 'Electronic'
WHERE	GadgetNumber	= '00000005';
GO

------Limiting what data can be added to a table through a view through DDL\
ALTER VIEW	Examples.ElectronicGadget
AS
	SELECT	GadgetId, GadgetNumber, GadgetType,
			UPPER(GadgetType) AS UpperGadgetType
	FROM	Examples.Gadget
	WHERE GadgetType = 'Electronic'
	WITH CHECK OPTION;
GO

INSERT INTO	Examples.ElectronicGadget(GadgetId, GadgetNumber, GadgetType)
VALUES (7,'00000007','Electronic');
GO