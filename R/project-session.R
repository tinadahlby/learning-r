###Make sure everything is relative to your R.proj fil. Do this always in the beginning
source(here::here("R/package-loading.R"))

#object assignment
weight_kilos <- 100
weight_kilos

# vector
c("a","b")
c(1,2)
1:10

# data frame
head(iris)

colnames(iris)
str(weight_kilos)
srt(iris)
summary(iris)



#data wrangling

# exercise ----------------------------------------------------------------

# To reformat code (to style the code): highlight code, use ctrl,shift,A.
# Object names

DayOne
day_one
F <- FALSE #this was a T, not smart because T is for true
c <- 9  #not smart to use c as c is a function
mean <- function(x) #not smart to use mean, as mean is a function
  sum(x)

# Spacing
x <- 1:10
x[, 1]
x[, 1]
x[, 1]
mean (x, na.rm = TRUE)
mean(x, na.rm = TRUE)
function (x) {
}
function(x) {
}
height <- feet * 12 + inches
mean(x, na.rm = 10)
sqrt(x ^ 2 + y ^ 2)
df$z


# Indenting
if (y < 0 && debug)
  message("Y is negative")

###create a function
summing <- function(a, b) {
  add_numbers <- a + b
  return(add_numbers)
}

summing(2, 2)


### put new files to a package
usethis::use_r("package-loading")

###SAVE always as csv file, this means take iris data file
write_csv(iris, here::here("data/iris.csv"))

iris_data <- read_csv(here::here("data/iris.csv"))
iris_data


#####NEXT SESSION######
#Data management, wrangling and best practices
#Messy vs tudy data, data transformations and summaries, reshaping data. %>%, filter, select, arrange, group by, summarise, gather,
#We will use HANES ?dataset?

#load NHANES and other packages
library(tidyverse)
library(dplyr)
library(NHANES)
