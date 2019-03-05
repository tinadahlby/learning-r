#load packages from the "R/package-loading.R" script
source(here::here("R/package-loading.R"))
#Look at NHANES (In NHANES we already have a dataset to work with)
glimpse(NHANES)

#Save in R session, see it in Global Environment, Data
NHANES <- NHANES

#Open in new tab
View(NHANES)

#In Package tab (by files) you can search for the pacakge (NHANES) and see what is in it

#Pipe opearator
#Thes two below are the same
colnames(NHANES)
NHANES %>% colnames()

# This is the standard R way of "chaining" functions together

#The two below are the same, but you can see that using the pipe operator meakes the code more easy to read
glimpse(head(NHANES))
NHANES %>%
  head() %>%
  glimpse()

# #mutate() function ------------------------------------------------------
#Put height in meters instead of cm. PS won't save dat frame that we already have, so we have to make a new name. So first:
NHANES_changed <- NHANES %>%
  mutate(Height_meters = Height/100)

#Use conditions to craete a new data variable (everyone who is highly active - more than 5) if else function: 5 (condition), yes if true, no if false
#Can also put in & OR (|)
NHANES_changed <- NHANES_changed %>%
  mutate(HighlyActive = if_else(PhysActiveDays >= 5, "yes", "no"))

#changing multiple varibales at one time by using comma
NHANES_changed <- NHANES_changed %>%
  mutate(new_column = "only one variable",
      Height = Height/100,
      UrineVolAverage = (UrineVol1 + UrineVol2)/2)


# select(): select specific data by the variable --------------------------

#select columns/variables by name, without qutoes
NHANES_characteristics <- NHANES %>%
  select(Age, Gender, BMI)

#To unselect variabels
NHANES %>%
  select(-HeadCirc)

#To make life easier, e.g. all with similar names, you can use matching function to find all the ones with this name (e.g. urin1, 2 etc)
#Here (below) we select all that starts with BP and all variabels that contains Vol
NHANES %>%
  select(starts_with("BP"), contains("Vol"))

# Use ?select_helpers to find specifc select commands, e.g ends with

# rename(): Rename specific columns ---------------------------------------

#rename using the form: "newname = oldname"
#Note that the script below is not saved. To do so, you have to  assign a name to the data.frame
NHANES %>%
  rename(NumberBabies = nBabies)


# filter(): filtering/subsetting the data by row --------------------------

#when gender is equal to (only females)
NHANES %>%
  filter(Gender == "female")
#you can also say "gender is not females" (or select for only male, but if you want to select many, it may be easier to exclude)
NHANES %>%
  filter(Gender != "female")
#Select/filter for BMI equal to 25
NHANES %>%
  filter(BMI == 25)
#Filter for several condtions: when BMI is 25 and gender is female
NHANES %>%
  filter(BMI == 25 & Gender == "female")
#filter for BMI 25 or female
NHANES %>%
  filter(BMI == 25 | Gender == "female")

# arrange(): Sort/arrange data by columns ---------------------------------

#Default is ascending order (smalles values on top)
#Here we also selcet for only Age, so its easier to see
NHANES %>%
  arrange(Age) %>%
  select(Age)
#oredr by ascending
NHANES %>%
  arrange(desc(Age)) %>%
  select(Age)
#order by age and gender
NHANES %>%
  arrange(Age, Gender) %>%
  select(Age, Gender)

# group_by(), summarise(): create a summary of the data, alone or  --------

#can write summarise or summarize
NHANES <- NHANES
#summarize by itself: Find
NHANES %>%
  summarize(MaxAge = max(Age, na.rm = TRUE),
            MeanBMI = mean(BMI, na.rm =TRUE))
#combine with group_BY()
NHANES %>%
  group_by(Gender) %>%
  summarize(MaxAge = max(Age, na.rm = TRUE),
            MeanBMI = mean(BMI, na.rm = TRUE))

NHANES %>%
  group_by(Gender, Diabetes) %>%
  summarize(MaxAge = max(Age, na.rm = TRUE),
            MeanBMI = mean(BMI, na.rm = TRUE))


# gather(): Converting data from wide to long form ------------------------

#Wide format: A column for each varibale f.ex.Eg one column for year 1999, 2000 etc.
#Usually dat is imported like this, but sometimes a long format is easier to visualize, e.g a column named year, whene the 99 and 00 is located

table4b #wide format

table4b %>%
  gather(key = year, value = population, -country) #key argument: what we want 1st. subtract what you don't want to gather with -
#the above is now in long format

table4b %>%
  gather(key = year, value = population, '1999', '2000') #same as above, but written differently


# combining gather and summarize ------------------------------------------

#keep only variables of interest to us
nhanes_char <- NHANES %>%
  select(SurveyYr, Gender, Age, Weight, Height, BMI, BPSysAve) #making new data table
#convert to long format, excluding survey year and gender in the gathering, ie Age, BMI etc is in Measure, and their numerical is in value
nhanes_long <- nhanes_char %>%
  gather(Measure, Value, -SurveyYr, -Gender)
nhanes_long
tail(nhanes_long) #Checking that I understood the above by looking at the end of the table
#calculate mean on each measure, by gender and survey year: making a more descriptive table
nhanes_long %>%
  group_by(SurveyYr, Gender, Measure) %>%
  summarize(MeanValues = mean(Value, na.rm = TRUE))


