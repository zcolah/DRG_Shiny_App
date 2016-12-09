library(dplyr)

getRange <- function(data, drg){
  data <- data %>% 
    filter(DRG.Definition == drg) %>% 
    filter(Average.Total.Payments == min(Average.Total.Payments) | Average.Total.Payments == max(Average.Total.Payments)) %>% 
    arrange(Average.Total.Payments)
  return(data$Average.Total.Payments)
}