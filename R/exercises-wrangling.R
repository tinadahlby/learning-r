#load packages from the "R/package-loading.R" script
source(here::here("R/package-loading.R"))
library(tidyverse)
library(NHANES)

#Look at NHANES (In NHANES we already have a dataset to work with)
glimpse(NHANES)

#Save in R session, see it in Global Environment, Data
NHANES <- NHANES

#Open in new tab
View(NHANES)

#In Package tab (by files) you can search for the pacakge (NHANES) and see what is in it

# Check column names
colnames(NHANES)
# Look at contents
str(NHANES)
glimpse(NHANES)
# See summary
summary(NHANES)
# Look over the dataset documentation
?NHANES

##Messy vs tidy data: Tidy your dat, makes everything easier afterwards
#The pipe operator: %>%. Makes code more readable

###Excersise again
# Check the names of the variables
colnames(NHANES)

# Pipe the data into mutate function and:
NHANES_modified <- NHANES %>% # dataset
  mutate(
    # 1. Calculate average urine volume
    UrineVolAverage = (UrineVol1 + UrineVol2)/2,
    # 2. Modify Pulse variable
    Pulse_seconds = Pulse/60,
    # 3. Create YoungChild variable using a condition
    YoungChild = if_else(Age < 6, TRUE, FALSE)
  )
NHANES_modified

###Next exercise
# Filter so only those with BMI more than 20 and less than 40 and keep only those with diabetes.
# Filter to keep those who are working (“Work”) or those who are renting (“HomeOwn”) and those who do not have diabetes. Select the variables age, gender, work status, home ownership, and diabetes status.
# Using sorting and selecting, find out who has had the most number of babies and how old they are.

# To see values of categorical data
summary(NHANES)
NHANES %>%
  count(Work)
# 1. BMI between 20 and 40 and who have diabetes
NHANES %>%
  # format: variable >= number
  filter(BMI >= 20 & BMI <= 40 & Diabetes == "Yes")

# 2. Working or renting, and not diabetes
NHANES %>%
  filter(Work == "Working" | HomeOwn == "Rent" & Diabetes == "No") %>%
  select(Age, Gender, Work, HomeOwn, Diabetes)

# 3. How old is person with most number of children.
NHANES %>%
  arrange(desc(nBabies)) %>%
  select(Age, nBabies)
