#http://www.r-bloggers.com/building-wordclouds-in-r/
# i should add a timer here

library(tm)
library(SnowballC)
library(wordcloud)

jeopQ <- read.csv('JEOPARDY_CSV.csv.gz', stringsAsFactors = FALSE)
# The actual questions are available in the Question column.
#
# Now, we will perform a series of operations on the text data to simplify it.
# First, we need to create a corpus.
jeopQ <- jeopQ[1:100,]
jeopCorpus <- Corpus(VectorSource(jeopQ$Question))
#jeopCorpus <- Corpus(SimpleSource(jeopQ$Question))
vc<-VectorSource(jeopQ$Question)
#Next, we will convert the corpus to a plain text document.
message("step 2")
jeopCorpus <- tm_map(jeopCorpus, PlainTextDocument)
step2<-jeopCorpus
#Then, we will remove all punctuation and stopwords. Stopwords are commonly used words in the English language such as I, me, my, etc. You can see the full list of stopwords using stopwords('english').
message("step 3")
jeopCorpus <- tm_map(jeopCorpus, removePunctuation)
jeopCorpus <- tm_map(jeopCorpus, removeWords, stopwords('english'))
#Next, we will perform stemming. This means that all the words are converted to their stem (Ex: learning -> learn, walked -> walk, etc.). This will ensure that different forms of the word are converted to the same form and plotted only once in the wordcloud.
message("step 4")
jeopCorpus <- tm_map(jeopCorpus, stemDocument)
#Now, we will plot the wordcloud.

wordcloud(jeopCorpus, max.words = 100, random.order = FALSE)