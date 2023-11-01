#drop the County portion of county names

library("tidyr")
library("tidyverse")
library("readxl")
library("skimr")

President_Dirty = read_excel("countypres_2000-2020.xlsx")

President_Clean = President_Dirty |>
  mutate(
    County = gsub("County", "", President_Dirty$County)
  )

Pres_Sep = Prez_Vote |>
  pivot_wider(names_from = party, values_from = candidatevotes)

#export the df to excel to save it
install.packages("writexl")
library(writexl)

write_xlsx(President_Clean, "/Users/katelynschmitt/Documents/Econ 560/PROJECT/President_Clean2.xlsx")
