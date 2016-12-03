library(plotly)
library(stringr)
library(dplyr)
### Build plot ###

source("./Data Wrangling.R")

DrawBarplot <- function(data, state1, city1, zip1, hospital1, drg1, state2, city2, zip2, hospital2, drg2) {
  
  category <- c("Arg.Covered.Charges", "Arg.Total.Payments", "Arg.Medicare.Payments")
  
  # state1.equation <- paste0('~', state1)
  # city1.equation <- paste0('~', city1)
  # zip1.equation <- paste0('~', zip1)
  # hospital1.equation <- paste0('~', hospital1)
  # drg1.equation <- paste0('~', drg1)
  # 
  # state2.equation <- paste0('~', state2)
  # city2.equation <- paste0('~', city2)
  # zip2.equation <- paste0('~', zip2)
  # hospital2.equation <- paste0('~', hospital2)
  # drg2.equation <- paste0('~', drg2)
  
  search1 <- data %>% 
    filter(Provider.State == state1,
           Provider.City == city1,
           Provider.Zip.Code == zip1,
           Hospital.Referral.Region.Description == hospital1,
           DRG.Definition == drg1)
  cost1 <- c(search1$Average.Covered.Charges,
            search1$Average.Total.Payments,
            search1$Average.Medicare.Payments)

  search2 <- data %>% 
    filter(Provider.State == state2,
           Provider.City == city2,
           Provider.Zip.Code == zip2,
           Hospital.Referral.Region.Description == hospital2,
           DRG.Definition == drg2)
  cost2 <- c(search2$Average.Covered.Charges,
            search2$Average.Total.Payments,
            search2$Average.Medicare.Payments)
  
  p <- plot_ly(data, x = ~category,
               y = ~cost1,
               type = 'bar', name = 'Option A') %>% 
    add_trace(y = ~cost2, name = 'Option B') %>% 
    layout(yaxis = list(title = 'Cost($)'), barmode = 'group')
  return(p)
}


# DrawBarplot(data = DRG.location.payments, 
#   state1 = 'AK', city1 = 'ANCHORAGE', 
#   zip1 = '99508', hospital1 = 'AK - Anchorage', 
#   drg1 = '066 - INTRACRANIAL HEMORRHAGE OR CEREBRAL INFARCTION W/O CC/MCC', 
#   state2 = 'MD', city2 = 'ANNAPOLIS', zip2 = '21401', hospital2 = 'DC - Washington',
#   drg2 = '303 - ATHEROSCLEROSIS W/O MCC')
