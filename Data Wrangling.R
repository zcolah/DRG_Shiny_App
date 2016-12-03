library(dplyr)

original <- read.csv("./inpatient_Prospective_Payment.csv", stringsAsFactors = F)

DRG.location.payments <- original %>% 
  select(DRG.Definition,
         Provider.State,
         Provider.City,
         Provider.Zip.Code,
         Hospital.Referral.Region.Description,
         Average.Covered.Charges,
         Average.Total.Payments,
         Average.Medicare.Payments) %>% 
  group_by(Provider.State, 
           Provider.City, 
           Provider.Zip.Code, 
           DRG.Definition, 
           Hospital.Referral.Region.Description) %>% 
  summarise(Average.Covered.Charges = mean(as.numeric(gsub("\\$", "", Average.Covered.Charges))),
         Average.Medicare.Payments = mean(as.numeric(gsub("\\$", "", Average.Medicare.Payments))),
         Average.Total.Payments = mean(as.numeric(gsub("\\$", "", Average.Total.Payments))))

