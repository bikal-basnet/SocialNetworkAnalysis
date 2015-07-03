#	vim:shiftwidth=2:tabstop=2:expandtab:fo+=r:cc=57:tw=57
#=======================================================
# Title: Introduction to Social Network Analysis with R,
# part 1: Introduction to R.
#
# Author: Michal Bojanowski <m.bojanowski@uw.edu.pl>
#
# Description:
#
# Script used during the first part of the workshop
# "Introduction to SNA with R" during Sunbelt XXXIV
# (St Pete Beach, 2014-02-18)
#
# Licence:
#
# Creative Commons Attribution-NonCommercial-ShareAlike 
# CC BY-NC-SA
# http://creativecommons.org/licenses/by-nc-sa/3.0/
#
#=======================================================







#=======================================================
# Basic computing
#=======================================================

# Most basic use of R is an extended calculator. You may
# enter formulas directly, for example:

2+2               # simple computations
3 * (2 + 3)       # correct operator precedence
log(1)            # some mathematical functions
sin(pi/2)^2       # more complex formulas



### Assignment

x <- 2*3          # store the result as 'x'
x                 # show 'x'

# We create objects to use them later
someResult <- log(1) + sin(pi/2)
finalResult <- someResult / 2 + someResult^2
finalResult





### Using functions

log             # using just function name shows it

# using log() and ways to specify values of arguments:

log(1)     # without second argument, i.e. using second
           # argument's default value

log(2, base=2)  # argument by name
log(2, 10)      # argument by order

### "plumbing"

# Return value of one function becomes an argument for
# other function
log( sin(pi/2) * 9, 3)




#=======================================================
# R's help System and workspace
#=======================================================

# The help system can also be accessed using console and
# functons

# get help about some specific function or topic
help("log")
?log          # shorter equivalent to help("log")

# search the help pages for topics
help.search("log")
??log               # same as help.search("log")


# summary information page about a package, here package
# "igraph"
library(help="igraph")
help(package="igraph")  # same thing






#=======================================================
# Workspace
#=======================================================

# Workspace and objects can also be managed using
# functions

# Print names of user-created objects
# (returns a character vector)
ls()

# Remove some objects
rm( someResult, x)

ls()            # objects in workspace after the removal




#=======================================================
# Saving and loading objects
#=======================================================

# Saving and loading to/from R's native format with
# 'save()' and 'load()'

# Some objects
x <- 2 * pi
y <- x + 1
# save only 'x' to some file 'x.rda'
save(x, file="x.rda")

# saving both x and y to a single file 'xy.rda'
save(x, y, file="xy.rda")

# remove all visible objects from workspace
# you can also click the "brush" button on workspace pane
rm( list=ls() )
ls()              # empty workspace

load("x.rda")   # load 'x' from file
x
rm(x)           # remove 'x'


load("xy.rda")  # load 'x' and 'y' from file
ls()









#=======================================================
# Vectors
#=======================================================

### Numeric vectors

# Preferred season among Germans (1996)
# Values are percentages
# Source: http://awp.diaart.org/km/surveyresults.html

seasons.pct <- c(winter=4, spring=21, summer=14,
                 fall=15, nomatter=46)

length(seasons.pct) # vector length
sum(seasons.pct) # sum of elements

# Let's assume sample size was 1500
# convert to counts
seasons.n <- seasons.pct / 100 * 1500
seasons.n

barplot(seasons.n)



### Character vectors

# Vector of season names
names(seasons.n) 

# Assign new German names as a *character vector*
names(seasons.n) <- c("Winter", "Fruehling",
                      "Sommer", "Herbst", "ganzegal")
seasons.n



### Logical vectors

seasons.n
seasons.n < 300 # named logical vector

# Test whether element name is "Winter"
names(seasons.n) == "Winter"

# not "Winter"
names(seasons.n) != "Winter"

# Element names in specified set
names(seasons.n) %in% c("Winter", "Sommer")

