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
positions = pd.json_normalize(r['element_types'])
players = pd.json_normalize(r['elements'])

#joining the data
# join players to teams
df = pd.merge(
    left=players,
    right=teams,
    left_on='team',
    right_on='id'
)

# show joined result
pprint(df[['first_name', 'second_name', 'now_cost', 'cost_change_start', 'selected_by_percent', 'name']].head())