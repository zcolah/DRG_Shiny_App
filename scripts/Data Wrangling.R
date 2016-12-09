library(dplyr)

# read inpatient prospective payments data frame as csv form and save it to a variable called 
# original
original <- read.csv("./inpatient_Prospective_Payment.csv", stringsAsFactors = F)

# create a new data frame with only DRG.Definition, Provider.State, Provider.City, 
# Provider.Zip.Code, Hospital.Referral.Region.Description, Average.Covered.Charges,
# Average.Medicare.Payments, and Average.Total.Payments. Use group_by to find the 
# columns that have exactly the same Provider.State, Provider.City, Provider.Zip.Code, 
# and Hospital.Referral.Region.Description, and use summarise function to calculate 
# the mean of Average.Covered.Charges, Average.Medicare.Payments, and Average.Total.Payments
# for for those columns. In addition, get rid of all the "$" in front of the numbers.

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

