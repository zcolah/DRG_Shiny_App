# Library necessary packages
library(leaflet)
library(maps)

# This was just how I did my data manipulation to get state information. I am creating
# multiple dataframes so I don't have to do a ton of data manipulation every time the
# data is loaded and I only keep the columns I need

#library(dplyr)
#hospital.data <- read.csv("data/hospital_data.csv", stringsAsFactors = F)
#hospital.data.state <- hospital.data %>%
#  mutate(Average.Total.Payments = as.numeric(gsub("\\$", "", Average.Total.Payments))) %>% 
#  mutate(Average.Covered.Charges = as.numeric(gsub("\\$", "", Average.Covered.Charges))) %>% 
#  mutate(Average.Medicare.Payments = as.numeric(gsub("\\$", "", Average.Medicare.Payments))) %>% 
#  select(Provider.State, Average.Covered.Charges, Average.Total.Payments, Average.Medicare.Payments) %>% 
#  group_by(Provider.State) %>% 
#  summarize(State.Covered.Charges.Percent = mean(100 * Average.Covered.Charges / (Average.Covered.Charges + Average.Total.Payments)),
#            State.Medicare.Coverage.Percent = mean(100 * Average.Medicare.Payments / Average.Total.Payments))

# Read in the data for the leaflet map
hospital.data.for.leaflet <- read.csv("data/hospital_data_for_leaflet.csv")

# Read in the data for the choropleth map
hospital.data.state <- read.csv("data/hospital_data_state.csv")

# Read in the three scripts that I will be using
source("scripts/leaflet_map.r")
source("scripts/choropleth.r")
source("scripts/get_range.r")

shinyServer(function(input, output) {
  
  # This will get the range that the slider bar has
  dollar.range <- reactive({getRange(hospital.data.for.leaflet, input$selected.drg)})
  
  # This will render the slider bar on the ui
  output$numeric.range <- renderUI({ 
    sliderInput("payment",
                "Range of Average Total Charges ($)",
                value = dollar.range(),
                min = dollar.range()[[1]],
                max = dollar.range()[[2]])
  })
  
  # This is the leaflet map
  output$map <- renderLeaflet(
    makeHospitalMap(hospital.data.for.leaflet, input$selected.drg, input$payment)
  )
  
  # This is the choropleth map
  output$coverage.choropleth <- renderPlotly(
    makeStateChoropleth(hospital.data.state, input$coverage)
  )
})