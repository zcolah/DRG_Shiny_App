library(shiny)
library(dplyr)

source("./Data Wrangling.R")

state.names <- DRG.location.payments %>%
  group_by(Provider.State) %>%
  summarise()

city.names <- DRG.location.payments %>% 
  group_by(Provider.City) %>% 
  summarise()

zip.names <- DRG.location.payments %>% 
  group_by(Provider.Zip.Code) %>% 
  summarise()

hosipital.names <- DRG.location.payments %>% 
  group_by(Hospital.Referral.Region.Description) %>% 
  summarise()

DRG.names <- DRG.location.payments %>% 
  group_by(DRG.Definition) %>% 
  summarise()


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
                                            choices = state.names$Provider.State, selected = 'AK'),
                                            
                                            selectInput('var.a2',
                                                        label = 'City A',
                                                        choices = city.names$Provider.City, selected = 'ANCHORAGE'),
                                            
                                            selectInput('var.a3',
                                                        label = 'Zip Code A',
                                                        choices = zip.names$Provider.Zip.Code, selected = '99508'),
                                            
                                            selectInput('var.a4',
                                                        label = 'Hospital Referral Region Description A',
                                                        choices = hosipital.names$Hospital.Referral.Region.Description, selected = 'AK - Anchorage'),
                                            
                                            selectInput('var.a5',
                                                        label = 'DRG Definition A',
                                                        choices = DRG.names$DRG.Definition, selected = '066 - INTRACRANIAL HEMORRHAGE OR CEREBRAL INFARCTION W/O CC/MCC'),
                                            
                                            selectInput('var.b1',
                                                        label = 'State B',
                                                        choices = state.names$Provider.State, selected = 'MD'),

                                            selectInput('var.b2',
                                                        label = 'City B',
                                                        choices = city.names$Provider.City, selected = 'ANNAPOLIS'),

                                            selectInput('var.b3',
                                                        label = 'Zip Code B',
                                                        choices = zip.names$Provider.Zip.Code, selected = '21401'),

                                            selectInput('var.b4',
                                                        label = 'Hospital Referral Region Description B',
                                                        choices = hosipital.names$Hospital.Referral.Region.Description, selected = 'DC - Washington'),

                                            selectInput('var.b5',
                                                        label = 'DRG Definition B',
                                                        choices = DRG.names$DRG.Definition, selected = '303 - ATHEROSCLEROSIS W/O MCC')),
                                # Show a plot of the generated distribution
                                mainPanel(
                                  plotlyOutput("distPlot")
                                ))
                   )))