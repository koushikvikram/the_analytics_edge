# read in the data set
wine = read.csv("wine.csv")

str(wine)
# Year is an identifier
# we take Price to be our dependent variable
# WinterRain, AGST, HarvestRain, Age and FrancePop are our independent variables

summary(wine)

########## single variable linear regression using AGST to predict Price
# syntax for linear regression: lm(dependentVariable ~ independentVariable(s), data=dataSet)
model1  = lm(Price ~ AGST, data=wine) # lm stands for linear model

summary(model1) # Call, 
# Residuals - the error values for each point 
# Coefficients - the values in (Estimate) are beta0, beta1, etc 
# Multiple R-squared - value of R squared due to all independent variables (never decreases)
# Adjusted R-squared -  adjusts the R squared value to account for the number of independent variables used relative to the 
# number of data points (will decrease if you add an independent variable that doesn't help the model)

# Multiple R-squared = 0.435, Adjusted R-squared = 0.4105 
# b0 = -3.4178, b1 = 0.6351

model1$residuals # errors

# SSE for model1
SSE = sum(model1$residuals^2)
SSE # 5.734875

########## multiple linear regression dep: Price, indep: AGST + HarvestRain
model2 = lm(Price ~ AGST + HarvestRain, data=wine)

summary(model2)
# Multiple R-squared = 0.7074, Adjusted R-squared = 0.6808
# b0 = -2.20265, b1 = 0.60262, b2 = -0.00457

SSE = sum(model2$residuals^2)
SSE # 2.970373

########## multiple linear regression dep: Price, indep: AGST + HarvestRain + WinterRain + Age + FrancePop
model3 = lm(Price ~ AGST + HarvestRain + WinterRain + Age + FrancePop, data=wine)

summary(model3)
# b0 = -0.4504, b1 = 0.6012, b2 = -0.003958, b3 = 0.001043, b4 = 0.0005847, b5 = -0.00004953
# Multiple R-squared = 0.8294, Adjusted R-squared = 0.7845

SSE = sum(model3$residuals^2)
SSE # 1.732113

### Understanding the model
# We see that AGST and HarvestRain have '***' next to them. So, they are the most significant. 
# WinterRain has a '.' next to it. So, it is significant too.
# Age and FrancePop have no Significance codes next to them. So, they are insignificant and can be removed.

# Let's start by removing FrancePop, which we intuitively don't expect to be predictive of wine price anyway.
model4 = lm(Price ~ AGST + HarvestRain + WinterRain + Age, data=wine)
summary(model4)
# Multiple R-squared = 0.8286, Adjusted R-squared = 0.7943
# Adjusted R-squared is higher than that of model3's 

# now, we see that Age has '**' next to it. So, it is pretty significant now.
# earlier, age was not significant, but after FrancePop was removed, it has become more significant.
# This is because of multicollinearity. Age and FrancePopulation are highly correlated.

########## Correlation and Multicollinearity
# Correlation - a measure of the linear relationship between variables
# +1 = perfect positive linear relationship
# 0 = no linear relationship
# -1 = perfect negative linear relationship

# correlation between WinterRain and Price
cor(wine$WinterRain, wine$Price) # 0.1366505 - low correlation

# correlation between Age and FrancePop
cor(wine$Age, wine$FrancePop) # -0.9944851 - very high correlation

# compute the correlation between all pairs of variables in our data set
cor(wine)

# Multicollinearity - a situation when two independent variables are highly correlated
# We've confirmed that Age and FrancePop are highly correlated.
# So, we have multicollinearity problems in our model that uses all the independent variables.
# High correlation between an independent variable and dependent variable is a good thing

# Due to the problem of multicollinearity, you always want to remove the independent variables one at a time

# Let's see what would have happened if we had removed both Age and FrancePop at the same time, since they were both insignificant
model5 = lm(Price ~ AGST + HarvestRain + WinterRain ,data=wine)
summary(model5) # now, we see that AGST and HarvesRain are very significant, while WinterRain is slightly significant
# Multiple R-squared = 0.7537, Adjusted R-squared = 0.7185

# model4 has higher R-squared values
# So, if we had removed Age and FrancePop at the same time, we would have missed a significant variable, and the R-squared of our 
# final model would have been lower

# Why didn't we keep FrancePop instead of Age?
# We expect Age to be significant. Older wines are typically more expensive. So, Age makes more intuitive sense in our model.

# Multicollinearity reminds us that coefficients are only interpretable in the presence of other variables being used.
# cut-off value for what makes a correlation too high - no definitve answer, but generally > 0.7 or < -0.7 is cause for concern.

########## multiple linear regression dep: Price, indep: HarvestRain + WinterRain
model6 = lm(Price ~ HarvestRain + WinterRain, data=wine)

summary(model6)
# b0 = 7.865, b1 = -0.004971, b2 = -0.00009848
# Multiple R-squared = 0.3177, Adjusted R-squared = 0.2557

SSE = sum(model6$residuals^2)
SSE # 6.925756


########## Making predictions
# Let's see how well our model perfoms on some test data in R.
# We have two data points that we did not use to build our model in the file "wine_test.csv"
wineTest = read.csv("wine_test.csv")
str(wineTest)

# let's make predictions for these two test points
predictTest = predict(model4, newdata = wineTest)
predictTest # predicted price for 1st data point = 6.768925 and for 2nd data point = 6.684910
# actual price for 1st data point = 6.95 and 2nd data point = 6.5
# so, it looks like our predictions are pretty good.

# let's quantify this by computing R-squared value for our test set
SSE = sum((wineTest$Price - predictTest)^2)
SST = sum((wineTest$Price - mean(wine$Price))^2)
1 - SSE/SST # 0.7944278

# keep in mind that our test set is very small. We should increase the size of our test set to be more confident about the 
# out-of-sample accuracy of our model.



