# Reactive functions

library(dplyr)
source('./Data Wrangling.R')

  
cities <- function(state) {
  cities.in.state <- DRG.location.payments %>% 
    ungroup() %>% 
    select(Provider.State, Provider.City) %>% 
    distinct(Provider.State, Provider.City) %>% 
    filter(Provider.State == state) %>% 
    select(Provider.City)
  return(cities.in.state$Provider.City)
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

hospitals <- function(zip) {
  hos.in.zip <- DRG.location.payments %>% 
    ungroup() %>%
    select(Provider.Zip.Code, Hospital.Referral.Region.Description) %>% 
    distinct(Provider.Zip.Code, Hospital.Referral.Region.Description) %>% 
    filter(Provider.Zip.Code == zip) %>% 
    select(Hospital.Referral.Region.Description)
  return(hos.in.zip$Hospital.Referral.Region.Description)
}

drg <- function(hospital) {
  drg.in.hos <- DRG.location.payments %>% 
    ungroup() %>% 
    select(Hospital.Referral.Region.Description, DRG.Definition) %>% 
    distinct(Hospital.Referral.Region.Description, DRG.Definition) %>% 
    filter(Hospital.Referral.Region.Description == hospital) %>% 
    select(DRG.Definition)
  return(drg.in.hos$DRG.Definition)
}

