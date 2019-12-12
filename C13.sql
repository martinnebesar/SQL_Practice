CREATE TABLE Examples.Parameter
(
	ParameterId int NOT NULL IDENTITY (1,1) CONSTRAINT PKParameter PRIMARY KEY,
	Value1 varchar(20) NOT NULL,
	Value2 varchar(20) NOT NULL,
)
CREATE PROCEDURE Examples.Parameter_Insert
	@Value1 varchar(20) = 'No entry given',
	@Value2 varchar(20) = 'No entry given'
AS
	SET NOCOUNT ON;
		INSERT INTO Examples.Parameter(Value1,Value2)
		VALUES (@Value1,@Value2);

SELECT * FROM Examples.Parameter

-- using all defaults
EXECUTE Examples.Parameter_Insert;

-- by position
EXECUTE Examples.Parameter_Insert 'Some Entry';

-- both columns by position
EXECUTE Examples.Parameter_Insert 'More Entry','More Entry';

-- using the name of the parameter (could also include @Value2);
EXECUTE Examples.Parameter_Insert @Value1 = 'Other Entry';

ALTER PROCEDURE Examples.Parameter_Insert
	@Value1 varchar(20) = 'No entry given',
	@Value2 varchar(20) = 'No entry given' OUTPUT,
	@NewParameterId int = NULL OUTPUT
AS
	SET NOCOUNT ON;
	SET @Value1 = UPPER(@Value1);
	SET @Value2 = LOWER(@Value2);

	INSERT INTO Examples.Parameter(Value1,Value2)
	VALUES (@Value1, @Value2);

	SET @NewParameterId = SCOPE_IDENTITY();
	GO

DECLARE @Value1 varchar(20) = 'Test',
		@Value2 varchar(20) = 'Test',
		@NewParameterId int = -200;

EXEC Examples.Parameter_Insert	@Value1 = @Value1,
								@Value2 = @Value2 OUTPUT,
								@NewParameterId = @NewParameterId OUTPUT;

SELECT @Value1 as Val1, @Value2 as Val2, @NewParameterId as NewParameterId;

SELECT *
FROM Examples.Parameter
WHERE ParameterId = @NewParameterId;

CREATE PROCEDURE SimpleReturnValue
AS
	DECLARE @NoOp int;

DECLARE @ReturnCode int;
EXECUTE @ReturnCode = SimpleReturnValue;
SELECT @ReturnCode as ReturnCode;

CREATE PROCEDURE DoOperation
(
	@Value int
)
--Procedure returns via return code:
-- 1 - successful execution, with 0 entered
-- 0 - successful execution
-- -1 - invalid, NULL input
AS
	IF @Value = 0
		RETURN 1;
	ELSE IF @Value IS NULL
		RETURN -1;
	ELSE
		RETURN 0;
GO

DECLARE @ReturnCode int;
EXEC @ReturnCode = DoOperation NULL;
SELECT @ReturnCode;

DECLARE @ReturnCode int;
EXEC @ReturnCode = DoOperation 10;
SELECT @ReturnCode;

DECLARE @ReturnCode int;
EXEC @ReturnCode = DoOperation 0;
SELECT @ReturnCode;