# Useful functions:
z <- seasons.n < 100
any(z) # is any 'z' TRUE
all(z) # are all 'z's TRUE
which(z) # which elements of 'z' are TRUE




### Subscripting

# Using [ ]


# using character subscripts
seasons.n[ "Winter" ]
seasons.n[ c("Winter", "Herbst") ]

# Using logical subscripts
seasons.n[ seasons.n < 300 ] # elements less than 300
# not "ganzegal"
seasons2 <- seasons.n[ names(seasons.n) != "ganzegal"]
barplot(seasons2)

# using numerical subscript
seasons.n[1] # first element
seasons.n[ c(2, 4) ] # second and fourth
seasons.n[ -c(1,3) ] # all but first and third

# Useful functions for generating specific vectors
# Sequences
seq(1, 5)
1:5   # from:to
5:1
seq(1, 10, by=2)

# Reordering
seasons2
seasons2[4:1]
sort(seasons2)
order(seasons2)

# Repeating
rep(1, 5) # Repeat 1 five times
rep(1:2, each=2)
seasons.n[ rep(1:2, each=2) ]







### Conversion between vector types

# Functions:
#     as.numeric
#     as.character
#     as.logical
# do the conversion between the types of vectors

# to character type
as.character(1:5)

# to numeric from character
as.numeric( c("1", "2", "foo", "10", "bar") )
# This returns NA if conversion cannot be done, with a warning

# to logical from numeric
as.logical( c(-1, 0, 1, 2) )

# from logical 
as.numeric( c(TRUE, FALSE) )
as.character( c(TRUE, FALSE) )





















#=======================================================
# Importing data
#=======================================================



### Plain text files

# Example data 'sex_data.txt'
#
# Subset of Polish General Social Survey (PGSS):
# variables with opinions on gender roles plus some
# demographics.
#
# Source: Polish Social Science Data Archive
# (http://www.ads.org.pl)
#
# Look at data file in RStudio by clicking in file
# explorer.
#
# First line contains quoted variable names, following
# lines contain data. One line per case.
#
# Columns are separated with spaces
#
# Values of string variables are quoted.



# The general function for reading text data is
# 'read.table'.
#
# Extra arguments to 'read.table':
#
# header = logical, does the first line contain column
#     names
# sep = character, column separator
# as.is = logical, whether to skip creating factors from
#     string vars

sexdata <- read.table("sex_data.txt", header=TRUE,
                      sep=" ", as.is=TRUE )

# The object 'sexdata' is a "data frame": a class of objects for
# storing data sets 











### SPSS files

# Example data: 'earnings_data.sav'
# Another subset of PGSS with

# SPSS data files can be read with function 'read.spss'
# from package "foreign".
#
# We have to load the package "foreign" to be able to use
# the functions that it provides:

library(foreign)  # loads the package

# Additional arguments:
# to.data.frame = logical, whether to return a data frame
#     or list
# use.value.labels = logical, whether variables that have
#     value labels defined should be converted into
#     factors

earn <- read.spss("earnings_data.sav",
  to.data.frame=TRUE,
  use.value.labels=FALSE)

# 'earn' is a data frame

















#=======================================================
# Data frames
#=======================================================

### Data frame 'sexdata'

# Object structure can be inspected with the 'str'
# function. 
str(sexdata)

# other usefull functions on data frames:
nrow(sexdata)     # number of rows
ncol(sexdata)     # number of columns
names(sexdata)    # names of the variables
head(sexdata)     # first 6 observations
head(sexdata, 2)  # first 2 observations
tail(sexdata)     # last 6 observations




### Data frame 'earn'

# Structure
str(earn)
head(earn)

# Basic summary statistics of all variables
summary(earn)




### Referring to individual variables with '$'

# Age variable: looong vector
earn$age
# Mean of age
mean(earn$age)
# Frequency distribution of 'year'
table(earn$year)



