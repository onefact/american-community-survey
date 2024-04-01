import geopandas as gpd
import pandas as pd
import os
import shapely

# This function would be called by dbt in the context of a Python model
def model(dbt, session):
    # Assuming 'microdata_area_shapefile_paths' is a dbt model providing shapefile paths
    shapefile_paths_df = dbt.ref("microdata_area_shapefile_paths")

    shapefile_paths_df = shapefile_paths_df.to_df()
    # Initialize an empty list to store GeoDataFrames
    gdfs = []
    
    # Iterate over the DataFrame rows as dictionaries
    for index, row in shapefile_paths_df.iterrows():
        # Read each shapefile into a GeoDataFrame
        gdf = gpd.read_file(row['shp_path'])
        gdf['geometry'] = gdf['geometry'].apply(lambda geom: geom.wkt)
        gdfs.append(gdf)
    
    # Concatenate all GeoDataFrames into a single one
    merged_gdf = gpd.pd.concat(gdfs)
    merged_gdf['geometry'] = merged_gdf['geometry'].apply(shapely.wkt.loads)
    base_path = os.path.expanduser(dbt.config.get('output_path'))
    gpd.GeoDataFrame(merged_gdf).to_file(os.path.join(base_path, 'combined_census_microdata_tiger_shapefile.shp'), index=False)
    # merged_gdf.to_file(os.path.join(base_path, '2020_census_microdata_tiger_shapefile.shp'), index=False)
    
    # Here you would potentially transform merged_gdf or simply return it
    # Transformations or analysis can go here

    # The final GeoDataFrame needs to be returned in a format compatible with your database
    # For example, converting geospatial data to a format like WKT (Well-Known Text) if necessary
    # and then converting the GeoDataFrame to a regular DataFrame for dbt to handle
    final_df = pd.DataFrame(merged_gdf)

    # Return the final DataFrame to be saved by dbt as a table or view
    return final_df
