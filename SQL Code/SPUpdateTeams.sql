USE [master]
GO
/****** Object:  StoredProcedure [dbo].[spUpdateFixtures]    Script Date: 31/08/2021 23:30:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Alter PROCEDURE [dbo].[spUpdateTeams] AS 
DROP TABLE [Teams]

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
SET @url = 'https://fantasy.premierleague.com/api/bootstrap-static/'

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
--INTO Teams
FROM OPENJSON((SELECT * FROM @json), N'$.teams')
WITH (id INT '$.code', 
name VARCHAR(20),
win VARCHAR(20),
draw VARCHAR(20),
loss VARCHAR(20),
form VARCHAR(20),

played VARCHAR(20),
points VARCHAR(20),
position VARCHAR(20),
short_name VARCHAR(20),
strength VARCHAR(20),
team_division VARCHAR(20),
unavailable VARCHAR(20),
strength_overall_home INT,
strength_overall_away INT,
strength_attack_home INT,
strength_attack_away INT,
strength_defence_home INT,
strength_defence_away INT,
pulse_id INT
)