#Cleaning the presidential election data

#import our packages and libraries
library("tidyr")
library("tidyverse")
library("readxl")
library("skimr")
President_Dirty = read_excel("countypres_2000-2020.xlsx") #importing our data

#here we want to be able to sort by the years of our interest, so make a binary var for them
President_year1 = President_Dirty |>
    mutate(
      Test = group_by(year>2011),
      Test = case_when(
        Test = "FALSE" ~ 0,
        Test = "TRUE" ~1
      )
    )

#filter out any year before 2012 and any candidate not Dem or Repub, change var names to match Census data (removing County from County names)
President_Cleaner = President_Dirty |>
  select(year, state_po, county_name, county_fips, party, candidatevotes, totalvotes) |>
  filter(year>2011) |>
  filter(party != "OTHER") |>
  mutate(
    FIPS = county_fips,
    County = county_name,
    State = state_po,
    Year = year,
    Party = party,
    'Candidate Votes' = candidatevotes,
    'Total Votes' = totalvotes,
    County = gsub("County", "", County)
  )

#make final df with the cols we want
President_Clean = President_Cleaner |>
  select(Year, State, County, FIPS, Party, 'Candidate Votes', 'Total Votes' )
  

#export the df to excel to save it
install.packages("writexl")
library(writexl)

write_xlsx(President_Clean, "/Users/katelynschmitt/Documents/Econ 560/PROJECT/President_Clean2.xlsx")
