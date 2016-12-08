

library(shiny)

source("./scripts/Data Wrangling.R")

states <- DRG.location.payments %>% 
  ungroup() %>% 
  select(Provider.State) %>% 
  distinct(Provider.State)

# Define UI for application that draws a barplot
shinyUI(navbarPage('Comparative Bar Chart',
                   
                   tabPanel('Comparative Bar Chart',
                            
                            titlePanel("Comparative Bar Chart"),
                            
                            sidebarLayout(
                              
                              sidebarPanel(
                                
                                selectInput('var.a1',
                                            label = 'State A',
                                            choices = states$Provider.State),
                                
                                htmlOutput("selectUIregionA"),
                                
                                htmlOutput("selectUIcityA"),
                                
                                htmlOutput("selectUIzipA"),
                                
                                htmlOutput("selectUIdrgA"),
                                
                                selectInput('var.b1',
                                            label = 'State B',
                                            choices = states$Provider.State),
                                
                                htmlOutput("selectUIregionB"),
                                
                                htmlOutput("selectUIcityB"),
                                
                                htmlOutput("selectUIzipB"),
                                
                                htmlOutput("selectUIdrgB")),
                                
                    # Show a plot of the generated distribution
                    mainPanel(
                      plotlyOutput("distPlot")
                    ))
       )))