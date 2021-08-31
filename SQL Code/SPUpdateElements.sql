USE [master]
GO
/****** Object:  StoredProcedure [dbo].[spUpdateFixtures]    Script Date: 31/08/2021 23:30:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[spUpdateElements] AS 
DROP TABLE [Elements]

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
INTO Elements
FROM OPENJSON((SELECT * FROM @json), N'$.elements')
WITH (
chance_of_playing_next_round	  VARCHAR(20),
chance_of_playing_this_round	  VARCHAR(20),
code	  VARCHAR(20),
cost_change_event	  VARCHAR(20),
cost_change_event_fall	  VARCHAR(20),
cost_change_start	  VARCHAR(20),
cost_change_start_fall	  VARCHAR(20),
dreamteam_count	  VARCHAR(20),
element_type	  VARCHAR(20),
ep_next	  VARCHAR(20),
ep_this	  VARCHAR(20),
event_points	  VARCHAR(20),
first_name	  VARCHAR(20),
form	  VARCHAR(20),
id	  VARCHAR(20),
in_dreamteam	  VARCHAR(20),
news	  VARCHAR(20),
news_added	  VARCHAR(20),
now_cost	  VARCHAR(20),
photo	  VARCHAR(20),
points_per_game	  VARCHAR(20),
second_name	  VARCHAR(20),
selected_by_percent	  VARCHAR(20),
special	  VARCHAR(20),
squad_number	  VARCHAR(20),
status	  VARCHAR(20),
team	  VARCHAR(20),
team_code	  VARCHAR(20),
total_points	  VARCHAR(20),
transfers_in	  VARCHAR(20),
transfers_in_event	  VARCHAR(20),
transfers_out	  VARCHAR(20),
transfers_out_event	  VARCHAR(20),
value_form	  VARCHAR(20),
value_season	  VARCHAR(20),
web_name	  VARCHAR(20),
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
influence_rank	  VARCHAR(20),
influence_rank_type	  VARCHAR(20),
creativity_rank	  VARCHAR(20),
creativity_rank_type	  VARCHAR(20),
threat_rank	  VARCHAR(20),
threat_rank_type	  VARCHAR(20),
ict_index_rank	  VARCHAR(20),
ict_index_rank_type	  VARCHAR(20),
corners_and_indirect_freekicks_order	  VARCHAR(20),
corners_and_indirect_freekicks_text	  VARCHAR(20),
direct_freekicks_order	  VARCHAR(20),
direct_freekicks_text	  VARCHAR(20),
penalties_order	  VARCHAR(20),
penalties_text	  VARCHAR(20)
)