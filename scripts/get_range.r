library(dplyr)

getRange <- function(data, drg){
  data <- data %>% 
    filter(DRG.Definition == drg) %>% 
    mutate(Average.Total.Payments = as.numeric(gsub("\\$", "", Average.Total.Payments))) %>% 
    filter(Average.Total.Payments == min(Average.Total.Payments) | Average.Total.Payments == max(Average.Total.Payments))
  return(data$Average.Total.Payments)
}