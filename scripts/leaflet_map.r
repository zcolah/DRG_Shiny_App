library(dplyr)
library(leaflet)

makeHospitalMap <- function(data, drg, max.payment){
  data <- data %>% 
    filter(DRG.Definition == drg, as.numeric(gsub("\\$", "", Average.Total.Payments)) < max.payment)
  popup.text <- paste(data$Provider.Name, 
                      data$Provider.City, 
                      paste("Average Covered Charges:", data$Average.Covered.Charges), 
                      paste("Average Total Payments:", data$Average.Total.Payments), 
                      paste("Average Medicare Payments:", data$Average.Medicare.Payments), 
                      sep = "</br>"
                      )
  return (leaflet() %>% 
            addTiles() %>% 
            setView(-96, 37, 4) %>% 
            addMarkers(data$longitude, data$latitude, popup = popup.text)
          )
}