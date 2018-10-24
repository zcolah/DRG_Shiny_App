# Library necessary packages
library(zipcode)


# Read in zipcode data
data(zipcode)

# Get the latitude and longitude by combining the two datasets
hospital.data.lat.lon <- hospital.data %>% 
  mutate(zip = paste(Provider.Zip.Code)) %>% 
  left_join(zipcode, by="zip")

# Source the script I wrote
source("getcounty.r")

# Save all the counties in a list
counties <- hospital.data.lat.lon[, 17:16] %>% 
  filter(!is.na(latitude), !is.na(longitude)) %>% 
  latlong2county()

# Create the dataframe we will use later
hospital.data.county <- hospital.data.lat.lon %>%
  filter(!is.na(latitude), !is.na(longitude))

# Read in standard county codes
data(county.fips)

# Save the counties into the dataframe
hospital.data.county$county <- counties

# Get only the columns we need and combine them with the standard county codes
hospital.data.counties <- hospital.data.county %>%
  select(Provider.City, county, Average.Covered.Charges, Average.Total.Payments) %>%  
  group_by(county) %>% 
  summarize(County.Covered.Charges = mean(as.numeric(gsub("\\$", "", Average.Covered.Charges)) / as.numeric(gsub("\\$", "", Average.Total.Payments)), na.rm = TRUE)) %>% 
  mutate(polyname = county) %>% 
  left_join(county.fips, by="polyname") %>% 
  mutate(value = County.Covered.Charges, region = fips) %>% 
  select(value, region)