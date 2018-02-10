# Internet Privacy Poll

# Internet privacy has gained widespread attention in recent years. 
# To measure the degree to which people are concerned about hot-button issues like Internet privacy, social scientists conduct polls in which 
# they interview a large number of people about the topic. 
# In this assignment, we will analyze data from a July 2013 Pew Internet and American Life Project poll on Internet anonymity and privacy, 
# which involved interviews across the United States. 
# While the full polling data can be found here(http://www.pewinternet.org/2013/09/05/anonymity-privacy-and-security-online/), 
# we will use a more limited version of the results, available in AnonymityPoll.csv. 
# The dataset has the following fields (all Internet use-related fields were only collected from interviewees who either use the Internet 
#                                       or have a smartphone):
  
# Internet.Use: A binary variable indicating if the interviewee uses the Internet, at least occasionally 
# (equals 1 if the interviewee uses the Internet, and equals 0 if the interviewee does not use the Internet).

# Smartphone: A binary variable indicating if the interviewee has a smartphone 
# (equals 1 if they do have a smartphone, and equals 0 if they don't have a smartphone).

# Sex: Male or Female.

# Age: Age in years.

# State: State of residence of the interviewee.

# Region: Census region of the interviewee (Midwest, Northeast, South, or West).

# Conservativeness: Self-described level of conservativeness of interviewee, from 1 (very liberal) to 5 (very conservative).

# Info.On.Internet: Number of the following items this interviewee believes to be available on the Internet for others to see: 
# (1) Their email address; 
# (2) Their home address; 
# (3) Their home phone number; 
# (4) Their cell phone number; 
# (5) The employer/company they work for; 
# (6) Their political party or political affiliation; 
# (7) Things they've written that have their name on it; 
# (8) A photo of them; 
# (9) A video of them; 
# (10) Which groups or organizations they belong to; and 
# (11) Their birth date.

# Worry.About.Info: A binary variable indicating if the interviewee worries about how much information is available about them on the Internet 
# (equals 1 if they worry, and equals 0 if they don't worry).

# Privacy.Importance: A score from 0 (privacy is not too important) to 100 (privacy is very important), 
# which combines the degree to which they find privacy important in the following: 
# (1) The websites they browse; 
# (2) Knowledge of the place they are located when they use the Internet; 
# (3) The content and files they download; 
# (4) The times of day they are online; 
# (5) The applications or programs they use; 
# (6) The searches they perform; 
# (7) The content of their email; 
# (8) The people they exchange email with; and 
# (9) The content of their online chats or hangouts with others.

# Anonymity.Possible: A binary variable indicating if the interviewee thinks it's possible to use the Internet anonymously, 
# meaning in such a way that online activities can't be traced back to them 
# (equals 1 if he/she believes you can, and equals 0 if he/she believes you can't).

# Tried.Masking.Identity: A binary variable indicating if the interviewee has ever tried to mask his/her identity when using the Internet 
# (equals 1 if he/she has tried to mask his/her identity, and equals 0 if he/she has not tried to mask his/her identity).

# Privacy.Laws.Effective: A binary variable indicating if the interviewee believes United States law provides reasonable privacy protection 
# for Internet users 
# (equals 1 if he/she believes it does, and equals 0 if he/she believes it doesn't).

###########################################################################################################################################

########## Problem 1.1 - Loading and Summarizing the Dataset
# Using read.csv(), load the dataset from AnonymityPoll.csv into a data frame called poll and summarize it with the summary() and str() functions.
# How many people participated in the poll?  # 1002
poll = read.csv("AnonymityPoll.csv")
str(poll)
summary(poll)

# Problem 1.2 - Loading and Summarizing the Dataset
# Let's look at the breakdown of the number of people with smartphones using the table() and summary() commands on the Smartphone variable. 
# (HINT: These three numbers should sum to 1002.)
table(poll$Smartphone)
# How many interviewees responded that they use a smartphone?  # 487 
# How many interviewees responded that they don't use a smartphone?  # 472
sum(is.na(poll$Smartphone))
# How many interviewees did not respond to the question, resulting in a missing value, or NA, in the summary() output?  # 43

