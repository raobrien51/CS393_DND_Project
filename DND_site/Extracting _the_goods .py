import pandas as pd

spells_df = pd.read_excel(r"C:\Users\Timothy.Larson\Downloads\D&D5eSpellList.xlsx")

# Displaying the first few rows of the dataframe to understand its structure and locate the required columns


spells_extracted = spells_df[['Name', 'Level', 'School']].copy()
spells_extracted.columns = ['SpellName', 'spellLvl', 'School']
spells_extracted.insert(0, 'spell_id', range(1, len(spells_extracted) + 1))

# printed out the 524 spells in the correct formated for the INSERT INTO values
spell_data_list = list(spells_extracted.itertuples(index=False, name=None))
for i, j in enumerate(spell_data_list):
    
    sp = list(spell_data_list[i])
    sp[0] = str(sp[0])
    sp[2] = str(sp[2])
    spell_data_list[i] = tuple(sp)
    print(spell_data_list[i])

#Possible Way to work with GitHub so I don't have to run everything on my device and the copy and paste
#Still working out kinks
'''
import pandas as pd
import requests
from io import BytesIO
from sqlalchemy import create_engine

# Step 1: Download the Excel file from GitHub
url = 'https://raw.githubusercontent.com/username/repository/branch/path_to_your_file.xlsx'
response = requests.get(url)
excel_data = pd.read_excel(BytesIO(response.content), usecols=["Column1", "Column2"])

# Step 2: Connect to your SQL database
engine = create_engine("your_sql_database_connection_string")

# Step 3: Insert the data into your SQL table
excel_data.to_sql("your_table_name", con=engine, if_exists="append", index=False)

'''