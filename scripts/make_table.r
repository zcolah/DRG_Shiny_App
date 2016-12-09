library(dplyr)

makeTable <- function(data, drg, payment){
  
  # Filter the data so we just get the hospitals we want
  data <- data %>% 
    filter(DRG.Definition == drg, Average.Total.Payments <= payment[[2]] &
             DRG.Definition == drg, Average.Total.Payments >= payment[[1]]) %>% 
    select(Provider.City, Provider.Name, Average.Covered.Charges, Average.Total.Payments, Average.Medicare.Payments) %>% 
    mutate(City = Provider.City, Hospital = Provider.Name, "Average Covered Charges" = Average.Covered.Charges, "Average Total Payments" = paste0("$", Average.Total.Payments), "Average Medicare Payments" = Average.Medicare.Payments) %>% 
    select(-Provider.City, -Provider.Name, -Average.Covered.Charges, -Average.Total.Payments, -Average.Medicare.Payments)
  
  return(data)
}