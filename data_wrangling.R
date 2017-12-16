# Pauliina Anttila
# pauliina.anttila@helsinki.fi
# 16.12.2017

# I'm working on my final assignment for the Introduction to Open Data Science course. This file is created for some data wrangling necessary for the data analysis. I'm using Boston data set from the MASS package.

# Let's first open the MASS package and then the Boston dataset:
library(MASS)
data("Boston")

# Then some exploring of the data. The dataset is about housing values in the suburbs of Boston, metadata can be seen here: https://stat.ethz.ch/R-manual/R-devel/library/MASS/html/Boston.html.

str(Boston) # 506 observations of 14 variables. Two of the variables are integers, the rest are numeric.
head(Boston) # checking the first 6 rows of the data
View(Boston) # easy way to look at the data as a table

# The Boston dataset contains an interesting variable: crim = per capita crime rate by town. Next, we will create a new crime variable form the crim variable. The new crime variable will be a categorical variable with 4 categories (low, med_low, med_high, high), the categories will be divided by quantiles.

quantiles <- quantile(Boston$crim) # creating the quantiles
print(quantiles)
crime <- cut(Boston$crim, breaks = quantiles, include.lowest = TRUE, label = c("low","med_low","med_high","high")) # creating a categorical variable crime
table(crime) # looking at the new 'crime' variable
Boston_crimecat <- data.frame(Boston, crime) # adding the new 'crime' variable to the Boston dataset
str(Boston_crimecat)
View(Boston_crimecat)

# I'm going to perform some regression analysis (both linear and logistic). For the logistic regression I need a binary target variable from 'crime' variable. I'm especially interested in high crime rate, so I will create a variable 'crime_high', which is true if crime = 4 i.e. high.

Boston_crime <- mutate(Boston_crimecat, crime_high = crime == 4)
str(Boston_crime) # 506 observation of 16 variables (two new ones included)

# Writing a CSV file of the wrangled dataset:

write.csv(Boston_crime, file="~/Documents/GitHub/IODS-final/Boston_crime.csv", row.names = FALSE)