### Function 'with'

# "Factor-out" references to a data frame

# These two have give the same result
table(earn$year)
with(earn,  table(year)  )

# Any complex statements inside 'with' are also possible.
# Add a new variable with year of birth

# without 'with'
earn$ybirth <- earn$year - earn$age
table(earn$ybirth)

# using 'with'
earn$ybirth <- with(earn, year - age)




#=======================================================
# Subscripting data frames, missing values
#=======================================================

# First 5 rows and variables 'age' and 'degree'
earn[1:5, c("age", "degree")]

# Subset of 'earn' for which 'age' is 92, all columns
earn[  earn$age == 92 ,  ]

# same, but only variable 'degree'
earn[  earn$age == 92 , "degree" ]

# See also function 'subset'





### Missing values

# Frequency table of education (years of schooling)
table(earn$degree, exclude=NULL)

# Usually the result of computation involving NAs
# is also NA.
mean(earn$degree)
sd(earn$degree)   # standard deviation

# Additional na.rm argument
mean(earn$degree, na.rm=TRUE)

# Working with missing values
#
# 'is.na' returns a logical vector whether the
# corresponding element is NA
is.na(earn$degree)
table( is.na(earn$degree) )
any(is.na(earn$degree)) # are there any NAs?
which(is.na(earn$degree)) # which elements are NA

# which cases of a data frame are complete (no NAs)
# 'k' is a logical vector
k <- complete.cases(earn) 
table(k)

# Create a subset of 'earn' containing complete
# observations
earnComplete <- earn[ complete.cases(earn)  , ]
summary(earnComplete)





### Recoding

# Create a copy of variable 'earnings', in which missing
# values are replaced with the mean of valid responses
earn$earnings2 <- with(earn, 
       replace( earnings, is.na(earnings),
               mean(earnings, na.rm=TRUE)))













### Bonus topic:
### accessing variable and value labels of datasets
### loaded with read.spss

# Additional SPSS-related data are also loaded. Under
# each variable entry there are additional attributes
str(earn)
# variable labels
attr(earn, "variable.labels")
# value labels of variable 'gender'
attr(earn$gender, "value.labels")





### Bonus topic:
### Attaching and detaching data frames.
### A dangerous alternative to 'with'.

# To save typing by frequently referring to the same data
# frame using '$' we can ``attach'' a data frame
names(earn)     # names of variables in data.frame 'earn'
ls()            # currently defined objects

# R will not "see" variables in data frame 'earn' if we
# use them directly
mean(year)      # error, cant find 'year'
mean(earn$year) # we need to refer to variables with '$'

# Attaching the data set

# places where R looks for objects/functions 
search()
# attach data frame to search path
attach(earn)
search()
# now variable 'year' can be found directly
table(year)
# detaching
detach(earn)
search()

# Remember to detach! If we modify the data frame while
# it is attached, the changes will not be visible. You
# would have to re-attach it.


#=======================================================
# Bonus topic: Factors
#=======================================================


# Factors are special type of vectors for storing
# categorical variables. Very useful in statistical
# models as they can be automatically transformed to a
# set of dummy variables

# Recall the structure of 'sexdata'
str(sexdata)

# let's make a factor from 'degree' (education)

unique(sexdata$degree)    # unique values of degree variable

# create a factor called 'f'
f <- factor(sexdata$degree,
            # vector of admissible values
            levels=c("Less than high school", "High school", "More than high school"),
            # corresponding value labels
            labels=c("<HS", "HS", "HS<") )

str(f)

# now R prints the labels instead of values
head(f)
summary(f)  # freq table
# admissible values
levels(f)
# add the factor to the dataset as a new variable "degreef"
sexdata$degreef <- f

str(sexdata)

# NOTE: Factors created automatically order the values
# alphabetically.
#
# NOTE: Factors are good as a final form of categorical
# data before modeling, but might not be very handy for
# data manipulation.


