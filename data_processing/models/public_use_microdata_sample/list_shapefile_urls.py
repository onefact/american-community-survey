# models/list_acs_data_urls.py

import requests
from bs4 import BeautifulSoup
import pandas as pd

def model(dbt, session):
    # URL of the directory containing CSV files
    url = dbt.config.get('microdata_area_shapefile_url')
    # Send a GET request
    response = requests.get(url)
    
    # Parse HTML content
    soup = BeautifulSoup(response.content, 'html.parser')
    
    # Find all zip file links
    links = soup.find_all('a', href=True)
    csv_zip_urls = [url + link['href'] for link in links if link['href'].startswith('tl') and link['href'].endswith('.zip')]
    
    # Convert list of URLs to DataFrame
    df = pd.DataFrame(csv_zip_urls, columns=['URL'])

    # For debugging
    # print(df['URL'].values)
    
    return df
