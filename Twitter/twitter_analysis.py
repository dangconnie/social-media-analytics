import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import statsmodels.api as sm

twitter_data = pd.read_csv('result.csv')

plt.figure()
# hist1,edges1 = np.histogram(twitter_data.friends)
# plt.bar(edges1[:-1],hist1,width=edges1[1:]-edges1[-1])

plt.scatter(twitter_data.followers,twitter_data.retwc)

print(twitter_data.corr())

# retwc = coeff * followers + const
# retwc = -0.0083 * followers + 40.8858

y = twitter_data.retwc
x = twitter_data.followers
x = sm.add_constant(x)

# y = outcome
# x = predictor

lr_model = sm.OLS(y,x).fit()

print(lr_model.summary())





# How many retweets would you expect someone with 1,000 followers have?
x_prime = np.linspace(x.followers.min(), x.followers.max(), 100) 

# apply model
x_prime = sm.add_constant(x_prime)

# make a prediction
y_hat = lr_model.predict(x_prime)
plt.scatter(x.followers, y)
plt.xlabel("Follower Count")
plt.ylabel("Number of Retweets")
plt.plot(x_prime[:,1], y_hat) #this is the regression line