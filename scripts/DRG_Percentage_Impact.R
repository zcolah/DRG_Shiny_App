library(devtools)
library (dplyr)
library (knitr)
library (plotly)

#Reading in Hospital Data 
hospital.data <- read.csv("./data/hospital_data.csv",stringsAsFactors = FALSE)

View (hospital.data)
#Reading in Population Data

population.data <- read.csv("./data/population_estimate_2011/PEP_2015_PEPANNRES_with_ann.csv",stringsAsFactors = FALSE)

# state.abb[grep(df$Provider.State, state.name)] did not work hence had to use this code I sourced from online 
# Code Sourced from :
#https://favorableoutcomes.wordpress.com/2012/10/19/create-an-r-function-to-convert-state-codes-to-full-state-name/

#'x' is the column of a data.frame that holds 2 digit state codes

stateFromLower <-function(x) {
  #read 52 state codes into local variable [includes DC (Washington D.C. and PR (Puerto Rico)]
  st.codes<-data.frame(
    state=as.factor(c("AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA",
                      "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME",
                      "MI", "MN", "MO", "MS",  "MT", "NC", "ND", "NE", "NH", "NJ", "NM",
                      "NV", "NY", "OH", "OK", "OR", "PA", "PR", "RI", "SC", "SD", "TN",
                      "TX", "UT", "VA", "VT", "WA", "WI", "WV", "WY")),
    full=as.factor(c("Alaska","Alabama","Arkansas","Arizona","California","Colorado",
                     "Connecticut","District of Columbia","Delaware","Florida","Georgia",
                     "Hawaii","Iowa","Idaho","Illinois","Indiana","Kansas","Kentucky",
                     "Louisiana","Massachusetts","Maryland","Maine","Michigan","Minnesota",
                     "Missouri","Mississippi","Montana","North Carolina","North Dakota",
                     "Nebraska","New Hampshire","New Jersey","New Mexico","Nevada",
                     "New York","Ohio","Oklahoma","Oregon","Pennsylvania","Puerto Rico",
                     "Rhode Island","South Carolina","South Dakota","Tennessee","Texas",
                     "Utah","Virginia","Vermont","Washington","Wisconsin",
                     "West Virginia","Wyoming"))
  )
  #create an nx1 data.frame of state codes from source column
  st.x<-data.frame(state=x)
  #match source codes with codes from 'st.codes' local variable and use to return the full state name
  refac.x<-st.codes$full[match(st.x$state,st.codes$state)]
  #return the full state names in the same order in which they appeared in the original source
  return(refac.x)
  
}

#Change the state abbreviations in hospital data to full state names

hospital.data <- data.frame (hospital.data, stringsAsFactors = FALSE)

#Creates a new column which contains the state names for each state ID
hospital.data$Provider.State.Name<-stateFromLower(hospital.data$Provider.State)


#Making a list of regions to not include in my dataframe
regions<- c ( "Midwest Region", "Northeast Region",  "South Region" , "West Region" , "United States", "Puerto Rico", "Geography")

#Get the population data only for states (this procedure helps remove Puerto Rico from our Data Set 
#and the population values for the different regions of United States )
estimate.states.population.2011 <- select (population.data,GEO.display.label,respop72011)   %>% 
                                   filter (!(GEO.display.label %in%  regions)) %>% 
                                   rename ( state.name = GEO.display.label, population.estimate.2011 = respop72011)

#Converts state populations estimates from string into numeric 
estimate.states.population.2011$population.estimate.2011 <- as.numeric(as.character(estimate.states.population.2011$population.estimate.2011))

#Function to create a Choropleth map of the imapact of a DRG on a particular state
createChlorPlethPopulationMap <- function (drg.name) {
  
            #Creating a dataframe of total number of discharges for each state for a particular DRG
            #and add columns to show the impact of the DRG on the people of the state
            
            discharges.for.each.state.with.population <-  filter (hospital.data, DRG.Definition == drg.name) %>%  
                                                          select (DRG.Definition,Provider.State,Provider.State.Name,Total.Discharges)  %>%
                                                          ungroup () %>% 
                                                          group_by(Provider.State,Provider.State.Name,DRG.Definition) %>% 
                                                          summarise(Total.Discharges.For.State = sum (Total.Discharges)) %>% 
                                                          rename ( state.name = Provider.State.Name ) %>% 
                                                          left_join(estimate.states.population.2011, by = "state.name") %>% 
                                                          mutate (impact.percentage.on.state = (Total.Discharges.For.State / population.estimate.2011)*100, 
                                                                  impact.on.hundred.thousand =  (Total.Discharges.For.State / population.estimate.2011)*100000) 
            
            #Creating a Choropleth Map
            
            #Hover Information 
            discharges.for.each.state.with.population$hover <- with(discharges.for.each.state.with.population,paste(state.name,'<br>',"Total Discharges:",Total.Discharges.For.State,'<br>',
                                                                          "Percentage of Population Impacted:", impact.percentage.on.state, "%",'<br>',
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
            
            p <- plot_geo(discharges.for.each.state.with.population, locationmode = 'USA-states') %>%
              add_trace(
                z = ~Total.Discharges.For.State, text = ~hover, locations = ~Provider.State,
                color = ~Total.Discharges.For.State, colors = 'Purples'
              ) %>%
              colorbar(title = "Impact Percentage") %>%
              layout(
                title = 'Impact Percentage of a DRG on a State<br>(Hover for breakdown)',
                geo = map.projections
              )
            
                            
            return(p)
}

createChlorPlethPopulationMap ("948 - SIGNS & SYMPTOMS W/O MCC")

