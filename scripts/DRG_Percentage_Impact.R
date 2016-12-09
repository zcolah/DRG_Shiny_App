#Importing the required libraries
library(devtools)
library (dplyr)
library (knitr)
library (plotly)
library(RColorBrewer)

#Function to create a Choropleth map of the imapact of a DRG on a particular state
#The function is created to be resusable in the future 
#such that a DRG Dataset for any year can be added to our dataset and accordingly the population dataset for that year can be added
#Our current project though only discusses these datasets for the year 2011

drg_impact_choropleth_map <- function (drg.name, drg.data, population.estimate) {
  
            
            #Creating a dataframe of total number of discharges for each state for a particular DRG
            #and add columns to show the impact of the DRG on the people of the state
            
            discharges.for.each.state.with.population <-  filter (drg.data, DRG.Definition == drg.name) %>%  
                                                          select (DRG.Definition,Provider.State,Provider.State.Name,Total.Discharges)  %>%
                                                          ungroup () %>% 
                                                          group_by(Provider.State,Provider.State.Name,DRG.Definition) %>% 
                                                          summarise(Total.Discharges.For.State = sum (Total.Discharges)) %>% 
                                                          rename ( state.name = Provider.State.Name ) %>% 
                                                          left_join(population.estimate, by = "state.name") %>% 
                                                          mutate (impact.percentage.on.state = round(((Total.Discharges.For.State / population.estimate.2011)*100),2), 
                                                                  impact.on.hundred.thousand =  (Total.Discharges.For.State / population.estimate.2011)*100000) 
            
            #Creating a Choropleth Map (below) :
            
            #Hover Information 
            discharges.for.each.state.with.population$hover <- with(discharges.for.each.state.with.population,paste(state.name,'<br>',"Total Discharges:",Total.Discharges.For.State,'<br>',
                                                                          "Estimated Percentage of Population Impacted:", impact.percentage.on.state, "%",'<br>',
                                                                          "Approximate Population of State for 2011:", population.estimate.2011, '<br>',
                                                                          "Total Cases per Hundred Thousand:",impact.on.hundred.thousand))

            #Give state boundries a white color border
            border.color <- list(color = toRGB("white"), width = 2)
          
            #Specify some map projection/options
            map.projections <- list(
              scope = 'usa',
              projection = list(type = 'albers usa'),
              showlakes = TRUE,
              lakecolor = toRGB('white')
            )
            
            #Choropleth Map
            
            choropleth.map <- plot_geo(discharges.for.each.state.with.population, locationmode = 'USA-states') %>%
                              add_trace(
                                z = ~impact.percentage.on.state, text = ~hover, hoverinfo ="text", locations = ~Provider.State,
                                color = ~impact.percentage.on.state, colors = 'Reds'
                              ) %>%
                              colorbar(title = "Estimated <br> Impact <br>Percentage") %>%
                              layout(
                                title = '<b style="color:CF000F">Impact Percentage of a DRG on a State</b><br>Hover to learn more',
                                geo = map.projections , hovermode="closest"
                              )
            
            #Return a Choropleth Map
            
            return (choropleth.map)
}