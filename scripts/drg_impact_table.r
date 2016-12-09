#Importing the required libraries
library(devtools)
library (dplyr)
library (knitr)
library (plotly)
library (RColorBrewer)

#This function has been created to return a dataframe containing information for each state for a particular discharge which will be used to create a table
#The function is created to be resusable in the future
#such that a DRG Dataset for any year can be added to our dataset and accordingly the population dataset for that year can be passed as an argument
#Our current project though only discusses these datasets for the year 2011

DRG_Impact_Table <- function (drg.name, drg.data, population.estimate) {
  
  
  #Creating a dataframe of total number of discharges for each state for a particular DRG
  #and add columns to show the impact of the DRG on the people of the state
  
  discharges.for.each.state.with.population <-  filter (drg.data, DRG.Definition == drg.name) %>%  
                                                        select (DRG.Definition,Provider.State,Provider.State.Name,Total.Discharges)  %>%
                                                        group_by(Provider.State,Provider.State.Name,DRG.Definition) %>% 
                                                        summarise(Total.Discharges.For.State = sum (Total.Discharges)) %>% 
                                                        rename (state.name = Provider.State.Name) %>% 
                                                        left_join(population.estimate, by = "state.name") %>% 
                                                        mutate (impact.percentage.on.state = round(((Total.Discharges.For.State / population.estimate.2011)*100),2), 
                                                                impact.on.hundred.thousand =  (Total.Discharges.For.State / population.estimate.2011)*100000)
                                                        select (-Provider.State, -X) %>% 
                                                        rename (State = state.name , "DRG Definition" = DRG.Definition, "Total Discharges" = Total.Discharges.For.State ,
                                                                "Population Estimate (2011)" = population.estimate.2011, "Percentage of Population discharged" = impact.percentage.on.state, "Number of Discharges in Every 100,000 people" =impact.on.hundred.thousand )
  
  #Return dataframee for discharges for each with population           
  return (discharges.for.each.state.with.population)
  
}

hospital.data <- hospital.data <- read.csv("./data/hospital_data_with_state_name.csv",stringsAsFactors = FALSE)
population.data <- read.csv("./data/population_estimate_for_2011.csv",stringsAsFactors = FALSE)
DRG_Impact_Table ("039 - EXTRACRANIAL PROCEDURES W/O CC/MCC",hospital.data,population.data)
