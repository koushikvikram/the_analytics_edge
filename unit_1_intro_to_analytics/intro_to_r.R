sqrt2 = sqrt(2) # assign the value of sqrt(2) to the variable sqrt2 
hoursYear <- 365*24 # calculate the number of hours in a year and assign it to the variable hoursYear

######### vectors and data frames

# vectors
# you can create vectors in R using the combine function
# a vector is a series of numbers or characters stored as the same object
# you shouldn't combine characters and numbers in a vector - R will convert the numbers to characters
# R only allows one data type in each vector

c(2,3,5,8,13) # combine function
Country = c("Brazil", "China", "India", "Switzerland", "USA") # a vector of characters
LifeExpectancy = c(74, 76, 65, 83, 79) # a vector of numbers
Country[1] # returns the 1st element of Country vector
LifeExpectancy[3] # returns the 3rd element of LifeExpectancy vector

seq(0, 100, 2) # creates a sequence of numbers from 0 to 100 in increments of two
# seq can be useful if you want to create a unique identifier for observations

# dataframes - important data structure
# many algorithms in R require all of the data to be in a single object like a data frame
CountryData = data.frame(Country, LifeExpectancy) # we can combine the Country and LifeExpectancy vectors to create the CountryData dataframe

# adding another variable to our data frame
CountryData$Population = c(199000, 1390000, 1240000, 7997, 318000)

# adding new observations for Australia and Greece
Country = c("Australia", "Greece")
LifeExpectancy = c(82, 81)
Population = c(23050, 11125)
NewCountryData = data.frame(Country, LifeExpectancy, Population)
AllCountryData = rbind(CountryData, NewCountryData) # combines data frames by stacking the rows

#######################################################################################################################################

######### Loading Data Files
# navigate to the directory where the data file is located

getwd() # get the current working directory

WHO = read.csv("WHO.csv") # load the data in csv file into a variable WHO

# two very useful commands for looking at our data - str, summary

str(WHO) # gives the structure of our data
# data type Factor means that variables have several different categories or levels
# two types of numerical values - integers and num

summary(WHO) # gives a numeric summary of each of our variables
# for variables of type Factor, it lists the number of observations in each category/level
# for numerical variables, it lists Min, 1s Qu., Median, Mean, 3rd Qu., Max., (NA's)

# subsetting data - subset(dataframe, variable == category)
WHO_Europe = subset(WHO, Region == "Europe")
str(WHO_Europe)

# writing a data frame to a csv file - write.csv(dataframe, "filename.csv")
write.csv(WHO_Europe, "WHO_Europe.csv")

# removing a dataframe from our current session - useful if you're working with a large data set that's taking up a lot of space
rm(WHO_Europe)

######### Data Analysis - Summary statistics and Scatterplots

# To access a variable in a data frame, you will always have to link it to the data frame it belongs to with the dollar sign
Under15 # returns an error - Under15 not found
WHO$Under15 # returns the Under15 vector of the data frame WHO

# mean
mean(WHO$Under15)

# standard deviation
sd(WHO$Under15)

# we can apply the summary function on a variable too
summary(WHO$Under15)

# to see which observation in Under15 has the min value,
which.min(WHO$Under15) # returns the row number of the observation with the minimum value of Under15. In our case, returns 86
WHO$Country[86] # to see which country is observation 86

# to see which observation in Under15 has the min value,
which.max(WHO$Under15)
WHO$Country[124]

# A scatter plot of GNI vs fertility rate - plot(x-axis, y-axis)
plot(WHO$GNI, WHO$FertilityRate)

# Let's use the subset function to identify the countries with a GNI > 10,000 and fertility rate > 2.5
Outliers = subset(WHO, GNI>10000 & FertilityRate>2.5) # note the & symbol

# to see the number of rows - nrow(dataframe)
nrow(Outliers)

# let's output just the names, GNI and fertility rates of those 7 countries
Outliers[c("Country", "GNI", "FertilityRate")]


######### Data Analysis - Plots and summary tables

# Let's create a histogram of cellular subscribers
hist(WHO$CellularSubscribers)
# A histogram is useful for understanding the distribution of a variable.
# From our histogram, we see that the most frequent value of cellular subscribers is around 100

# Let's create a Boxplot of LifeExpectancy sorted by Region
boxplot(WHO$LifeExpectancy ~ WHO$Region) # notice the ~ sign

# useful for understanding the statistical range of a variable

# the box for each region shows the range between the first and third quartiles 
# with the middle line marking the median value
# The dashed lines at the top and bottom of the box (aka whiskers), show the range from the minimum to maximum values, excluding 
# any outliers (which are plotted as circles)
# Inter Quartile Range = 3rd quartile - 1st quartile (the height of the box)
# Outliers are computed as any points greater than the third quartile plus 1.5*IQR, or less than the first quartile minus 1.5*IQR. 

# labeling the plot
boxplot(WHO$LifeExpectancy ~ WHO$Region, xlab="", ylab="Life Expectancy", main="Life Expectancy of Countries by Region")
# xlab = "" because the boxplot fills x label by default

# summary tables
table(WHO$Region) # making a table of the Region variable
# tables work well for variables with only a few possible values

# for numerical variables, you can see some nice information using the tapply function
tapply(WHO$Over60, WHO$Region, mean) # splits data by the 2nd argument, then applies 3rd argument function to variable in 1st argument

tapply(WHO$LiteracyRate, WHO$Region, min) # you get NA's in your output because we have missing values in our data for literacy rate 

# remove NA
tapply(WHO$LiteracyRate, WHO$Region, min, na.rm=TRUE)
