# Library necessary packages
library(dplyr)

# This function will get a range for the slider bar
getRange <- function(data, drg){
  data <- data %>% 
    filter(DRG.Definition == drg) %>% 
    filter(Average.Total.Payments == min(Average.Total.Payments) | Average.Total.Payments == max(Average.Total.Payments)) %>% 
    arrange(Average.Total.Payments)  # We have to arrange the values so that the min and max are in the correct indices
  return(data$Average.Total.Payments)
}