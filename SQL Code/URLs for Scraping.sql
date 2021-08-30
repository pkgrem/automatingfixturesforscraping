;with cte as (
select f.code, event as Gameweek, kickoff_time,
CASE 
when team_h = 1 then 'arsenal' 
when team_h = 2 then 'aston-villa' 
when team_h = 3 then 'brentford' 
when team_h = 4 then 'brighton' 
when team_h = 5 then 'Burnley' 
when team_h = 6 then 'chelsea' 
when team_h = 7 then 'crystal-palace' 
when team_h = 8 then 'everton' 
when team_h = 9 then 'leeds' 
when team_h = 10 then 'leicester' 
when team_h = 11 then 'liverpool' 
when team_h = 12 then 'man-city' 
when team_h = 13 then 'man-utd' 
when team_h = 14 then 'newcastle' 
when team_h = 15 then 'norwich' 
when team_h = 16 then 'southampton' 
when team_h = 17 then 'tottenham' 
when team_h = 18 then 'watford' 
when team_h = 19 then 'west-ham' 
when team_h = 20 then 'wolverhampton' 
else ''
End as HomeTeamName,


f.team_h, f.team_a,
CASE 
when team_a = 1 then 'arsenal' 
when team_a = 2 then 'aston-villa' 
when team_a = 3 then 'brentford' 
when team_a = 4 then 'brighton' 
when team_a = 5 then 'Burnley' 
when team_a = 6 then 'chelsea' 
when team_a = 7 then 'crystal-palace' 
when team_a = 8 then 'everton' 
when team_a = 9 then 'leeds' 
when team_a = 10 then 'leicester' 
when team_a = 11 then 'liverpool' 
when team_a = 12 then 'man-city' 
when team_a = 13 then 'man-utd' 
when team_a = 14 then 'newcastle' 
when team_a = 15 then 'norwich' 
when team_a = 16 then 'southampton' 
when team_a = 17 then 'tottenham' 
when team_a = 18 then 'watford' 
when team_a = 19 then 'west-ham' 
when team_a = 20 then 'wolverhampton' 
else ''
End as AwayTeamName,
event, finished
from Fixtures f)
select *, 
concat('www.oddschecker.com/football/english/premier-league/', HomeTeamName, '-v-', AwayTeamName, '/anytime-goalscorer') as AnytimeURL,
concat('www.oddschecker.com/football/english/premier-league/', HomeTeamName, '-v-', AwayTeamName, '/clean-sheet') as CleanSheetURL
 from cte 
where finished = 'false'
and Gameweek = (select top 1 event from Fixtures where finished = 'false' ) ;

--select * from fixtures
--where event = 4;
----2210272

--select * from Teams
--order by id;