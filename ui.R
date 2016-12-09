# library necessary packages
library(dplyr)
library(shiny)
library(shinythemes)
library(plotly)

# Get the data for the DRG payments
DRG.location.payments <- read.csv("data/DRG_location_payments.csv")

# use dplyr functions to find all 51 states' names.
states <- DRG.location.payments %>% 
  ungroup() %>% 
  select(Provider.State) %>% 
  distinct(Provider.State)

# Define UI for application that draws a comparative bar chart
shinyUI(navbarPage(inverse = F,
                   
                   fluid = T,
                  
                  theme = shinytheme("darkly"), 
                  
                  # name of navbarPage
                  '2011 US Inpatient Prospective Payment',
                   
                  # create a tabPanel
                   tabPanel('Comparative Bar Chart',
                            
                            # to render the title of the page
                            #h1("Comparative", span("Bar Chart", style = "font-weight: 100"),
                            #   style = "color: #bfefff; text-align: center;
                            #   padding: 20px;"),
                            
                            # to render the title of the sidebar panel
                            titlePanel("Make Your Choice"),
                            
                            sidebarLayout(position = c("left", "right"),
                              
                              sidebarPanel(
                                
                                helpText("Note:",
                                         "It takes time to show the bar chart each", 
                                         "time when you input a different option.",
                                         "Please do not close the page while you",
                                         "are waiting although you may see an error",
                                         "message on the panel."),
                                
                                hr(),
                                
                                selectInput('var.a1',
                                            label = 'Provider State A',
                                            choices = states$Provider.State),
                                
                                htmlOutput("selectUIregionA"),
                                
                                htmlOutput("selectUIcityA"),
                                
                                htmlOutput("selectUIhosA"),
                                
                                htmlOutput("selectUIdrgA"),
                              
                                hr(),
                                
                                selectInput('var.b1',
                                            label = 'Provider State B',
                                            choices = states$Provider.State),
                                
                                htmlOutput("selectUIregionB"),
                                
                                htmlOutput("selectUIcityB"),
                                
                                htmlOutput("selectUIhosB"),
                                
                                htmlOutput("selectUIdrgB")),
                                
                    # Show the comparative bar chart according to the user's input choice and render all the
                    # help text. 
                    mainPanel(
                      
                      p("For these DRGs, average charges, average total payments, and average Medicare 
                        payments are calculated at the individual hospital level. Users will be able 
                        to make comparisons between the amount charged by individual hospitals within
                        local markets, and nationwide, for services that might be furnished in connection
                        with a particular inpatient stay."),
                      
                      hr(),
                      
                      plotlyOutput("distPlot"),
                      
                      hr(),
                      
                      # render the information in a data table
                      tableOutput("hospital.locations.table"),
                      
                      hr(),
                      
                      p("Provider State: The state where the provider is located."),
                      
                      p("Provider HRR: The Hospital Referral Region (HRR) where the provider is located."),
                      
                      p("Provider City: The city where the provider is located."),
                      
                      p("Provider Hospital: The hospital where the provider is located."),
                      
                      p("DRG Definition: The code and description identifying the MS-DRG. MS-DRGs are a classification 
                        system that groups similar clinical conditions (diagnoses) and the procedures 
                        furnished by the hospital during the stay."),
                      
                      p("Average Covered Charges: The provider's average charge for services 
                        covered by Medicare for all discharges in the DRG. These will vary from 
                        hospital to hospital because of differences in hospital charge structures."),
                      
                      p("Average Total Payments: The average total payments to all providers for 
                        the MS-DRG including the MS- DRG amount, teaching, disproportionate share, 
                        capital, and outlier payments for all cases. Also included 
                        in average total payments are co-payment and deductible amounts that the 
                        patient is responsible for and any additional payments by third parties for 
                        coordination of benefits."),
                      
                      p("Average Medicare Payments: The average amount that Medicare pays to the 
                        provider for Medicare's share of the MS-DRG. Average Medicare payment 
                        amounts include the MS-DRG amount, teaching, disproportionate share, 
                        capital, and outlier payments for all cases. Medicare payments DO NOT 
                        include beneficiary co-payments and deductible amounts nor any additional 
                        payments from third parties for coordination of benefits.")
                    ))
       )))