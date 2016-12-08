

#list of the state name that is going to pass in the ui
states <- tab3.data %>% 
  select(Provider.State) %>% 
  distinct(Provider.State)


#if you input a state, it will give you the region in the state
locate.region <- function(state) {
  region.locate <- tab3.data %>% 
    ungroup() %>% 
    select(Provider.State, Hospital.Referral.Region.Description) %>% 
    distinct(Provider.State, Hospital.Referral.Region.Description) %>% 
    filter(Provider.State == state) %>% 
    select(Hospital.Referral.Region.Description)
  
  return(region.locate)
}

#if you input a region, it will give you the DRG in the region in every hospital
locate.drg <- function(region) {
  drg.locate <- tab3.data %>% 
    ungroup() %>% 
    select(Hospital.Referral.Region.Description, DRG.Definition) %>% 
    distinct(Hospital.Referral.Region.Description, DRG.Definition) %>% 
    filter(Hospital.Referral.Region.Description == region) %>% 
    select(DRG.Definition)
  return(drg.locate)
}



#-------------------------------test-----------------------------------#
#-------------------------------test-----------------------------------#
#-------------------------------test-----------------------------------#
#state <- 'WA'
#region <- 'WA - Seattle'

