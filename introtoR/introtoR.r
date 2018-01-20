# year%%4 means "divide year by 4 and look for the remainder"

year = 2018
if (year%%4 == 0){
  print ('leap year')
}else{
  print('not a leap year')
}


# Load a csv file in R:
# you can also put the name of the file in file.choose(). If not, when you run this, it will give you the option to choose the file. Header = TRUE b/c we have headers. Each item is separated by a comma for csv file.
df = read.table(file.choose(), header=TRUE, sep=",")
view(df)

#df = dataframe
#extract the brain column: 
brain = df["Brain"]
print(summary(brain))

#tsv = tab separated file

#load library for visualization
library(ggplot2)
custdata = read.table(file.choose(), header=TRUE, sep='\t')
View(custdata)

#let's plot it
#the dataframe is cusdata. we want a histogram with the age as the x-axis
#bin 10 means that each bin can hold an age range of 10 years -> more people fit into each age range -> lower resolution
#bin 5 means that it's a smaller bin -> more distributed data
#ggplot(custdata) + geom_histogram(aes(x=age),binwidth = 5)
ggplot(custdata) + geom_histogram(aes(x=age),binwidth = 10)

ggplot(custdata) + geom_bar(aes(x=marital.stat))

#is there a correlation between age and income?
#age in the custdata dataframe. age column in custdata table.
cor(custdata$age, custdata$income)
#when we run this, we see that the correlation is 0.0274, which is a lot lower than expected. We might need to remove of the numbers that are zero or negative.

#create a subset of an existing dataset and give it some conditions
custdata2 = subset(custdata,(custdata$age>0 & custdata$age<100 & custdata$income>0))

cor(custdata2$age, custdata2$income)
#now, we get a correlation of -0.0224. That means that as age goes up, income goes down. Could be effects of retirement on income.
