#try and join the election data and the rural data by FIPS code
library("tidyr")
library("tidyverse")
library("readxl")
library("skimr")

#import our rural/urban data

Rural_Urb = read_excel("/Users/katelynschmitt/Documents/Econ 560/PROJECT/Rural_Urban_Clean.xlsx")
Election = read_excel( "/Users/katelynschmitt/Documents/Econ 560/PROJECT/President_Clean.xlsx")

#change the data type of FIPS in Election from double to char


#we need to subset the US territories and exclude them from the State col (these have fips > 60000)
#also need to change data type of FIPS to a numeric instead of char

Rural_Urb = Rural_Urb |>
  mutate(
    FIPS = as.numeric(FIPS)
  )

Rural_Urb = subset(Rural_Urb, FIPS < 60000)

Election = as.data.frame(Election)
Rural_Urb = as.data.frame(Rural_Urb)

#try and merge
Election_Rural = merge(Election, Rural_Urb)


#export the df to excel to save it
install.packages("writexl")
library(writexl)

write_xlsx(Election_Rural, "/Users/katelynschmitt/Documents/Econ 560/PROJECT/Election_Rural.xlsx")


