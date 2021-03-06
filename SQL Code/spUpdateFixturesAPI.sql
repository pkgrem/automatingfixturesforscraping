USE [master]
GO
/****** Object:  StoredProcedure [dbo].[spUpdateFixtures]    Script Date: 30/08/2021 17:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spUpdateFixtures] AS 
DROP TABLE [fixtures]

-- Variable declaration related to the Object.
DECLARE @token INT;
DECLARE @ret INT;

-- Variable declaration related to the Request.
DECLARE @url NVARCHAR(MAX);
DECLARE @authHeader NVARCHAR(64);
DECLARE @contentType NVARCHAR(64);

-- Variable declaration related to the JSON string.
DECLARE @json AS TABLE(Json_Table NVARCHAR(MAX))


-- Define the URL
SET @url = 'https://fantasy.premierleague.com/api/fixtures/'

-- This creates the new object.
EXEC @ret = sp_OACreate 'MSXML2.XMLHTTP', @token OUT;
IF @ret <> 0 RAISERROR('Unable to open HTTP connection.', 10, 1);

-- This calls the necessary methods.
EXEC @ret = sp_OAMethod @token, 'open', NULL, 'GET', @url, 'false';
--EXEC @ret = sp_OAMethod @token, 'setRequestHeader', NULL, 'Authentication', @authHeader;
--EXEC @ret = sp_OAMethod @token, 'setRequestHeader', NULL, 'Content-type', @contentType;
EXEC @ret = sp_OAMethod @token, 'send'

-- Grab the responseText property, and insert the JSON string into a table temporarily. This is very important, if you don't do this step you'll run into problems.
INSERT into @json (Json_Table) EXEC sp_OAGetProperty @token, 'responseText'

--select * from @json
-- Select the JSON string from the Table we just inserted it into. You'll also be able to see the entire string with this statement.
SELECT * 
INTO Fixtures
FROM OPENJSON((SELECT * FROM @json))
with (code INT,
event VARCHAR(20),
finished VARCHAR(20),
finished_provisional VARCHAR(20),
id VARCHAR(20),
kickoff_time VARCHAR(20),
minutes VARCHAR(20),
provisional_start_time VARCHAR(20),
started VARCHAR(20),
team_a VARCHAR(20),
team_a_score VARCHAR(20),
--t1.name team_a_name VARCHAR(20),
team_h VARCHAR(20),
team_h_score VARCHAR(20)
)