# Make a factor for gender in the 'sexdata' data frame
sexdata$female <- factor(sexdata$gender,
                         levels=c("Male", "Female"), labels=c("male", "female") )
str(sexdata$female)




#=======================================================
# Descriptive statistics
#=======================================================


### Basic numerical statistical description


# Arithmetical mean
mean(earnComplete$age)

# Median
median(earnComplete$earnings)

# Min and Max
min(earnComplete$earnings)
max(earnComplete$earnings)
# two-element vector with min and max
range(earnComplete$earnings)

# Variance and Standard Deviation
sd(earnComplete$earnings)
var(earnComplete$earnings)

# Quantiles (n-tiles)
quantile(earnComplete$earnings, probs=c(0.25, 0.75))
# 1st and 2nd quartile
quantile(earnComplete$earnings, probs=c(0.25, 0.75) )
# quintiles 1 through 4
quantile( earnComplete$earnings,
         probs=c(0.2, 0.4, 0.6, 0.8) )

# Correlation coeficient with 'cor'
with(earnComplete, cor(age, earnings))
# correlation matrix
cor(earnComplete)




### Examples of built-in visualization functions

# Univariate charts

# Function plot is generic
plot(earnComplete$earnings)
plot( sort(earnComplete$earnings) )


# Histograms
hist(earnComplete$earnings, 
     main="Histogram of earnings", xlab="Earnings")



# Density plots (smoothed histogram)
plot( density(earnComplete$earnings),
     main="Density of earnings",
     xlab="Earnings")


# Piecharts
# values of the plotted vector are to be relative sizes
# of the pie chunks
pie(1:3)
table(earnComplete$gender)
pie( table(earnComplete$gender),
    labels=c("Female", "Male") )




# Barplots
# expects a numeric vector of bar heights
barplot( 1:3)
table(earnComplete$degree)
barplot( table(earnComplete$degree),
        xlab="Years of schooling")


## Bivariate plots

# Scatter plot
# plot(x, y)
with( earnComplete, plot(degree, earnings ) )
# log earnings vs jittered 'degree' 
with( earnComplete, plot( jitter(degree), log(earnings) ) )


# Box-and-whisker plot
# note the formula as the first argument
boxplot( log(earnings) ~ degree, data=earnComplete )





### Bonus topics:
### Multivariate visualizations: coplot
### Requires factors.

# Conditioning plot

# earnings by education for men (1) and women (0)
coplot( log(earnings) ~  jitter(degree) | factor(gender),
       data=earnComplete)

# earnings by education for gender x year combinations
coplot( log(earnings) ~ jitter(degree) | factor(year) * factor(gender) ,
       data=earnComplete)

# earnings by age for different cohorts and gender
coplot( log(earnings) ~ age | ybirth * factor(gender),
       data=earnComplete)








#=======================================================
# Creating functions
#=======================================================

# Function computing arithmetic mean
mymean <- function(x)       
{
  # sum of 'x'
  s <- sum(x)
  s / length(x) 
}

# usage
mymean( 1:5 )
v <- c(1, 2, 3, NA, 4, 5)
mymean(v) 



# Alternative version that will drop NAs by default
mymean2 <- function(x)
{
  # indices of elements of 'x' which are valid
  ind <- which(!is.na(x))
  # use only valid
  sum(x[ind]) / length(x[ind])
}

mymean2(v)


# Create a function that will compute a standard
# deviation of some variable. If a variable has NAs,
# substitute them with the mean value of the valid cases.

mysd <- function(x)
{
  # substitute NAs with means
  x[is.na(x)] <- mymean2(x)
  sd(x)
}

# usual SD
sd(v, na.rm=TRUE)
mysd(v)





#=======================================================
# Tables and matrices
#=======================================================


# We have already used 'table' to get frequencies of a
# variable. It can be used also to create
# crosstabulations

