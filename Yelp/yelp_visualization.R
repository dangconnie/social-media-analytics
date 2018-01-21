#=======================================================
#=======================================================
#+++++++++++++++++ Business Data +++++++++++++++++++++++
#=======================================================
#=======================================================


# Get some info on the business dataset
library(ggplot2)
business_data = read.csv(file="yelp_business_dataset.csv")

# Plot business dataset
ggplot(business_data) + geom_bar(aes(x=state), fill="pink")

#Distribution of stars in business dataset
ggplot(business_data) + geom_bar(aes(x=stars), fill="green")

#Pie Chart
ggplot(data=business_data, aes(x=(1), fill=factor(stars))) + geom_bar(width = 1) + coord_polar(theta="y") 



#=======================================================
#=======================================================
#+++++++++++++++++++++ User Data +++++++++++++++++++++++
#=======================================================
#=======================================================

user_data = read.csv(file="yelp_user_dataset.csv")
#user data has two dimensions separated by commas so user_votes = user_data[,] would get the whole table

#Get all these rows with these three columns into this table called user_votes
user_votes = user_data[,c("cool_votes", "funny_votes", "useful_votes")]

#Do users with more fans get more "funny_votes"?
#Yes, there is a high correlation betwen fans and funny_votes: 0.731
cor(user_data$funny_votes, user_data$fans)

cor(user_data$useful_votes, user_data$fans)


#Create a linear model to do regression analysis
#how is useful_votes related to review_count and fans?
#Useful_vote is our output. Review_count and fans are inputs.
#Regression equation: useful_votes = (1.42 * 22.69) + (22.69 * fans) + (-18.26)
my.lm = lm(useful_votes ~ review_count + fans, data=user_data)
coeffs = coefficients(my.lm)
coeffs

ggplot(user_data) + geom_bar(aes(x=review_count), fill="purple")

#Clustering
# --- allows us to see how data is distributed and if there is any underlying structure/organization
# --- K-means: a popular clustering technique where k=number of clusters desired
# Let's try out clustering:
userCluster = kmeans(user_data[,c(3,11)], 3) # only check out columns 3-11 since we don't care about user_id and name and we want 3 clusters

#Visualize Cluster
# Look at all the data (so no specifications for user_data), x-axis = review count, y = fans, point-based visualization(scatterplot)
ggplot(user_data,aes(review_count,fans,color=userCluster$cluster)) + geom_point()

#Correlation analysis to see if different variables are related
#Regression analysis to see how those variables are related (you get coeffcients and constants from regression analysis)
#Clustering to discover underlying organization of data


#=======================================================
# ======================== My Turn =====================s
# How are the average_stars and useful_votes related?
#=======================================================
#=======================================================
# Hypothesis: Most users who give useful_votes have 3+ stars

user_data = read.csv(file="yelp_user_dataset.csv")

cor(user_data$useful_votes, user_data$average_stars) # 0.001898496 - a very weak correlation


