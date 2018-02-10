# Demographics and Employment in the United States

# demographics and employment in the united states
# 
# In the wake of the Great Recession of 2009, there has been a good deal of focus on employment statistics, 
# one of the most important metrics policymakers use to gauge the overall strength of the economy. 
# In the United States, the government measures unemployment using the Current Population Survey (CPS), 
# which collects demographic and employment information from a wide range of Americans each month. 
# In this exercise, we will employ the topics reviewed in the lectures as well as a few new techniques using the September 2013 
# version of this rich, nationally representative dataset (available online).
# 
# The observations in the dataset represent people surveyed in the September 2013 CPS who actually completed a survey. 
# While the full dataset has 385 variables, in this exercise we will use a more compact version of the dataset, CPSData.csv, 
# which has the following variables:
#   
# PeopleInHousehold: The number of people in the interviewee's household.
# 
# Region: The census region where the interviewee lives.
# 
# State: The state where the interviewee lives.
# 
# MetroAreaCode: A code that identifies the metropolitan area in which the interviewee lives 
# (missing if the interviewee does not live in a metropolitan area). 
# The mapping from codes to names of metropolitan areas is provided in the file MetroAreaCodes.csv.
# 
# Age: The age, in years, of the interviewee. 80 represents people aged 80-84, and 85 represents people aged 85 and higher.
# 
# Married: The marriage status of the interviewee.
# 
# Sex: The sex of the interviewee.
# 
# Education: The maximum level of education obtained by the interviewee.
# 
# Race: The race of the interviewee.
# 
# Hispanic: Whether the interviewee is of Hispanic ethnicity.
# 
# CountryOfBirthCode: A code identifying the country of birth of the interviewee. 
# The mapping from codes to names of countries is provided in the file CountryCodes.csv.
# 
# Citizenship: The United States citizenship status of the interviewee.
# 
# EmploymentStatus: The status of employment of the interviewee.
# 
# Industry: The industry of employment of the interviewee (only available if they are employed).

# Problem 1 - Loading and Summarizing the Dataset

# Load the dataset from CPSData.csv into a data frame called CPS, and view the dataset with the summary() and str() commands.
# How many interviewees are in the dataset?

CPS = read.csv("CPSData.csv")
str(CPS)
summary(CPS)

sort(table(CPS$State))
table(CPS$Citizenship)
table(CPS$Race, CPS$Hispanic)

table(CPS$Region, is.na(CPS$Married))
table(CPS$Sex, is.na(CPS$Married))
table(CPS$Age, is.na(CPS$Married))
table(CPS$Citizenship, is.na(CPS$Married))

table(CPS$State, is.na(CPS$MetroAreaCode))
table(CPS$Region, is.na(CPS$MetroAreaCode))

tapply(is.na(CPS$MetroAreaCode), CPS$State, mean)

MetroAreaMap = read.csv("MetroAreaCodes.csv")
CountryMap = read.csv("CountryCodes.csv")

str(MetroAreaMap)
str(CountryMap)

CPS = merge(CPS, MetroAreaMap, by.x="MetroAreaCode", by.y="Code", all.x=TRUE)
str(CPS)
table(is.na(CPS$MetroArea))

table(CPS$MetroArea)
sort(tapply(CPS$Hispanic, CPS$MetroArea, mean))
sort(tapply(CPS$Race == "Asian", CPS$MetroArea, mean))

sort(tapply(CPS$Education == "No high school diploma", CPS$MetroArea, mean, na.rm=TRUE))

str(CPS)
str(CountryMap)
CPS = merge(CPS, CountryMap, by.x="CountryOfBirthCode", by.y="Code", all.x=TRUE)
str(CPS)
table(is.na(CPS$Country))

sort(table(CPS$Country))

table(CPS$MetroArea == "New York-Northern New Jersey-Long Island, NY-NJ-PA", CPS$Country == "United States")

table(CPS$Country == "India", CPS$MetroArea)
table(CPS$Country == "Brazil", CPS$MetroArea)
table(CPS$Country == "Somalia", CPS$MetroArea)