# frequencies of education (degree) by year
tab <- table(earn$year, earn$degree)
tab
rownames(tab)   # names of rows
colnames(tab)   # names of columns



# Subscripting tables works like for data frames
tab[1,1]
tab[1:2,]
tab["1995", "0"] # by row and column names
# etc.


# Three dimensions
# education by year by gender, using 'with'
tab3d <- with(earn, table( year, degree, gender ))
tab3d

# Subscripting three-dimensional tables works analogously

# first row, first second column, first layer
tab3d[1,2,1]
tab3d[ , ,1]      # subtable in first layer (women)
tab3d["1992",,] # degree by gender for 1992
# etc.



# Missing data in tables.

# columns and rows for missing data in tables are by
# default supressed. Argument 'exclude' specifies values
# to be supressed, set it to NULL to show all.
with( earn, table(year, degree, exclude=NULL))


# Computing row/column summaries
tab
# row and column sums
rowSums(tab)
colSums(tab)
# there are also 'colMeans' and 'rowMeans'



### 'apply' function

# apply() can be used to compute any quantities based on
# rows/columns/layers etc. 
#
# Basic usage is
#
# apply( matrix, dimIDs, function )
#
# where
#
# matrix = any table/matrix
#
# dimIDS = is a id of a dimension: 1=rows, 2=columns,
# 3=layer, etc.
#
# function = any function that will be supplied with the
# fragments of the matrix



# row sums, equivalent to rowSums()
apply( tab, 1, sum )

# NOTE: Take table 'tab' and go through the values on the
# dimension 1 (rows).  For every such value select all
# the cells in table 'tab' on other dimensions (here for
# every row take all the cells in that row). Call a
# function 'sum' for those values.

# column means
apply( tab, 2, mean )


# Modal 'degree' for every year

apply(tab, 1, function(r) colnames(tab)[which.max(r)])
apply(tab, 1, function(r) r / sum(r) * 100 )
# NOTE function has been defined "on the fly" within the
# call to apply
# 'which.max(x)' is essentially 'which(x==max(x))'

prop.table(tab, 1) * 100




## # creating matrices from vectors

# same-length vectors can be "binded" to make matrices
cbind(1:5, 6:10)  # column-wise
rbind(6:10, 1:5)  # row-wise


# 'cbind' and 'rbind' also work with tables/matrices
#
ctab <- cbind(tab, SUM=rowSums(tab))
ctab

# added marginal distributions
rbind(ctab, SUM=colSums(ctab))







#=======================================================
# Group-wise descriptives
#=======================================================


### Function 'tapply'


# annual means of earnings
with(earnComplete,     tapply( earnings, year, mean ) )

# read as: "take earnings, split it by year, apply mean
# to such created groups"


# standard devs of earnings by education
with(earnComplete, tapply( earnings, degree, sd ) )



# if more than one grouping vector, specify as a list

# means by degree (education) and year
with(earnComplete,
     tapply( earnings, list(year, degree), mean ) )

# means by year by degree by gender
with(earnComplete, tapply( earnings,
                          list(year, degree, gender), mean))




### Function 'aggregate'

# 'aggregate' works simiarly but we can summarize more
# than one variable at a time
#
# aggregate can be used with the formula (as boxplot
# before)
#
# 'data' argument specifies data.frame where the
# variables can be found

# means of age and earnings by year
aggregate( cbind(earnings, age) ~  year,
          data=earnComplete, mean )

# age and earnings by year and education
a <- aggregate( cbind(earnings, age) ~ year + degree,
               data=earnComplete, mean )
str(a) # 'a' is a data frame!
head(a)
















#============================================================================ 
# Linear regression
#============================================================================ 

# Regression models are estimated using the 'lm'
# function. We specify the model using the formula
# interface: like in 'boxplot' or 'aggregate' before.



### Example 1: Modeling earinigs

