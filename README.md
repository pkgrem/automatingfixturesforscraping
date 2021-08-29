# automatingfixturesforscraping
Creating auto generated URLs for Oddschecker by using the FPL Api

Firstly you must go onto the URL:
https://fantasy.premierleague.com/api/fixtures/

From here, save the file as a json file. In this instance I have saved the file as fixture.json

Then you must import the data into your local environment, through the script: Fixtures.SQL

From here you can use another script called URLsForScraping.SQL and it will provide you with the fixtures for scraping within Oddschecker week on week.

I have taken the naming conventions from OddsChecker already and used cases and a concat in SQL to make the URL readable.

I've sorted by only the gameweek which is next by excluding gameweeks which were finished.

![image](https://user-images.githubusercontent.com/8496923/131267076-c275d338-1d13-48c1-9f20-d00aaf351905.png)

