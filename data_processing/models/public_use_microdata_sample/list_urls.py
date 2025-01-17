import requests
from bs4 import BeautifulSoup
import pandas as pd

def model(dbt, session):
    # setting configuration
    dbt.config(materialized="table")
    
    # URL of the directory containing CSV files
    url = dbt.config.get('public_use_microdata_sample_url')
    # Send a GET request
    response = requests.get(url)
    
    # Parse HTML content
    soup = BeautifulSoup(response.content, 'html.parser')
    
    # Find all zip file links
    links = soup.find_all('a', href=True)
    csv_zip_urls = [url + link['href'] for link in links if link['href'].startswith('csv_') and link['href'].endswith('.zip')]
    
    # Convert list of URLs to DataFrame
    df = pd.DataFrame(csv_zip_urls, columns=['URL'])

    # For debugging
    print(df['URL'].values)
    
    # save to parquet file
    df.to_parquet('~/data/american_community_survey/urls.parquet', index=False)
    
    return df
