# Reactive functions

library(dplyr)

# build a funciton that takes a state as an argument to locate and return all the corresponding
# Hospital.Referral.Region.Description.
Region <- function(state) {
  regions.in.state <- DRG.location.payments %>% 
    ungroup() %>% 
    select(Provider.State, Hospital.Referral.Region.Description) %>% 
    distinct(Provider.State, Hospital.Referral.Region.Description) %>% 
    filter(Provider.State == state) %>% 
    select(Hospital.Referral.Region.Description)
  return(regions.in.state$Hospital.Referral.Region.Description)
}

# build a funciton that takes a region as an argument to locate and return all the corresponding
# Provider Cities.
Cities <- function(region) {
  cities.in.region <- DRG.location.payments %>% 
    ungroup() %>% 
    select(Hospital.Referral.Region.Description, Provider.City) %>% 
    distinct(Hospital.Referral.Region.Description, Provider.City) %>% 
    filter(Hospital.Referral.Region.Description == region) %>% 
    select(Provider.City)
  return(cities.in.region$Provider.City)
}

# build a funciton that takes a city as an argument to locate and return all the corresponding
# Provider.Names.
Hospitals <- function(city) {
  hos.in.city <- DRG.location.payments %>% 
    ungroup() %>%
    select(Provider.City, Provider.Name) %>% 
    distinct(Provider.City, Provider.Name) %>% 
    filter(Provider.City == city) %>% 
    select(Provider.Name)
  return(hos.in.city$Provider.Name)
}

# build a funciton that takes a provider hospital name as an argument to locate and return 
# all the corresponding DRG.Definitions.
DRG <- function(hos) {
  drgs.in.zip <- DRG.location.payments %>% 
    ungroup() %>% 
    select(Provider.Name, DRG.Definition) %>% 
    distinct(Provider.Name, DRG.Definition) %>% 
    filter(Provider.Name == hos) %>% 
    select(DRG.Definition)
  return(drgs.in.zip$DRG.Definition)
}

# build a function that takes all arguments from the users' inputs and gives a data table
BuildTable <- function(state1, region1, city1, hos1, drg1, state2, region2, city2, hos2, drg2) {
  
  # use dplyr functions to filter down the the selected inputs from user and give a data frame
  # that contains Provider.Name, Average.Covered.Charges, Average.Total.Payments, 
  # Average.Medicare.Payments for the first option.
  table1 <- DRG.location.payments %>% 
    ungroup() %>% 
    filter(Provider.State == state1) %>% 
    filter(Hospital.Referral.Region.Description == region1) %>% 
    filter(Provider.City == city1) %>% 
    filter(Provider.Name == hos1) %>% 
    filter(DRG.Definition == drg1) %>% 
    select(Provider.Name, 
           Average.Covered.Charges, 
           Average.Total.Payments, 
           Average.Medicare.Payments)
  
  # use dplyr functions to filter down the the selected inputs from user and give a data frame
  # that contains Provider.Name, Average.Covered.Charges, Average.Total.Payments, 
  # Average.Medicare.Payments for the second option
  table2 <- DRG.location.payments %>% 
    ungroup() %>% 
    filter(Provider.State == state2) %>% 
    filter(Hospital.Referral.Region.Description == region2) %>% 
    filter(Provider.City == city2) %>% 
    filter(Provider.Name == hos2) %>% 
    filter(DRG.Definition == drg2) %>% 
    select(Provider.Name, 
           Average.Covered.Charges, 
           Average.Total.Payments, 
           Average.Medicare.Payments)
  
  # create four vectors that save the results of the data frames from two options
  Provider.Name <- c(table1$Provider.Name, table2$Provider.Name)
    Avg.Covered.Charges <- c(table1$Average.Covered.Charges, table2$Average.Covered.Charges)
    Avg.Total.Payments <- c(table1$Average.Total.Payments, table2$Average.Total.Payments)
    Avg.Medicare.Payments <- c(table1$Average.Medicare.Payments, table2$Average.Medicare.Payments)
  
    # combine four vectors and rename the columns of the table
  table <- data.frame(Provider.Name,
                      Avg.Covered.Charges, 
                      Avg.Total.Payments, 
                      Avg.Medicare.Payments) %>% 
    mutate("Hospital Name" = Provider.Name, "Avg Covered Charges" = Avg.Covered.Charges, "Avg Total Payments" = Avg.Total.Payments, "Avg Medicare Payments" = Avg.Medicare.Payments) %>% 
    select(-Provider.Name, -Avg.Covered.Charges, -Avg.Total.Payments, -Avg.Medicare.Payments)
  
  return(table)
}
