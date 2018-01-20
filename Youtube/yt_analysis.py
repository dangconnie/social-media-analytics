import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import statsmodels.api as sm # for linear modeling for regression

# load up data
youtube_data = pd.read_csv('video_result.csv')


# check what it looks like 
plt.figure()


# create a histogram
# numpy returns two objects that we would need to create the histogram. We will save them in two variables: hist1 and edges1
hist1, edges1 = np.histogram(youtube_data.viewCount)


# visualize it
# edges1 = x-axis
# hist1 = y-axis
# [:-1] = range
# Looking at the array (screenshot) in this case, 339919 (edges1) corresponds to 9 (hist1) 
# Using X values to determine how wide each bar should be: width=edges1[1:]-edges1[-1]
plt.bar(edges1[:-1], hist1, width=edges1[1:]-edges1[-1])


# Check for correlation:
# in my data, correlation is likecount to viewcount is 0.625547. As viewcount goes up, likecount goes up -> positive correlation. As viewcount goes up, dislikecount goes up. There is a stronger correlation between viewcount and dislikecount than between viewcount and likecount.
# direct correlation = 1.000000 hence the diagonal line of 1.000000 we see when the variable correlates with itself

print(youtube_data.corr())


# plot with scatterplot 
# x-axis is viewCount, y-axis is dislikeCount
plt.scatter(youtube_data.viewCount, youtube_data.dislikeCount)


# We already know that there is a correlation between viewCount and dislikeCount. But how are they related? Use a regression analysis to find out.
# Linear regression is used to find out if/how one variable can predict the other.
# =========================================
# =========================================
# dislikeCount = coeff * viewCount + const
# =========================================
# =========================================
# Once we know the coefficient and constant variable, we can predict the dependent variable (dislikeCount).
# viewCount(independent) will be our input and likeCount(dependent) will be our output


y = youtube_data.dislikeCount # 
x = youtube_data.viewCount
x = sm.add_constant(x)

# y = outcome, x = predictor
# find the best fitting line
lr_model = sm.OLS(y,x).fit() 

print(lr_model.summary())


# If viewCount = 1,000,000 how many dislikes should it have?
# dislikeCount = coeff * viewCount + const
# dislikeCount = 0.0031 * 1,000,000 + 3.646e+04 
# our prediction is that at 1,000,000 views, there would be 39560 dislikes


# =========================================
# =========================================
# let's test it
# =========================================
# =========================================


# generate 100 points within the x-min and x-max range
x_prime = np.linspace(x.viewCount.min(), x.viewCount.max(),100)

# apply model 
x_prime = sm.add_constant(x_prime)

# prediction
# x_prime is the input, which is the independent variable
# lr_model is our existing function
# y_hat is our prediction
# once plotted, the points represent our real data.
y_hat = lr_model.predict(x_prime)
plt.scatter(x.viewCount, y)
plt.xlabel("View Count")
plt.ylabel("Dislike Count")
plt.plot(x_prime[:,1], y_hat) # this is our regression line
