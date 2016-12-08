

library(plotly)
library(stringr)
library(dplyr)
### Build plot ###

source("./scripts/Data Wrangling.R")

DrawBarplot <- function(data, state1, region1, city1, zip1, drg1, state2, region2, city2, zip2, drg2) {
  
  category <- c("Arg.Covered.Charges", "Arg.Total.Payments", "Arg.Medicare.Payments")
  
  search1 <- data %>% 
    filter(Provider.State == state1) %>% 
    filter(Hospital.Referral.Region.Description == region1) %>% 
    filter(Provider.City == city1) %>% 
    filter(Provider.Zip.Code == zip1) %>% 
    filter(DRG.Definition == drg1)

  cost1 <- c(search1$Average.Covered.Charges,
            search1$Average.Total.Payments,
            search1$Average.Medicare.Payments)

  search2 <- data %>% 
    filter(Provider.State == state2) %>% 
    filter(Hospital.Referral.Region.Description == region2) %>% 
    filter(Provider.City == city2) %>% 
    filter(Provider.Zip.Code == zip2) %>% 
    filter(DRG.Definition == drg2)
  
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
