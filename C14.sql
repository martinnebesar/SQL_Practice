CREATE PROCEDURE Examples.HandlingErrors
AS
	DECLARE @NoOp int = 0;
	THROW 50000, 'An errors has occured!', 1;
GO

EXEC Examples.HandlingErrors;
GO

CREATE PROCEDURE Examples.StopBatchError
AS
	DECLARE @NoOp int = 100;
	THROW 50000, 'Batch Stopped!', 1;
	SELECT @NoOp, SYSDATETIME();
GO
DROP PROCEDURE Examples.ContinueBatchError
CREATE PROCEDURE Examples.ContinueBatchError
AS
	DECLARE @NoOp int = 100;
	RAISERROR ('Batch Continued!', 16, 1);
	SELECT @NoOp, SYSDATETIME();
GO

EXEC Examples.StopBatchError;
EXEC Examples.ContinueBatchError;

CREATE TABLE Examples.Worker
(
	WorkerId int NOT NULL IDENTITY (1,1) CONSTRAINT PKWorker PRIMARY KEY,
	WorkerName nvarchar(50) NOT NULL CONSTRAINT AKWorker UNIQUE
);
GO
SELECT * FROM Examples.Worker

CREATE TABLE Examples.WorkerAssignment
(
	WorkerAssignmentId int IDENTITY(1,1) CONSTRAINT PKWorkerAssignment PRIMARY KEY,
	WorkerId int NOT NULL,
	CompanyName nvarchar(50) NOT NULL
		CONSTRAINT CHKWorkerAssignment_CompanyName
			CHECK (CompanyName<> 'Contoso, Ltd.'),
	CONSTRAINT AKWorkerAssignment UNIQUE (WorkerId, CompanyName)
);
GO
SELECT * FROM Examples.WorkerAssignment

CREATE PROCEDURE Examples.Worker_AddWithAssignment
	@WorkerName nvarchar(50),
	@CompanyName nvarchar(50)
AS
	SET NOCOUNT ON;
	--do any non-data testing before starting the transaction\
	IF @WorkerName IS NULL or @CompanyName IS NULL
		THROW 50000,'Both parameters must be not null',1;

	DECLARE @Location nvarchar(30), @NewWorkerId int;
	BEGIN TRY
		BEGIN TRANSACTION;

		SET @Location = 'Creating Worker Row';
		INSERT INTO Examples.Worker(Workername)
		VALUES (@WorkerName);

		SELECT	@NewWorkerId = SCOPE_IDENTITY(),
				@Location = 'Creating WorkAssignment Row';

		INSERT INTO Examples.WorkerAssignment(WorkerId, CompanyName)
		VALUES (@NewWorkerId, @CompanyName);

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		--at the end of the call, we want the transaction rolled back
		--rollback the transaction first, so it definitely occurs as the THROW
		--statement would keep it from happening.
		IF XACT_STATE() <> 0	--if there is a transaction in effect
								--commitable or not
			ROLLBACK TRANSACTION;
		
		--format a message that tells the error and then THROW it.
		DECLARE @ErrorMessage nvarchar(4000);
		SET @ErrorMessage = CONCAT('Error occurred during: ''',@Location,'''',
									' System Error: ',
									ERROR_NUMBER(),':',ERROR_MESSAGE());
		THROW 50000, @ErrorMessage, 1;
	END CATCH;
GO