# Problem 1.3 - Loading and Summarizing the Dataset
# By using the table() function on two variables, we can tell how they are related. 
# To use the table() function on two variables, just put the two variable names inside the parentheses, 
# separated by a comma (don't forget to add poll$ before each variable name). 
# In the output, the possible values of the first variable will be listed in the left, and the possible values of the second variable 
# will be listed on the top. Each entry of the table counts the number of observations in the data set that have the value of the 
# first value in that row, and the value of the second variable in that column. 
# For example, suppose we want to create a table of the variables "Sex" and "Region". We would type
table(poll$Sex, poll$Region)
# in our R Console, and we would get as output

#        Midwest Northeast South West

# Female     123        90   176  116
 
# Male       116        76   183  122
 
# This table tells us that we have 123 people in our dataset who are female and from the Midwest, 
# 116 people in our dataset who are male and from the Midwest, 90 people in our dataset who are female and from the Northeast, etc.
# You might find it helpful to use the table() function to answer the following questions:

table(poll$State, poll$Region)
# Which of the following are states in the Midwest census region? (Select all that apply.)  # Kansas, Missouri, Ohio
# Which was the state in the South census region with the largest number of interviewees?  # Texas

# Another way to approach these problems would have been to subset the data frame and then use table on the limited data frame. 
# For instance, to find which states are in the Midwest region we could have used:
MidwestInterviewees = subset(poll, Region=="Midwest")
table(MidwestInterviewees$State)
# and to find the number of interviewees from each South region state we could have used:
SouthInterviewees = subset(poll, Region=="South")


########## Problem 2.1 - Internet and Smartphone Users
# As mentioned in the introduction to this problem, many of the response variables 
# (Info.On.Internet, Worry.About.Info, Privacy.Importance, Anonymity.Possible, and Tried.Masking.Identity) 
# were not collected if an interviewee does not use the Internet or a smartphone, 
# meaning the variables will have missing values for these interviewees.

# How many interviewees reported not having used the Internet and not having used a smartphone?  # 186
table(poll$Internet.Use, poll$Smartphone)  
# How many interviewees reported having used the Internet and having used a smartphone?  # 470
# How many interviewees reported having used the Internet but not having used a smartphone?  # 285
# How many interviewees reported having used a smartphone but not having used the Internet?  # 17

# Problem 2.2 - Internet and Smartphone Users
# How many interviewees have a missing value for their Internet use?  # 1
sum(is.na(poll$Internet.Use))
# How many interviewees have a missing value for their smartphone use?  # 43
sum(is.na(poll$Smartphone))

# Problem 2.3 - Internet and Smartphone Users
# Use the subset function to obtain a data frame called "limited", which is limited to interviewees who reported Internet use 
# or who reported smartphone use. In lecture, we used the & symbol to use two criteria to make a subset of the data. 
# To only take observations that have a certain value in one variable or the other, the | character can be used in place of the & symbol. 
# This is also called a logical "or" operation.
limited = subset(poll, Internet.Use == 1 | Smartphone == 1)
# How many interviewees are in the new data frame?  # 792
nrow(limited)

# Important: For all remaining questions in this assignment please use the limited data frame you created in Problem 2.3.

########## Problem 3.1 - Summarizing Opinions about Internet Privacy
# Which variables have missing values in the limited data frame? (Select all that apply.)
summary(limited)

# Problem 3.2 - Summarizing Opinions about Internet Privacy
# What is the average number of pieces of personal information on the Internet, according to the Info.On.Internet variable?  # 3.795455
mean(limited$Info.On.Internet)

# Problem 3.3 - Summarizing Opinions about Internet Privacy
# How many interviewees reported a value of 0 for Info.On.Internet?  # 105 
table(limited$Info.On.Internet)
# How many interviewees reported the maximum value of 11 for Info.On.Internet?  # 8

