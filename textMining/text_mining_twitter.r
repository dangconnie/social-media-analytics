library(tm)
#library(tmap)
library(igraph)
library(SnowballC)


sf<-system.file("texts", "txt", package = "tm")
ds <-DirSource(sf)
your_corpus <-Corpus(ds)

# Check status with the following line
meta(your_corpus[[1]])


twitter_data = read.csv(file.choose(), header=TRUE,sep=",",encoding="UTF-8", stringsAsFactors = FALSE)
twitter_data$text = paste(substr(twitter_data$text,2,nchar(twitter_data$text))) # We may need to remove the first charactore 'b' from the string.

# Clean Data
text = twitter_data$text
text_clean = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", text) # remove retweet entitites
text_clean = gsub("@\\w+", "", text_clean) # remove @people
text_clean = gsub("[[:punct:]]", "", text_clean) # remove punctuation symbols
text_clean = gsub("[[:digit:]]", "", text_clean) # remove numbers
text_clean = gsub("http\\w+", "", text_clean) # remove links

# Create Corpus and Term-Document Matrix
text_corpus = Corpus(VectorSource(text_clean)) # corpus
text_corpus = tm_map(text_corpus, tolower) # convert to lower case
text_corpus = tm_map(text_corpus, removeWords, c(stopwords("english"), "government")) # remove stopwords
text_corpus = tm_map(text_corpus, stripWhitespace) # remove extra white spaces
#text_corpus = tm_map(text_corpus, PlainTextDocument)

tdm = TermDocumentMatrix(text_corpus) # term-document matrix
m = as.matrix(tdm) # convert to a matrix

# Only choose popular words

# We choose popular words (word frequency > 90% percentile)
# remove sparse terms (word frequency > 90% percentile)
wf = rowSums(m)
m1 = m[wf>quantile(wf,probs=0.9), ]

# remove columns with all zeros
m1 = m1[,colSums(m1)!=0]

# for convenience, every matrix entry must be binary (0 or 1)
m1[m1 > 1] = 1

# change it to a Boolean matrix
#m[m>=1] <- 1
# transform into a term-term adjacency matrix
termMatrix = m1 %*% t(m1)

#Build and plot a graph
library(igraph)

# build a graph from the above matrix
g <- graph.adjacency(termMatrix, weighted = T, mode = "undirected")

# remove loops
g <- simplify(g)


# set labels and degrees of vertices
V(g)$label <- V(g)$name
V(g)$degree <- degree(g)

# plot a graph
set.seed(3535)
layout1 <- layout.fruchterman.reingold(g)
plot(g, layout=layout1)

V(g)$label.cex <- 1.2 * V(g)$degree / max(V(g)$degree) + 0.2
V(g)$label.color <- rgb(0.0, 0.0, 0.2, 0.8)
V(g)$frame.color <- NA
egam <- (log(E(g)$weight) + 0.3) / max(log(E(g)$weight) + 0.3)
E(g)$color <- rgb(0.5, 0.5, 0.0, egam)
E(g)$width <- egam

# plot the graph in layout1
plot(g, layout=layout1)