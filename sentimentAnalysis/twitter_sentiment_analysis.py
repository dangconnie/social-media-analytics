import matplotlib.pyplot as plt
import pandas as pd
import statsmodels.api as sm
import numpy as np

twitter_data = pd.read_csv('govt_shutdown_results.csv')
print(twitter_data.corr())

#plt.scatter(twitter_data.retwc, twitter_data.polarity)

#Let's look at polarity:
#Tweets with higher number of retweets tend to be on the negative side. Negative opinions are more viral?

#Let's do a subset to look more closely at subjectivity
twitter_data_subjective = twitter_data[twitter_data['subjectivity']>0.5]

print(twitter_data_subjective.corr())
#some of the correlation went from positive to negative

#Let's look at subjectivity
#plt.scatter(twitter_data.retwc, twitter_data.subjectivity)


# My turn
# Hypothesis: Subjectivity and polarity are inversely related.
# Independent: Polarity
# Dependent: Subjectivty
# Linear Regression: 
    # subjectivity = coeff * polarity + const
    # subjectivity = 0.0461 * polarity + 0.3327
    
x = twitter_data.polarity
y = twitter_data.subjectivity
x = sm.add_constant(x)

lr_model = sm.OLS(y,x).fit() 

print(lr_model.summary())

x_prime = np.linspace(x.polarity.min(), x.polarity.max())

# apply model
x_prime = sm.add_constant(x_prime)

#Make a prediction
y_hat = lr_model.predict(x_prime)

plt.scatter(twitter_data.polarity, twitter_data.subjectivity)
plt.xlabel("Polarity")
plt.ylabel("Subjectivity")
plt.plot(x_prime,y_hat)













