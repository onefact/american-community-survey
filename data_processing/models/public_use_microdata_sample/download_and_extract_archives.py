import pandas as pd
import requests
import zipfile
import io
import os
from tqdm import tqdm
from concurrent.futures import ThreadPoolExecutor, as_completed

def download_and_extract_csv(url, archive_dir):
    """Download a ZIP file and extract its contents."""
    try:
        # Download and unzip the archive
        r = requests.get(url)
        z = zipfile.ZipFile(io.BytesIO(r.content))
        z.extractall(archive_dir)
        
        # Return paths to the extracted CSV files
        return [os.path.join(archive_dir, file_info.filename) for file_info in z.infolist() if file_info.filename.endswith('.csv')]
    except Exception as e:
        print(f"Error downloading or extracting {url}: {e}")
        return []

def model(dbt, session):
    # Correctly access the variable from dbt_project.yml
    base_url = dbt.config.get('public_use_microdata_sample_url')  # Assuming this is correctly set

    # Fetch URLs from your table or view
    query = "SELECT * FROM list_urls"
    result = session.execute(query).fetchall()
    columns = [desc[0] for desc in session.description]
    url_df = pd.DataFrame(result, columns=columns)

    # Determine the base directory for data storage
    base_path = os.path.expanduser(dbt.config.get('output_path'))
    base_dir = os.path.join(base_path, f'{base_url.rstrip("/").split("/")[-2]}/{base_url.rstrip("/").split("/")[-1]}')

    extracted_files = []
    with ThreadPoolExecutor(max_workers=10) as executor:
        future_to_url = {executor.submit(download_and_extract_csv, row['URL'], os.path.join(base_dir, row['URL'].split('/')[-1].split('.')[0])): row['URL'] for index, row in url_df.iterrows()}
        
        for future in tqdm(as_completed(future_to_url), total=len(future_to_url), desc="Downloading and extracting"):
            url = future_to_url[future]
            try:
                result = future.result()
                extracted_files.extend(result)
            except Exception as exc:
                print(f'{url} generated an exception: {exc}')

    # Convert the list of extracted file paths to a DataFrame
    paths_df = pd.DataFrame(extracted_files, columns=['csv_path'])

    # Return the DataFrame with paths to the extracted CSV files
    return paths_df

# Mock dbt and session for demonstration; replace with actual dbt and session in your environment
class MockDBT:
    def config(self, key):
        return {
            'public_use_microdata_sample_url': 'https://example.com/path/to/your/csv/files',
            'output_path': '~/path/to/your/output/directory'
        }.get(key, '')

class MockSession:
    def execute(self, query):
        # Mock response; replace with actual fetching logic
        return [{"URL": "https://example.com/path/to/your/csv_file.zip"} for _ in range(10)]

dbt = MockDBT()
session = MockSession()

if __name__ == "__main__":
    # Directly calling model function for demonstration; integrate properly within your dbt project
    df = model(dbt, session)
    print(df)