# Estimate a regression model of earnings on age
mod1a <- lm( earnings ~ age, data=earnComplete)
mod1a

# Model summary
summary(mod1a)


# Add more independent variables
mod1b <- lm(earnings ~ degree + year + age,
           data=earnComplete)
summary(mod2)

# Add square effect of age
mod1c <- lm( earnings ~ degree + year + age + I(age^2),
           data=earnComplete)
summary(mod1c)

# All three models are nested. Perform incremental F-test
# (testing R-square change)
anova(mod1a, mod1b, mod1c)


# Model summary is also an object
s <- summary(mod1c)
# a lot of components
str(s)

# extract regression table (its a matrix)
coef(s)
str(coef(s))
coef(s)[,1:2] # just estimates and SEs
# Extract model R-squared
s$r.squared







### Example 2: Modeling opinions on gender roles

# Dependent variable: whether role of a man is to work and women
# to take care of the household
table( sexdata$q7d, exclude=NULL)
# 1=strongly agree
# 4=strongly disagree
# 8=dont know

# recode dont know as NA
sexdata$manworks <- with(sexdata, replace(q7d, which(q7d == 8), NA ))
# reverse the coding and assign to the same variable
sexdata$manworks <-  - sexdata$manworks + 5
# check the recoding
with(sexdata, table(manworks, q7d, exclude=NULL))


# bivariate model: age as an independent variable
mod2a <- lm( manworks ~ age, data=sexdata )
summary(mod0)
# adding square term
mod2b <- lm( manworks ~ age + I(age^2), data=sexdata )
summary(mod2b)


# The shape of the model-implied relationship can be
# visualized with fitted (predicted) values.


## computing model predictions (fitted values)

# data to base the predictions on
# variables in new data should have the same names as
# in the original data
newdata <- data.frame( age = seq( 18, 100, length=20) )
newdata

# here we set up the variable age to take 20 equally
# spaced values between 18 and 100



# compute the predicted values from model 'mod1' using data 'newdata' and save
# as a variable 'pred' in the data frame 'newdata'
newdata$pred <- predict(mod2b, newdata)
newdata

# plot the predictions
plot(pred ~ age, data=newdata, type="b", ylim=c(1,4))
# type="b"      plot both points and lines











### More regression examples
### Requires factors


# create a factor called for education
table(sexdata$degree)
sexdata$degreef <- factor(sexdata$degree,
            # vector of admissible values
            levels=c("Less than high school",
                     "High school", "More than high school"),
            # corresponding value labels
            labels=c("<HS", "HS", "HS<") )


# Make a factor for gender in the 'sexdata' data frame
table(sexdata$female)
sexdata$female <- factor(sexdata$gender,
                         levels=c("Male", "Female"),
                         labels=c("male", "female") )

# update model 'mod1', the '.' (dot) symbolizes all the
# terms that we have supplied in the original formula of
# model 'mod1' (so age and age^2)
mod2c <- update(mod2b,   . ~ . + degreef + sei + female )
summary(mod2c)

# 'degreef' is a factor, see that contrasts where created
# automatically setting first level as a reference
# category






### Contrasts

# default contrasts: "treatment" (dummy variable coding)
contrasts(sexdata$degreef)

# see ?contrast for available contrast types
contr.treatment(levels(sexdata$degreef), base=2)  # HS as a reference group
contrasts(sexdata$degreef) <- contr.treatment(levels(sexdata$degreef), base=2)
contrasts(sexdata$degreef)

# re-estimate the model
mod2d <- update(mod2b, . ~ . + degreef + sei + female )
summary(mod2d)




### Interaction effects

# interactions are represented with terms with '*'
mod2e <- update(mod2d, . ~ . + degreef*female)
summary(mod2e)

anova(mod2d, mod2e)










# we did that plot before
plot(pred ~ age, data=newdata, type="b", ylim=c(1,4))

# Let's add the value of R^2 

