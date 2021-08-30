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
Select * 
INTO Teams
FROM OPENJSON (@JSON, /* optional*/ '$.teams') 
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