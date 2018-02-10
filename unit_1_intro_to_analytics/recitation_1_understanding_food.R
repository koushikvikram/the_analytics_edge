# Recitation 1 - Undertanding Food: Nutritional Education with Data

# Use Ctrl+Shift+C for multi line comment

# Nutritional Facts about food - 
#   Good nutrition is an important part of leading a healthy lifestyle
#   Malnutrition can lead to obesity
#   
# Obesity -
#   More than 35% of US adults are obese - 
#     Obesity-related conditions are some of the leading causes of preventable death (heart disease, stroke, type II diabetes)
# 
#   Worldwide, obesity has nearly doubled since 1980
#   
#   65% of the world's population lives in countries where overweight and obesity kills more people than underweight

# Nutrition -
#   Good nutrition is essential for a person's overall health and well being, and is now more important than ever
# 
#   Hundreds of nutrition and weight-loss applications -
#     15% of adults with cell phones use health applications on their devices
# 
#   These apps are powered by the USDA Food Database

# USDA Food Database - 
#   The United States Department of Agriculture distributes a database of nutritional information for over 7,000 different food items
# 
# Used as the foundation for most food and nutrient databases in the US
# 
# Includes information about all nutrients -
#   Calories, carbs, proteins, fat, sodium, ...
#######################################################################################################################################

######################################## Working with data
# Step 1: Read info from csv file and save it in a data frame
USDA =  read.csv("USDA.csv") 

# Step 2: Let's learn about our data
str(USDA)
# names(USDA)
# head(USDA)

# Step 3: Let's obtain high-level statistical information about our dataset
summary(USDA)
# What's startling is that the max amount of Sodium is 38,758.0 mg, given that the daily recommended max is only 2,300 mg

######################################## Data Analysis

# Let's investigate which food has the highest amount of Sodium
USDA$Sodium # gives the list of sodium levels
which.max(USDA$Sodium) # gives the index of the food with highest sodium level, ie. 265

names(USDA) # gives the names of all variables in the USDA dataframe

# Let's find the food with highest sodium level
USDA$Description[265] # returns SALT, TABLE
# Having 38,758 mg of sodium in 100g of table salt makes sense, but none of us would eat 100g of table salt in one sitting

# It would be more interesting to find out which foods contain more than 10,000 mg of sodium
HighSodium = subset(USDA, Sodium>10000)
nrow(HighSodium) # to find out how many foods have sodium > 10000

HighSodium$Description # gives the names of foods with > 10000 mg of sodium in 100g of food

# our assumption was that caviar would appear in HighSodium, but it doesn't
# Let's get the index of caviar
match("CAVIAR", USDA$Description) # returns 4154

# Let's find the level of sodium in Caviar
USDA$Sodium[4154] # returns 1500

# Combining the above two steps into one
USDA$Sodium[match("CAVIAR", USDA$Description)]

# A good way to figure out how big a value this is, is by comparing it to the mean and standard deviation of sodium levels across
# the data set
summary(USDA$Sodium)
sd(USDA$Sodium, na.rm=TRUE) # to find standard deviation
# mean + sd = 322.1 + 1045.417 = 1367.517
# this is still smaller than the amount of sodium in 100g of caviar.
# so, caviar is pretty rich in sodium compared to most of the foods in our data set

######################################## Data Visualization

# Visualization is a crutial step for initial data exploration
# It helps us discern relationships, patterns and outliers.

# Let's create a scatterplot with Protein on the x-axis and Fat on the y-axis
plot(USDA$Protein, USDA$TotalFat)
# the plot has a very interesting triangular shape. 
# it looks like the foods that are higher in protein are lower in fat and vice-versa

# Let's improve the aesthetics of the graph by labeling the x and y axes, giving it a title and changing the color
plot(USDA$Protein, USDA$TotalFat, xlab="Protein", ylab="Fat", main="Protein vs Fat", col="red")

# Plotting histograms - another way to visualize data - hist() - takes in just one variable as input as y-axis should have frequencies
hist(USDA$VitaminC, xlab="Vitamin C (mg)", main="Histogram of Vitamin C levels")

