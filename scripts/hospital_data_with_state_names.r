#Importing the required libraries
library(devtools)
library (dplyr)
library (knitr)
library (plotly)
library(RColorBrewer)

#Reading in Hospital Data 
hospital.data <- read.csv("./data/hospital_data.csv",stringsAsFactors = FALSE)


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


write.csv(hospital.data, './data/hospital_data_with_state_name.csv')
