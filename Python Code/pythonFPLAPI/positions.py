import requests, json
from pprint import pprint
import pandas as pd
pd.set_option('display.max_columns', None)

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

# create players dataframe
positions = pd.json_normalize(r['element_types'])

# show some information about first five players
pprint(positions.head())