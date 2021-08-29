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
(BULK 'D:\FPL\Youtube\API\fixture.json', SINGLE_CLOB) 
AS j;

If (ISJSON(@JSON)=1)
Select * FROM OPENJSON  (@JSON)
--left join Teams t on t.id = e.team_h
--left join Teams ta on ta.id = e.team_a
WITH (
code VARCHAR(20),
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
--t.name team_h_name VARCHAR(20)
) -- new column name
