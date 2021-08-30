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

After this I started the service and got the error stating the SQL Server Agent service on Local Computer started and then stopped. Some services stop automatically if they are not in use by other services or programs

lol
This installation of SQL Server Agent is disabled. The edition of SQL Server that installed this service does not support SQL Server Agent.

REINSTALL TIME

I had to do a new install with the developer version. Then created a new instance called FPL.
https://download.microsoft.com/download/d/a/2/da259851-b941-459d-989c-54a18a5d44dd/SQL2019-SSEI-Dev.exe

After that step of reinstalling, there is now an SQL server agent. I had to go back into SQL Server Configuration Manager and activate it. As it runs manualy. I've changed it to run automatic.

![image](https://user-images.githubusercontent.com/8496923/131348069-d38cf4b8-263e-4176-8fed-c03393d0a8a3.png)

From here I've to run my scripts to get the DB active.

After re-adding the scripts I then created a job to update the table every 24 hours:
![image](https://user-images.githubusercontent.com/8496923/131349748-d3d69241-e14c-4d65-b9b8-57fa2cbf96c0.png)

The job itself just runs the SP. Nothing to comlpicated.