# Let's zoom into the histogram a little more
# to do this, we need to limit the x-axis to go from 0 to say, 100 mg
hist(USDA$VitaminC, xlab="Vitamin C (mg)", main="Histogram of Vitamin C levels", xlim=c(0,100))
hist(USDA$VitaminC, xlab="Vitamin C (mg)", main="Histogram of Vitamin C levels", xlim=c(0,100), breaks = 100) # we also need to specify 
# the number of breaks
# we only see 5 cells, but we were expecting 100 cells. R actually divided the original interval ie. 0 to 2000 into 100 cells, then
# 2000 divided by 100, each cell would be 20mg long.
# But, we want to divide the interval 0 to 100 into 100 cells, each of length 1 mg.
hist(USDA$VitaminC, xlab="Vitamin C (mg)", main="Histogram of Vitamin C levels", xlim=c(0,100), breaks = 2000) 
# we see that more than 5000 of them have less than 1mg of Vitamin C

# Box plot 
boxplot(USDA$Sugar, main="Boxplot of Sugar Levels", ylab="Sugar(g)")
# we see that the average is around 5g, but we have a lot of outliers with extremely high values of sugar.

######################################## Adding variables to our data frame

# Let's say we want to add a variable to our USDA data frame that takes value 1 if the food has higher sodium than average,
# and 0 if the food has lower sodium than average.

# Step 1: Let's check if the first food in the dataset has a higher amount of sodium compared to the average.
USDA$Sodium[1] > mean(USDA$Sodium, na.rm=TRUE) # TRUE
# let's also check for the 50th food.
USDA$Sodium[50] > mean(USDA$Sodium, na.rm=TRUE) # FALSE

# Step 2: We can check this for all elements in the vector
USDA$Sodium > mean(USDA$Sodium, na.rm=TRUE)
# let's save this to a vector called HighSodium
HighSodium = USDA$Sodium > mean(USDA$Sodium, na.rm=TRUE)
# let's investigate the structure of the vector
str(HighSodium) # we see that the datatype is logi ie. logicals

# Step 3: We wanted values 1s and 0s instead of TRUE and FALSE. Let's convert logic to numeric
HighSodium = as.numeric(USDA$Sodium > mean(USDA$Sodium, na.rm=TRUE))
str(HighSodium)

# Step 4: Let's add this variable to the data frame
USDA$HighSodium = as.numeric(USDA$Sodium > mean(USDA$Sodium, na.rm=TRUE))
str(USDA)

# Step 5: Let's do the same for HighProtein, HighCarbs, HighFat
USDA$HighProtein = as.numeric(USDA$Protein > mean(USDA$Protein, na.rm=TRUE))
USDA$HighCarbs = as.numeric(USDA$Carbohydrate > mean(USDA$Carbohydrate, na.rm=TRUE))
USDA$HighFat = as.numeric(USDA$TotalFat > mean(USDA$TotalFat, na.rm=TRUE))
str(USDA)

######################################## Summary Tables

# How can we find the relationships between these variables, and also the original variables that we had in the USDA data frame?
# - table and tapply functions

# To figure out how many foods have higher sodium level than average, we want to look at the HighSodium variable and count the foods that
# have values 1
table(USDA$HighSodium)

# now let's see how many foods have both high sodium and high fat
table(USDA$HighSodium, USDA$HighFat) # here, the rows belong to 1st input ie. HighSodium and columns belong to 2nd input ie. HighFat
# so, there are 1355 foods with low sodium and high fat, etc.

# let's compute the average amount of iron sorted by high and low protein
tapply(USDA$Iron, USDA$HighProtein, mean, na.rm=TRUE)
# so, the foods with high protein, on average, have 3.197294 mg of iron and foods with low protein, on average have 2.558945 mg of iron

# let's compute the maximum level of vitamin C in foods with high and low carbs
tapply(USDA$VitaminC, USDA$HighCarbs, max, na.rm=TRUE)
# we see that The maximum vitamin C level, which is 2,400 milligrams is actually present in a food that is high in carbs.
# is it true that foods that are high in carbs have generally high vitamin C content?

# to examine that, let's use the summary function with tapply
tapply(USDA$VitaminC, USDA$HighCarbs, summary, na.rm=TRUE)
# looking at their means, it does look like a general trend. Foods with high carb content are on average richer in Vitamin C 
# compared to foods with low carb content