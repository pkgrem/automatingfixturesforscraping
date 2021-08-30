# Automating Fixtures for Scraping
Creating auto generated URLs for Oddschecker by using the FPL Api

Firstly you must go onto the URL:
https://fantasy.premierleague.com/api/fixtures/

From here, save the file as a json file. In this instance I have saved the file as fixture.json

Then you must import the data into your local environment, through the script: Fixtures.SQL

From here you can use another script called URLsForScraping.SQL and it will provide you with the fixtures for scraping within Oddschecker week on week.

I have taken the naming conventions from OddsChecker already and used cases and a concat in SQL to make the URL readable.

I've sorted by only the gameweek which is next by excluding gameweeks which were finished.

![image](https://user-images.githubusercontent.com/8496923/131267076-c275d338-1d13-48c1-9f20-d00aaf351905.png)

**Next Step:**
Download Python!
https://www.python.org/downloads/

I've downloaded version 3.9.6.

I then installed PyCharm and created a new project and a virtual envionrment. Right now its doing all the automated stuff and I'm left with this plain project folder:

![image](https://user-images.githubusercontent.com/8496923/131267387-7a541298-380e-40d7-a1d4-b3f51a3d8c6a.png)

I then went into settings on pycharm and then went to the Project and then in Python Interpreter I added mysql-connector-python version 8.0.26 and installed the package

![image](https://user-images.githubusercontent.com/8496923/131267613-8a7ef23c-2ee0-441b-87c4-68ec90025b53.png)

I created a few more stored procedures and then created a job to get it to update every 24 hours.

In the Server Configuration Manager

![image](https://user-images.githubusercontent.com/8496923/131337758-873fc0e3-1824-4afd-9717-78c1a8cebf12.png)

The agent was not started so I started the agent
![image](https://user-images.githubusercontent.com/8496923/131337834-bc9ddd26-bf16-4403-b1ff-d72e49976cfd.png)

The button was disabled so I had to go into services.msc and change it from disabled:
![image](https://user-images.githubusercontent.com/8496923/131338150-d0718ce1-4472-46d0-9367-cf4e4e103e6b.png)