# Problem 3.4 - Summarizing Opinions about Internet Privacy
# What proportion of interviewees who answered the Worry.About.Info question worry about how much information is available about them 
# on the Internet? Note that to compute this proportion you will be dividing by the number of people who answered the Worry.About.Info 
# question, not the total number of people in the data frame.
table(limited$Worry.About.Info)  # 386/(404+386) = 0.4886076

# Problem 3.5 - Summarizing Opinions about Internet Privacy
# What proportion of interviewees who answered the Anonymity.Possible question think it is possible to be completely anonymous on the Internet?
table(limited$Anonymity.Possible)  # 278/(475+278) = 0.3691899

# Problem 3.6 - Summarizing Opinions about Internet Privacy
# What proportion of interviewees who answered the Tried.Masking.Identity question have tried masking their identity on the Internet?
table(limited$Tried.Masking.Identity)  # 128/(656+128) = 0.1632653

# Problem 3.7 - Summarizing Opinions about Internet Privacy
# What proportion of interviewees who answered the Privacy.Laws.Effective question find United States privacy laws effective?
table(limited$Privacy.Laws.Effective)  # 186/(541+186) = 0.2558459

########## Problem 4.1 - Relating Demographics to Polling Results
# Often, we are interested in whether certain characteristics of interviewees (e.g. their age or political opinions) affect their opinions 
# on the topic of the poll (in this case, opinions on privacy). 
# In this section, we will investigate the relationship between the characteristics Age and Smartphone and outcome variables 
# Info.On.Internet and Tried.Masking.Identity, again using the limited data frame we built in an earlier section of this problem.

# Build a histogram of the age of interviewees. What is the best represented age group in the population?
hist(limited$Age)  # People aged about 60 years old 

# Problem 4.2 - Relating Demographics to Polling Results
# Both Age and Info.On.Internet are variables that take on many values, so a good way to observe their relationship is through a graph. 
# We learned in lecture that we can plot Age against Info.On.Internet with the command 
plot(limited$Age, limited$Info.On.Internet)
# However, because Info.On.Internet takes on a small number of values, 
# multiple points can be plotted in exactly the same location on this graph.

# What is the largest number of interviewees that have exactly the same value in their Age variable AND the same value 
# in their Info.On.Internet variable? 
# In other words, what is the largest number of overlapping points in the plot plot(limited$Age, limited$Info.On.Internet)? 
# (HINT: Use the table function to compare the number of observations with different values of Age and Info.On.Internet.)
max(table(limited$Age, limited$Info.On.Internet))  # 6

# Problem 4.3 - Relating Demographics to Polling Results
# To avoid points covering each other up, we can use the jitter() function on the values we pass to the plot function. 
# Experimenting with the command 
jitter(c(1, 2, 3))
# what appears to be the functionality of the jitter command?
# By running the command jitter(c(1, 2, 3)) multiple times, we can see that the jitter function randomly 
# adds or subtracts a small value from each number, and two runs will yield different results.

# Problem 4.4 - Relating Demographics to Polling Results
# Now, plot Age against Info.On.Internet with 
plot(jitter(limited$Age), jitter(limited$Info.On.Internet))
# What relationship to you observe between Age and Info.On.Internet?
# Older age seems moderately associated with a smaller value for Info.On.Internet

# Problem 4.5 - Relating Demographics to Polling Results
# Use the tapply() function to obtain the summary of the Info.On.Internet value, 
# broken down by whether an interviewee is a smartphone user.
tapply(limited$Info.On.Internet, limited$Smartphone, summary)
# What is the average Info.On.Internet value for smartphone users?  # 4.386
# What is the average Info.On.Internet value for non-smartphone users?  # 2.923

# Problem 4.6 - Relating Demographics to Polling Results
# Similarly use tapply to break down the Tried.Masking.Identity variable for smartphone and non-smartphone users.
tapply(limited$Tried.Masking.Identity, limited$Smartphone, table) 
# What proportion of smartphone users who answered the Tried.Masking.Identity question have tried 
# masking their identity when using the Internet?  # 93/(390+93) = 0.1925466

# What proportion of non-smartphone users who answered the Tried.Masking.Identity question have tried 
# masking their identity when using the Internet?  # 33/(248+33) = 0.1174377






