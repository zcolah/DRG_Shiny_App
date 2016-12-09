#Importing the required libraries
library(devtools)
library (dplyr)
library (knitr)
library (plotly)
library (RColorBrewer)

#This function has been created to return a dataframe containing information for each state for a particular discharge
#The function is created to be resusable in the future
#such that a DRG Dataset for any year can be added to our dataset and accordingly the population dataset for that year can be passed as an argument
#Our current project though only discusses these datasets for the year 2011

DRG_Impact <- function (drg.name, column.to.display, drg.data, population.estimate) {
  
            
            #Creating a dataframe of total number of discharges for each state for a particular DRG
            #and add columns to show the impact of the DRG on the people of the state
            
            discharges.for.each.state.with.population <-  filter (drg.data, DRG.Definition == drg.name) %>%  
                                                          select (DRG.Definition,Provider.State,Provider.State.Name,Total.Discharges)  %>%
                                                          group_by(Provider.State,Provider.State.Name,DRG.Definition) %>% 
                                                          summarise(Total.Discharges.For.State = sum (Total.Discharges)) %>% 
                                                          ungroup () %>% 
                                                          rename ( state.name = Provider.State.Name ) %>% 
                                                          left_join(population.estimate, by = "state.name") %>% 
                                                          mutate (impact.percentage.on.state = round(((Total.Discharges.For.State / population.estimate.2011)*100),2), 
                                                                  impact.on.hundred.thousand =  (Total.Discharges.For.State / population.estimate.2011)*100000) 
            
          #Return dataframee for discharges for each with population           
          return (discharges.for.each.state.with.population)

}