# first plot raw data
# jitter = add small random values so that density of values is visible
plot( jitter(manworks) ~ jitter(age), 
  data=sexdata, # data to be used
  pch=".",      # each point is approx one pixel
  xlab="Age",   # label for X axis
  ylab="Women's job is to run family",  # label for Y axis
  col="gray")   # color for the points

# add the regression line from the prediction we computed before
lines(pred ~ age, data=newdata)
# add the R^2 in a legend
legend("bottomright", 
  # paste creates a single string from components
  legend=paste("R-squared is", round(s$r.squared, 3)) )
  # 'round' rounds to three digits























#=======================================================
# Bonus topic: Custom plot construction
#=======================================================



# R offers a pen-and-paper way of constructing virtually
# any kind of plot you like. You can construct plots from
# basic elements like points, lines, polygons, arrows,
# legends, text etc. These are added one by one
# overplotting the ones added earlier

# Let's show changes in mean earnings by year and gender

# compute the means of earnings by year by gender
mearn <- with( earnComplete,
  tapply( earnings, list(year, gender), mean) )
mearn




# plotting step by step:

# vector of years, will use them for labelling
ox <- as.numeric( rownames(mearn) )
ox

# Let's show the mean earnings with a plot on which we
# will have years on the horizontal axis, earnings on the
# vertical axis and two separate lines for men and women

# NOTE: this is example shows how each of the elements of
# a plot can be added and customized separately. This is
# not the simplest way to create such a plot.




# now we create a plot step by step


# 1. create an empty plot just to set up the coordinates

plot( 1, type="n", xlim=range(ox), ylim=range(mearn),
     ann=FALSE, axes=FALSE )
# Used arguments:
# 1           dummy value, we have to plot something
# type="n"    do not plot anything
# xlim, ylim  ranges of X and Y axes
# ann=FALSE   do not draw default titles/labels
# axes=FALSE  do not draw axes

# 2. adding axes

# X axis
axis(1, at=ox, labels=ox, las=2) 
# 1       this is bottom axis, 1=bottom, 2=left, 3=top, 4=right
# at=ox   tick marks are to be at values in vector 'ox' (years)
# labels  labels of the tick marks also taken from 'ox'
# las=2   rotate labels to vertical, see help("par")

# Y axis
axis(2)   # 2=left, all other arguments use default settings


# 3. add lines with mean earnings

# line for women
lines(ox, mearn[,1], lty="solid", col="blue", lwd=2)
# draw a line which connects points with coordinates
# specified by the first two arguments: years in 'ox'
# vector as X-coordinates and mean earnings of women
# (first column of 'mearn') as Y-coordinates.
#
# Other arguments
#
# lty   type of line to use
# col   color
# lwd   line width, defaults to 1 so here a bit thicker

# line for men
lines(ox, mearn[,2], lty="solid", col="red", lwd=2)
# analogously to the previous one


# 4. add some annotation
title( main = "Mean earnings by gender",
  xlab="Years", ylab="Earnings")
# add titles
# main    top of the plot
# xlab,ylab   labels of x an y axes respectively

# 5. add a legend
legend( "topleft", col=c("blue", "red"), legend=c("Women", "Men"), lty="solid" )
# "topleft"     predefined position of the legend
# col           colors of the explained plot elements
# legend        labels of the explained plot elements
# lty="solid"   the explained elements are solid lines

# 6. Add an esthetically pleasing box around the whole data region of the plot
box()

# Done!




# quick way of doing that
matplot(mearn)

matplot(ox, mearn, type="l", col=c("blue", "red"), lwd=2, lty=1,
        xlab="Year", ylab="Mean earnings")
legend( "topleft", col=c("red", "blue"), legend=c("Men", "Women"), lty="solid" )



# Plotting functions of interest:
?lines
?points   # works like lines, but adds just the points
?legend
?axis
?polygon  # any closed shapes to be filled with colors or patterns
?par      # various plotting options
