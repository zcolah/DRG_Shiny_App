library(plotly)
library(stringr)
library(dplyr)
### Build plot ###

source("./Data Wrangling.R")

DrawBarplot <- function(data, state1, city1, zip1, hospital1, drg1, state2, city2, zip2, hospital2, drg2) {
  
  category <- c("Arg.Covered.Charges", "Arg.Total.Payments", "Arg.Medicare.Payments")
  
  state1.equation <- paste0('~', state1)
  city1.equation <- paste0('~', city1)
  zip1.equation <- paste0('~', zip1)
  hospital1.equation <- paste0('~', hospital1)
  drg1.equation <- paste0('~', drg1)
  
  state2.equation <- paste0('~', state2)
  city2.equation <- paste0('~', city2)
  zip2.equation <- paste0('~', zip2)
  hospital2.equation <- paste0('~', hospital2)
  drg2.equation <- paste0('~', drg2)
  
  search1 <- data %>% 
    filter(Provider.State == eval(parse(text = state1.equation)),
           Provider.City == eval(parse(text = city1.equation)),
           Provider.Zip.Code == eval(parse(text = zip1.equation)),
           Hospital.Referral.Region.Description == eval(parse(text = hospital1.equation)),
           DRG.Definition == eval(parse(text = drg1.equation)))
  cost1 <- c(search1$Average.Covered.Charges,
             search1$Average.Total.Payments,
             search1$Average.Medicare.Payments)
  
  search2 <- data %>% 
    filter(Provider.State == eval(parse(text = state2.equation)),
           Provider.City == eval(parse(text = city2.equation)),
           Provider.Zip.Code == eval(parse(text = zip2.equation)),
           Hospital.Referral.Region.Description == eval(parse(text = hospital2.equation)),
           DRG.Definition == eval(parse(text = drg2.equation)))
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
