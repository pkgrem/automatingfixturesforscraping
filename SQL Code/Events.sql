--DECLARE @JSON VARCHAR(MAX)

--SELECT @JSON = BulkColumn
--FROM OPENROWSET 
--(BULK 'C:\Users\Paddy\Desktop\download.json', SINGLE_CLOB) 
--AS j;

--If (ISJSON(@JSON)=1)
--SELECT @JSON AS 'JSON Text';
----
DECLARE @JSON VARCHAR(MAX)

SELECT @JSON = BulkColumn
FROM OPENROWSET 
(BULK 'C:\Users\Paddy\Desktop\download.json', SINGLE_CLOB) 
AS j;

If (ISJSON(@JSON)=1)
Select * FROM OPENJSON (@JSON, /* optional*/ '$.events') 
WITH (id VARCHAR(7), 
name VARCHAR(20),
deadline_time VARCHAR(20),
averagescore INT '$.average_entry_score',
finished VARCHAR(5),
highest_scoring_team VARCHAR(20) '$.highest_scoring_entry',
deadline_time_epoch VARCHAR(20),
deadline_time_game_offset VARCHAR(20),
highest_score VARCHAR(20),
is_previous_gameweek VARCHAR(20) '$.is_previous',
is_current_gameweek VARCHAR(20)  '$.is_current',
is_next_gameweek VARCHAR(20)  '$.is_next',
chip_plays VARCHAR(20),
most_selected VARCHAR(20),
most_transferred_in VARCHAR(20),
top_element VARCHAR(20),
top_element_info VARCHAR(20),
transfers_made VARCHAR(20),
most_captained VARCHAR(20),
most_vice_captained VARCHAR(20)

) -- new column name
