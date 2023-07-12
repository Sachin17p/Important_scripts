# Author: Rafshan Ul Atik
# Date: Feb 2023
# Email: rafshanulatik@gmail.com
#
import yaml
import pandas as pd

# Read the YAML file
with open('thermal_properties.yaml', 'r') as stream:
    data = yaml.safe_load(stream)

# Create an empty dataframe
df = pd.DataFrame(columns=['Temperature (K)', 'Free Energy (kJ/mol)', 'Entropy (J/K/mol)', 'Heat Capacity (J/K/mol)', 'Energy (kJ/mol)'])

# Loop through the thermal properties and append to the dataframe
for item in data['thermal_properties']:
    df = df.append({
        'Temperature (K)': item['temperature'],
        'Free Energy (kJ/mol)': item['free_energy'],
        'Entropy (J/K/mol)': item['entropy'],
        'Heat Capacity (J/K/mol)': item['heat_capacity'],
        'Energy (kJ/mol)': item['energy'],
	'Svib(eV/atom/K)':0.0103642492*item['entropy']
    }, ignore_index=True)

df['T*Svib(eV/atom/K)'] = df['Temperature (K)']*df['Svib(eV/atom/K)']

# Save the dataframe to an Excel file
df.to_excel('thermal_properties.xlsx', index=False)
