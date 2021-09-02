import requests, json
from pprint import pprint
import pandas as pd
pd.set_option('display.max_columns', 21)

# base url for all FPL API endpoints
base_url = 'https://fantasy.premierleague.com/api/'

# get data from bootstrap-static endpoint
r = requests.get(base_url+'bootstrap-static/').json()

# show the top level fields
#pprint(r, indent=2, depth=1, compact=True)

# get player data from 'elements' field
#players = r['elements']

# show data for first player
#pprint(players[3])

# create teams dataframe
teams = pd.json_normalize(r['teams'])

# show some information about teams
pprint(teams[['code', 'name', 'short_name', 'strength', 'strength_overall_home', 'strength_overall_away', 'strength_attack_home', 'strength_attack_away', 'strength_defence_home', 'strength_defence_away''']].head())

#print everything
#pprint(teams.head())
