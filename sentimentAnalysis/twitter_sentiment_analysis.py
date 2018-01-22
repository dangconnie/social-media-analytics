import matplotlib.pyplot as plt
import pandas as pd

twitter_data = pd.read_csv('govt_shutdown_results.csv')
print(twitter_data.corr())

plt.scatter(twitter_data.retwc, twitter_data.polarity)

#Let's look at polarity:
#Tweets with higher number of retweets tend to be on the negative side. Negative opinions are more viral?

#Let's do a subset to look more closely at subjectivity
twitter_data_subjective = twitter_data[twitter_data['subjectivity']>0.5]

print(twitter_data_subjective.corr())
#some of the correlation went from positive to negative

#Let's look at subjectivity
plt.scatter(twitter_data.retwc, twitter_data.subjectivity)


