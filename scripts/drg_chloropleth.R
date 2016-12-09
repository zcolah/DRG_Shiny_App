#Importing the required libraries
library(devtools)
library (dplyr)
library (knitr)
library (plotly)
library (RColorBrewer)

#Function to create a Choropleth map of the imapact of a DRG on a particular state
#The function is created to be resusable in the future 
#such that a DRG Dataset for any year can be added to our dataset and accordingly the population dataset for that year can be added
#Our current project though only discusses these datasets for the year 2011

DRG_Impact_Choropleth_Map <- function (drg.name, column.to.display, drg.data, population.estimate) {
  
  source("scripts/drg_impact.r")
  
  #Creating a dataframe of total number of discharges for each state for a particular DRG
  #and adding columns to show the impact of the DRG on the people of the state using a function from a script imported
  
  discharges.for.each.state.with.population <- DRG_Impact (drg.name, column.to.display, drg.data, population.estimate)

  #Hover Information 
  discharges.for.each.state.with.population$hover <- with(discharges.for.each.state.with.population,paste(state.name,'<br>',
                                                                                                          "Total Discharges:",Total.Discharges.For.State,'<br>',
                                                                                                          "Estimated Percentage of Population Impacted:", impact.percentage.on.state, "%",'<br>',
                                                                                                          "Approximate Population of State for 2011:", population.estimate.2011, '<br>',
                                                                                                          "Total Discharges per Hundred Thousand:",impact.on.hundred.thousand))
  
  #Give state boundries a white color border
  border.color <- list(color = toRGB("white"), width = 2)
  
  #Specify some map projection/options
  map.projections <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = TRUE,
    lakecolor = toRGB('white')
  )
  
  
  #If Else to decide what the map title and color legend title should be (decided by user input)
  
  if (column.to.display == "population.estimate.2011") {
    
    map.title <- "Estimated Population for 2011"  
    color.legend.title <- "Estimated Population"
  }
  
  else if  (column.to.display == "impact.on.hundred.thousand") {
    
    map.title <- "Discharges per 100,000 people"
    color.legend.title <- "Discharges per 100,000 people"
    
  }
  
  else if  (column.to.display == "impact.percentage.on.state") {
    
    map.title <- "Percentage of Discharges in State Population"
    color.legend.title <- "Discharge Percentage"
    
  }
  
  else if  (column.to.display == "Total.Discharges.For.State") {
    
    map.title <- "Total Discharges for Each State"
    color.legend.title <- "Total Discharges"
    
  }
  
  #Pasting HTML Into Title
  map.title.y <- paste0 ('<b style="color:CF000F">', map.title,"</b><br>", "Hover to learn more")
  
  #Choropleth Map
  
  choropleth.map <- plot_geo(discharges.for.each.state.with.population, locationmode = 'USA-states') %>%
    add_trace(z = ~eval(parse(text = column.to.display)), text = ~hover, hoverinfo ="text", locations = ~Provider.State,
              color = ~eval(parse(text = column.to.display)), colors = 'Reds') %>%
    colorbar(title = color.legend.title) %>%
    layout(title = map.title.y,
           geo = map.projections , hovermode="closest") 
  
  #Return a Choropleth Map
  return (choropleth.map)
  
}