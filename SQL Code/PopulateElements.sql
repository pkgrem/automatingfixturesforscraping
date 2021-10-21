USE [master]
GO
/****** Object:  StoredProcedure [dbo].[spUpdateElement_ID1]    Script Date: 19/10/2021 19:42:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[spUpdateElementsHistory] AS 
DROP TABLE [PlayerHistory]

-- Variable declaration related to the Object.
DECLARE @token INT;
DECLARE @ret INT;


-- Variable declaration related to the Request.
DECLARE @url NVARCHAR(MAX);
DECLARE @authHeader NVARCHAR(64);
DECLARE @contentType NVARCHAR(64);

-- Variable declaration related to the JSON string.
DECLARE @json AS TABLE(Json_Table NVARCHAR(MAX))

-- DECLARE CURSOR
DECLARE detailsCursor CURSOR LOCAL FOR 
SELECT ID 
from [dbo].[Element_ID]

OPEN detailsCursor
FETCH NEXT FROM detailsCursor  INTO @url

-- Set the status for the cursor
WHILE @@FETCH_STATUS = 0  

BEGIN  
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
INTO PlayerHistory
FROM OPENJSON((SELECT * FROM @json), N'$.history')
WITH (
element	  VARCHAR(20),
fixture	  VARCHAR(20),
opponent_team	  VARCHAR(20),
total_points	  VARCHAR(20),
was_home	  VARCHAR(20),
kickoff_time	  VARCHAR(20),
team_h_score	  VARCHAR(20),
team_a_score	  VARCHAR(20),
round	  VARCHAR(20),
minutes	  VARCHAR(20),
goals_scored	  VARCHAR(20),
assists	  VARCHAR(20),
clean_sheets	  VARCHAR(20),
goals_conceded	  VARCHAR(20),
own_goals	  VARCHAR(20),
penalties_saved	  VARCHAR(20),
penalties_missed	  VARCHAR(20),
yellow_cards	  VARCHAR(20),
red_cards	  VARCHAR(20),
saves	  VARCHAR(20),
bonus	  VARCHAR(20),
bps	  VARCHAR(20),
influence	  VARCHAR(20),
creativity	  VARCHAR(20),
threat	  VARCHAR(20),
ict_index	  VARCHAR(20),
value	  VARCHAR(20),
transfers_balance	  VARCHAR(20),
selected	  VARCHAR(20),
transfers_in	  VARCHAR(20),
transfers_out	  VARCHAR(20)
)

FETCH NEXT FROM detailsCursor INTO @url 
END 
-- Define the URL
--SET @url = '--https://fantasy.premierleague.com/api/element-summary/1/'
--https://stackoverflow.com/questions/40285851/sql-cursor-insert-result-into-a-table
-- This creates the new object.
--CLOSE detailsCursor
--DEALLOCATE detailsCursor