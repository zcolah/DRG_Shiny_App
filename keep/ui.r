

library(shiny)

source("./Data Wrangling.R")
# source("./scripts/Reactive Functions.R")


# Define UI for application that draws a histogram
shinyUI(navbarPage('Comparative Bar Chart',
                   
                   tabPanel('Comparative Bar Chart',
                            # Application title
                            titlePanel("Comparative Bar Chart"),
                            
                            # Sidebar with a slider input for number of bins 
                            sidebarLayout(
                              
                              sidebarPanel(
                                
                                selectInput('var.a1',
                                            label = 'State A',
                                            choices = state.names$Provider.State),
                                
                                selectInput('var.a2',
                                            label = 'City A',
                                            choices = r.city1),
                                
                                selectInput('var.a3',
                                            label = 'Zip Code A',
                                            choices = r.zip1),
                                
                                selectInput('var.a4',
                                            label = 'Hospital Referral Region Description A',
                                            choices = r.hos1),
                                
                                selectInput('var.a5',
                                            label = 'DRG Definition A',
                                            choices = r.drg1),
                                
                                selectInput('var.b1',
                                            label = 'State B',
                                            choices = state.names$Provider.State),
                                
                                selectInput('var.b2',
                                            label = 'City B',
                                            choices = r.city2),
                                
                                selectInput('var.b3',
                                            label = 'Zip Code B',
                                            choices = r.zip2),
                                
                                selectInput('var.b4',
                                            label = 'Hospital Referral Region Description B',
                                            choices = r.hos2),
                                
                                selectInput('var.b5',
                                            label = 'DRG Definition B',
                                            choices = r.drg2)),
                              # Show a plot of the generated distribution
                              mainPanel(
                                plotlyOutput("distPlot")
                              ))
                   )))