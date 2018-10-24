#Importing the required libraries
library(devtools)
library (dplyr)
library (knitr)
library (plotly)
library(RColorBrewer)

#Reading in Population Data

population.data <- read.csv("./data/population_estimate_2011/PEP_2015_PEPANNRES_with_ann.csv",stringsAsFactors = FALSE)

#Get the population data only for states (this procedure helps remove Puerto Rico from our Data Set 
#and the population values for the different regions of United States )
estimate.states.population.2011 <-select (population.data,GEO.display.label,respop72011)   %>% 
                                  filter (!(GEO.display.label %in%  regions)) %>% 
                                  rename ( state.name = GEO.display.label, population.estimate.2011 = respop72011)

#Converts state populations estimates from string into numeric 
estimate.states.population.2011$population.estimate.2011 <- as.numeric(as.character(estimate.states.population.2011$population.estimate.2011))

write.csv(estimate.states.population.2011, './data/population_estimate_for_2011.csv')
