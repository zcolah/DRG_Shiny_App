# Reactive functions

library(dplyr)
source('./scripts/Data Wrangling.R')


region <- function(state) {
  regions.in.state <- DRG.location.payments %>% 
    ungroup() %>% 
    select(Provider.State, Hospital.Referral.Region.Description) %>% 
    distinct(Provider.State, Hospital.Referral.Region.Description) %>% 
    filter(Provider.State == state) %>% 
    select(Hospital.Referral.Region.Description)
  return(regions.in.state$Hospital.Referral.Region.Description)
}

cities <- function(region) {
  cities.in.region <- DRG.location.payments %>% 
    ungroup() %>% 
    select(Hospital.Referral.Region.Description, Provider.City) %>% 
    distinct(Hospital.Referral.Region.Description, Provider.City) %>% 
    filter(Hospital.Referral.Region.Description == region) %>% 
    select(Provider.City)
  return(cities.in.region$Provider.City)
}
  
zip.codes <- function(city) {
  zips.in.city <- DRG.location.payments %>% 
    ungroup() %>%
    select(Provider.City, Provider.Zip.Code) %>% 
    distinct(Provider.City, Provider.Zip.Code) %>% 
    filter(Provider.City == city) %>% 
    select(Provider.Zip.Code)
  return(zips.in.city$Provider.Zip.Code)
}

drg <- function(zip) {
  drgs.in.zip <- DRG.location.payments %>% 
    ungroup() %>% 
    select(Provider.Zip.Code, DRG.Definition) %>% 
    distinct(Provider.Zip.Code, DRG.Definition) %>% 
    filter(Provider.Zip.Code == zip) %>% 
    select(DRG.Definition)
  return(drgs.in.zip$DRG.Definition)
}

