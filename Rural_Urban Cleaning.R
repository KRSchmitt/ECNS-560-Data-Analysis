#Cleaning the rural/urban data

#import our packages and our data
library("tidyr")
library("tidyverse")
library("readxl")
library("skimr")

Rural_Urban_Dirty = read_excel("Copy of ruralurbancodes2013.xls")

#we want to separate the names of the county so it just has the county name and not "county" after it
Rural_Urban_Name = Rural_Urban_Dirty |>
  mutate(
    County = gsub("County", "", Rural_Urban_Dirty$County_Name)
  )


#Now only select certain cols we want to keep and make a new binary col for rural status...make county all upper to match election/Census data
# RUCC_2013 is the identifying column for a county's classification as rural. We are taking rural as any county with < 20,000 residents. This is RUCC code of at least 6
Rural_Urban = Rural_Urban_Name |>
  select(County, FIPS, State, RUCC_2013) |>
  mutate(Rural = case_when(
    RUCC_2013 <= 5 ~ 0, 
    RUCC_2013 >=6 ~ 1 ),
    County = toupper(County)
         )

#now make a final clean file without the RUCC column
Rural_Urban_Clean = Rural_Urban |>
  select(County, FIPS, State, Rural)

#export the df to excel to save it
install.packages("writexl")
library(writexl)

write_xlsx(Rural_Urban_Clean, "/Users/katelynschmitt/Documents/Econ 560/PROJECT/Rural_Urban_Clean.xlsx")
