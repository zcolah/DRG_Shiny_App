# Library necessary packages
library(dplyr)
library(leaflet)

# This script will make a map that contains all the hospitals in the United States based on the input of DRG and the most someone is willing to pay
makeHospitalMap <- function(data, drg, payment){
  
  # Filter the data so we just get the hospitals we want
  data <- data %>% 
    filter(DRG.Definition == drg, as.numeric(gsub("\\$", "", Average.Total.Payments)) <= payment[[2]] &
             DRG.Definition == drg, as.numeric(gsub("\\$", "", Average.Total.Payments)) >= payment[[1]])
  
  # Set up the text that will show up when someone clicks on the marker on the map
  popup.text <- paste(data$Provider.Name, 
                      data$Provider.City, 
                      paste("Average Covered Charges:", data$Average.Covered.Charges), 
                      paste("Average Total Payments:", data$Average.Total.Payments), 
                      paste("Average Medicare Payments:", data$Average.Medicare.Payments), 
                      sep = "</br>"
                      )
  
  # This will return the map that has the markers for each hospital after it has been filtered
  return (leaflet() %>% 
            addTiles() %>% 
            setView(-96, 37, 4) %>% 
            addMarkers(data$longitude, data$latitude, popup = popup.text)
          )
}