

library(plotly)
library(stringr)
library(dplyr)
### Build plot ###

# Build the "DrawBarplot" function that takes the dataframe and two groups of state, region, city,
# hospital, and drg as arguments(two search options) to filter down the corresponding charges. And 
# eventually, use plotly function to render a comparative bar chart.

DrawBarplot <- function(data, state1, region1, city1, hos1, drg1, state2, region2, city2, hos2, drg2) {
  
  # set names for different categories on the horizontal axis.
  category <- c("Avg Covered Charges", "Avg Total Payments", "Avg Medicare Payments")
  
  # filter down filter down the column for the first option.
  search1 <- data %>% 
    filter(Provider.State == state1) %>% 
    filter(Hospital.Referral.Region.Description == region1) %>% 
    filter(Provider.City == city1) %>% 
    filter(Provider.Name == hos1) %>% 
    filter(DRG.Definition == drg1)

  # find the corresponding Average.Covered.Charges, Average.Total.Payments, 
  # and Average.Medicare.Payments of first option.
  cost1 <- c(search1$Average.Covered.Charges,
            search1$Average.Total.Payments,
            search1$Average.Medicare.Payments)

  # filter down filter down the column for the first option.
  search2 <- data %>% 
    filter(Provider.State == state2) %>% 
    filter(Hospital.Referral.Region.Description == region2) %>% 
    filter(Provider.City == city2) %>% 
    filter(Provider.Name == hos2) %>% 
    filter(DRG.Definition == drg2)
  
  # find the corresponding Average.Covered.Charges, Average.Total.Payments, 
  # and Average.Medicare.Payments of second option.
  cost2 <- c(search2$Average.Covered.Charges,
            search2$Average.Total.Payments,
            search2$Average.Medicare.Payments)
  
  # Add a title to the plot
  title <- paste("Comparison of", hos1, "</br>and", hos2)
  
  # render the plot with plotly. 
  p <- plot_ly(data, x = ~category,
               y = ~cost1,
               type = 'bar', name = ~hos1) %>% 
    add_trace(y = ~cost2, name = ~hos2) %>% 
    layout(title = title, yaxis = list(title = 'Cost($)'), barmode = 'group', height = 800, margin = list(t = 100, b = 100))
  return(p)
}
