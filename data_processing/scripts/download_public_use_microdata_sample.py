import requests
from bs4 import BeautifulSoup
from pathlib import Path
import zipfile
import io
from concurrent.futures import ThreadPoolExecutor
from functools import partial
import argparse

def download_and_extract(url, output_dir):
    try:
        print(f"Downloading {url}")
        zip_name = url.split('/')[-1].replace('.zip', '')
        zip_dir = output_dir / zip_name
        zip_dir.mkdir(exist_ok=True)
        
        response = requests.get(url)
        with zipfile.ZipFile(io.BytesIO(response.content)) as z:
            z.extractall(zip_dir)
        return f"Successfully processed {url}"
    except Exception as e:
        return f"Failed to process {url}: {str(e)}"

def get_url_and_output_dir(year, output_path):
    base = "https://www2.census.gov/programs-surveys/acs/data/pums"
    if int(year) <= 2006:
        base_url = f"{base}/{year}/"
    else:
        base_url = f"{base}/{year}/1-Year/"
    output_dir = Path(output_path).expanduser() / f"pums/{year}/1-Year"
    return base_url, output_dir

def download_census_data(year, output_path, max_workers=4, debug=False):
    base_url, output_dir = get_url_and_output_dir(year, output_path)
    output_dir.mkdir(parents=True, exist_ok=True)

    try:
        soup = BeautifulSoup(requests.get(base_url).content, 'html.parser')
        zip_urls = [base_url + link['href'] for link in soup.find_all('a', href=True) 
                    if link['href'].startswith('csv_') and link['href'].endswith('.zip')]
        
        if not zip_urls:
            print(f"No CSV zip files found for {year}")
            return

        if debug:
            zip_urls = zip_urls[:1]
            print(f"Debug mode: only processing first URL for {year}")

        with ThreadPoolExecutor(max_workers=max_workers) as executor:
            download_fn = partial(download_and_extract, output_dir=output_dir)
            results = list(executor.map(download_fn, zip_urls))
        
        for result in results:
            print(result)
    except requests.RequestException as e:
        print(f"Failed to access data for {year}: {str(e)}")

def download_year_range(start_year, end_year, output_path, max_workers=4, debug=False):
    print(f"Downloading data for years {start_year} through {end_year}")
    print(f"Debug mode: {debug}")
    for year in range(start_year, end_year + 1):
        print(f"\nProcessing year {year}")
        download_census_data(str(year), output_path, max_workers, debug)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Download Census PUMS data')
    parser.add_argument('--year', type=str, 
                      help='Specific year to download (optional)')
    parser.add_argument('--output', default='~/data/american_community_survey', 
                      help='Output directory path')
    parser.add_argument('--workers', type=int, default=4, 
                      help='Number of parallel downloads')
    parser.add_argument('--debug', action='store_true',
                      help='Debug mode: only download first URL per year')
    
    args = parser.parse_args()
    
    if args.year:
        download_census_data(args.year, args.output, args.workers, args.debug)
    else:
        download_year_range(2023, 2023, args.output, args.workers, args.debug)