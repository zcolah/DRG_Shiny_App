

#list of the region name that is going to pass in the ui
regions <- tab3.data %>%
  
  #select the region name column in tab3.data
  select(Hospital.Referral.Region.Description) %>% 
  
  #discard the repeated region name
  distinct(Hospital.Referral.Region.Description)


#list of the drg name that is going to pass in the ui
drgs <- tab3.data %>% 
  
  #select the region name column in tab3.data
  select(DRG.Definition) %>% 
  
  #discard the repeated region name
  distinct(DRG.Definition)

 
