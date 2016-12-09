#Loading Libraries
library (devtools)
library(plotly)
library(stringr)
library(dplyr)
library(shiny)
library(markdown)
library(leaflet)
library (RColorBrewer)
library(shinythemes)

# Get the data for the DRG payments
DRG.location.payments <- read.csv("data/DRG_location_payments.csv", stringsAsFactors = F)

# use dplyr functions to find all 51 states' names.
states <- DRG.location.payments %>% 
          ungroup() %>% 
          select(Provider.State) %>% 
          distinct(Provider.State)


# Read in the drg names
hospital.data.drg <- read.csv("data/hospital_data_drg.csv", stringsAsFactors = F)


#Sourcing for Select a county and get information about the hospitals in that city for a particular DRG
source('./scripts/search_hospitals_by_region.R')
source ('./scripts/support_functions_search_hospital_by_region.R')

#Sourcing for finding gap between medicare and payment for DRG
source('./scripts/find_gap_between_total_payments_and_medicare.R')
source('./scripts/support_functions_finding_gap_between_total_payments_and_medicare.R')

#
navbarPage(inverse = F,
            
            fluid = T,
            
            theme = shinytheme("superhero"),"2011 DRG Analysis", 
           
           
           #About Us Panel
           tabPanel("About Us" , 
                    h1 ("Top 100 DRG Analysis for Year 2011 by Team Lays", style = "color: #bfefff; text-align: center;padding: 20px;"),
                    
                    h2 ("About Our Dataset"),
                    
                    p ("Our project works with the “Inpatient Prospective Payment System (IPPS) Provider Summary for the Top 100 Diagnosis-Related Groups (DRG) - FY2011” data set of information created and maintained by the US Government. 
                       A Diagnosis Related Group is a statistical system of classifying any inpatient stay into groups for the purpose of payments. The DRG classification system divides possible diagnoses into more than 20 major body systems and subdivides them into almost 500 groups for the purpose of Medicare reimbursement.  
                       The data set we used in our investigation is a collection containing a summary for each of the top 100 DRGs for over 3000 hospitals in the United States of America that receive Medicare Inpatient Prospective Payment System Payment paid under Medicare based on a rate per discharge using the Medicare Severity Diagnosis Related Group (MS-DRG) for Fiscal Year (FY) 2011. These DRGs represent more than 7 million discharges or 60 percent of total Medicare IPPS discharges. These summaries contain information about the total discharges, the average covered charges, the average total payments and the average Medicare payments made by the patients who have been discharged.
                       The values that we focused on were the total discharges (which describes how many people were released from the hospital), average covered charges (which describes how much insurance will pay for the treatment), average total payments (which describes how much the patient pays for treatment), and average Medicare payments (which describes how much Medicare will pay for the treatment)."),
                    
                    h2 ("Our Investigation"),
                    p ("As part of our investigation of this data we compare the average total payments and average Medicare payments for each DRG of each state and city and for each hospital to try to identify the areas where it is more costly to receive medical treatment. We also investigated the total discharges for a particular DRG and compare the total discharges for each DRG of each state so as to identify accordingly if a particular state suffers more than the other."),
                    p("Through this investigation of ours we want to help:"),
                    p(" - Those seeking medical treatment and are facing problems in financing heavy medical bills"),
                    p(" - Soon to be retiring elderly people because as they turn old they will need more and more medical procedures as medical issues increase with age, hence they will want to find an area which best suits their current financial status so as to ensure their medical issues do not harass them in the future. "),
                    p(" - The government as they will want to see the hospitals that have the lowest Medicare coverage"),
                    p(" - People who are looking to ensure they receive good health insurance. Through our investigation they will be able to identify which areas receive better average Medicare or Insurance payments than others. "),
                    h2("Technical Stuff"),
                    h3("About Our Analysis"),
                    p("We used a Shiny App to document our investigation and analysis of the data. Largely through the use of `plotly`, `dplyr`, and `leaflet` we were able to produce the outputs we wanted. In order to avoid too much data manipulation every time the app is loaded, we created and wrote many datasets and stored them so that we just have to read them in. A challenge that we faced was getting the latitude and longitude for each hospital. This was solved though the use of the `zipcode` package and using `left_join` to join the data with the zipcodes, latitude, and longitude to the data with the hospital information. A similar procedure was done for matching the population estimate for the year 2011 to each state."),
                    h3("Links to the data sets we used:"),
                    a(href = "https://data.cms.gov/Medicare/Inpatient-Prospective-Payment-System-IPPS-Provider/97k6-zzx3", "Inpatient Prospective Payment System (IPPS) Provider Summary for the Top 100 Diagnosis Related Groups"),
                    br(),
                    a(href = "http://factfinder.census.gov/faces/tableservices/jsf/pages/productview.xhtml?src=bkmk", "USA Population Estimate"),
                    h2("Team Members"), 
                    p(" - Justin Tinghao Wang"),
                    p(" - Yuxi Wu"),
                    p(" - Steven Conner Bishop"),
                    p(" - Zoshua Colah")
                    ),
           
           #Tab : Comparitive Analysis of Hospitals
           tabPanel('Compare Hospitals',
                    h1("Compare Hospitals", style = "color: #bfefff; text-align: center;padding: 20px;"), 
                    p ("Due to the large dataset and approximately 5 minute loading time this feature has been deployed separately on a",a(href ="https://jusintime.shinyapps.io/2011_us_inpatient_prospective_payment_comparative_bar_chart/", "different website"),style = "color: #bfefff; text-align: center;padding: 20px;")
                    
           ),

           #Tab : Find a Hospital in Your Budget 
           tabPanel("Search Hospitals in Budget", h1("Find a Hospital for your DRG", style = "color: #bfefff; text-align: center;padding: 20px;"), hr(),
                    
                    # Create a sidebar with widgets that will modify the map
                    sidebarLayout(
                      sidebarPanel(
                        helpText("Find a Hospital in your Budget for your DRG"),
                        hr(),
                        # Select input for the DRGs
                        selectInput("selected.drg.for.leaflet",
                                    "Select DRG",
                                    hospital.data.drg$DRG.Definition,
                                    selected = "039 - EXTRACRANIAL PROCEDURES W/O CC/MCC"),
                        
                      # This puts the slider bar that will adjust based on the selected drg
                      htmlOutput("numeric.range")),
                      
                      # The main panel will display the map
                      mainPanel(p("Hospitals in America within your budget | Hover Over for more Financial Information"),br(),helpText ("Scroll Down to See Data Table Results"),hr(),
                                # Show a map of where the hospitals are that fit the DRG and the maximum payment
                                leafletOutput("budget_map"),
                                
                                # Show a table of the data about the hospitals
                                dataTableOutput("hospital_locations_table")))),

           #Tab: Find a Hospital Near You 
           tabPanel("Find Nearby Hospitals", h1("Find a Hospital Near You", style = "color: #bfefff; text-align: center;padding: 20px;"),  
                    p("If you do not want to travel in order to get medical services for your DRG you can search here to find hospitals which are in proximity to your location and which cater to your DRG",style = "color: #bfefff; text-align: center;padding: 20px;"),helpText ("Scroll Down to See Data Table Results", style = "text-align:center"),hr(),
                    
                    sidebarLayout(
                      sidebarPanel(
                        
                        #select a Region
                        selectInput('region.select', label = 'Region',
                                    choices = regions$Hospital.Referral.Region.Description),
                        #select a DRG
                        selectInput('drg.select', label  = 'DRG : DRG: Diagnosis-Related Group',
                                    choices = drgs$DRG.Definition)), 
                      mainPanel(
                        plotlyOutput('bar.chart.city.info') , dataTableOutput('data.table.find.a.hospital.near.you')
                      )
                    )),
           
           
           
           #Tab: Insurance/Medicare Coverage 
           tabPanel('Insurance/Medicare Coverage',h1("Find a state with the Insurance/Medicare coverage you need", style = "color: #bfefff; text-align: center;padding: 20px;"),
                    # Create a sidebar with widgets that will modify the map
                    sidebarLayout(
                      sidebarPanel(helpText(" Choose whether you require Medicare or Insurance coverage and the adjoining map will display the percent of the total charges that will be covered by that particular coverage plan in each state"), hr (),
                                   # These buttons will adjust the choropleth map
                                   radioButtons("coverage",
                                                "Coverage Options",
                                                choices = list(Medicare = "State.Medicare.Coverage.Percent", Insurance = "State.Covered.Charges.Percent"),
                                                selected = "State.Medicare.Coverage.Percent")
                      ),
                      mainPanel( p ("Hovering over the State provides the user with the exact percent of the coverage for that state. Darker colors represent better coverage."),
                                 # Show a map of each state and the average ratio between average covered charges and average total payment
                                 plotlyOutput("coverage.choropleth")
                      )
                    )
           ),
           
           #Tab: Discharge Statistics 
           tabPanel("Discharge Statistics", h1("Statistics for Discharge Rates per State", style = "color: #bfefff; text-align: center;padding: 20px;"), p("The Chloropleth Map generated below displays the discharge 
                                                 information for a DRG selected. Through this graph we can find out states in which a DRG is more common and more frequently occuring in the state population. By finding 
                                                 these statistics out the government will be able to better alocate resources, services and funds for each DRG to each State.", style = "color: #bfefff; text-align: center;padding: 20px;"),
                                            p("Please Scroll Down to See Discharge Data Table", style = "color: #bfefff; text-align: center;padding: 20px;"),hr(),
                    
                    fluidRow(
                      # Create a sidebar with widgets that will modify the map
                      column(4,
                             wellPanel(
                               helpText ("This side bar panel manipulates the data visualized in the adjacent Choloropleth Map"),
                               hr (),
                               # Select input for the DRGs
                               selectInput("drg_option_for_impact",
                                           "Select a DRG",
                                           hospital.data.drg$DRG.Definition,
                                           selected = "039 - EXTRACRANIAL PROCEDURES W/O CC/MCC"),
                               
                               # Select input for discharge visualization options
                               selectInput("discharge_visualization_option",
                                           "Discharge data set to visualize",
                                           choices = list("Total Discharges" = "Total.Discharges.For.State", "Approximate Percentage of Discharges for Population" = "impact.percentage.on.state", "Approximate State Population for 2011" = "population.estimate.2011", "Total Cases for every 100,000 people" = "impact.on.hundred.thousand"),
                                           selected = "Total Discharges"), hr (),
                               helpText ("Population Estimate sourced from"), a(href="http://factfinder.census.gov/faces/tableservices/jsf/pages/productview.xhtml?src=bkmk", "American Census on American Fact Finder")
                             )       
                      ),
                      
                      column(8,p ("Hover over each state for a breakdown of the relation of the discharge rate with the population of the state"),
                             # Show a map of each state and the average ratio between average covered charges and average total payment
                             plotlyOutput("choropleth_drg_impact_percentage")
                      )
                    ), hr (),
                    
                    fluidRow(
                      column (12,  #Create discharge data table for drg selected
                              dataTableOutput("discharge_table") )
                    )),
           
           
           #Tab: Show Medicare Gap for each DRG
           tabPanel('Medicare Gap',
                    h1("Medicare Gap", style = "color: #bfefff; text-align: center;padding: 20px;"), 
                    p ("This scatter plot has been created for government, to identify which hospitals need more assistance and show the payment gap between Total Payment and Medicare, The larger the gap, the larger and more yellow the dot.",style = "color: #bfefff; text-align: center;padding: 20px;"),
                    hr(),
                    sidebarLayout(
                      sidebarPanel(      helpText ("Select a DRG to Manipulate the adjacent Scatter Plot Visualization"),
                                         selectInput('drg.select', label  = 'DRG: Diagnosis-Related Group',
                                                     choices = drgs$DRG.Definition)),
                      mainPanel(
                        plotlyOutput('drg.payment.medicare')
                      )
                    ))
)
                             
