#Make a scatter plot, x is the payment, y is medicare
#Loading libraries
library(plotly)
library(stringr)
library(dplyr)

#Sourcing Patient 
patient.data <- read.csv('./data/hospital_data.csv', stringsAsFactors = F)

#tab7.data will be used in this function. So that original data which is patient.data will not be changed
tab7.data <- patient.data

#we subsitude the $ sign by blank space in order to put the only number in the dataset
tab7.data$Average.Total.Payments <- lapply(tab7.data$Average.Total.Payments, 
                                           function(x)as.numeric(gsub("[,$]","",x)))


tab7.data$Average.Medicare.Payments <- lapply(tab7.data$Average.Medicare.Payments, 
                                              function(x)as.numeric(gsub("[,$]","",x)))

tab7.data$payment.medicare.gap <- as.numeric(tab7.data$Average.Total.Payments) - as.numeric(tab7.data$Average.Medicare.Payments)


Build.scatter.plot <- function(drg.name){
  

  #select the information that we need
  hospital.data <- select(tab7.data,
                          DRG.Definition,
                          Provider.Name, 
                          Average.Total.Payments, 
                          Average.Medicare.Payments,
                          payment.medicare.gap)%>%
    
                  #select the information that is about the selected DRC
                  filter(DRG.Definition == drg.name)%>%
  
                  #Output the information that we need
                  select(Provider.Name,
                         Average.Total.Payments, 
                         Average.Medicare.Payments,
                         payment.medicare.gap)
  
  #make a scatter plot
  scatter.plot <- plot_ly(hospital.data, 
                          x = ~Average.Total.Payments,
                          y = ~Average.Medicare.Payments,
                          
                          #Hover text, show the total payment, medicare and the hospital name
                          text = ~paste('Hospital:', Provider.Name),
                          
                          #the color is going to change according to the amount of gap
                          color = ~payment.medicare.gap,
                          
                          #The larger the gap is, the bigger the dot is
                          size = ~payment.medicare.gap)
  
return(scatter.plot)}

#-----------------------------discription---------------------------------#
#-----------------------------discription---------------------------------#
#-----------------------------discription---------------------------------#

#The bigger the gap between total payment and medicare, the bigger the dots is, the more yellow the color is 
#looking at the outliers, government will be able to know what hospital should be improve in specific DRG medicare

