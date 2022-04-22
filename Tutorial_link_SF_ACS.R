# source https://campuswire.com/c/GEE9F3E0C/feed/6

library(tidyverse)
library(sf)

shapename <- read_sf("data/raw_data/raw_data_from_king_county/KCM_Stops_Data/kcm_stops.shp")

stops <- cbind(shapename, st_transform(x = shapename, crs = 4326) %>% st_coordinates)

head(stops)

#load the census tract shape files for King County using the tigris package
kctracts <- tigris::tracts(state = 53, county = 033, cb = FALSE, year = 2020)

stops_sf <- st_as_sf(data.frame(x = stops$X, y = stops$Y), coords = c('x', 'y'), crs = st_crs(kctracts))

#create a new data frame that matches the bus stop data to the census tract
stops_census <- stops_sf %>% mutate(
  intersection = as.integer(st_intersects(geometry, kctracts)),
  GEOID = if_else(is.na(intersection), '', kctracts$GEOID[intersection])
)

#the GEOID is also available in the King_County_ACS_2019_tract.csv file and 
#allows to match every bus stop with socio-demographic information such as ethnicity or income for this area.
