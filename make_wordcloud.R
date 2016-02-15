#http://www.r-bloggers.com/building-wordclouds-in-r/

# # alice = http://www.gutenberg.org/cache/epub/11/pg11.txt
# file.alice <- "alice.txt.gz"
# # declaration = http://www.gutenberg.org/cache/epub/1/pg1.txt
 file.declaration <- "declaration.txt.gz"
# # constitution = http://www.gutenberg.org/cache/epub/5/pg5.txt
# file.constitution <- "constitution.txt.gz"
# # mayflower = http://www.gutenberg.org/cache/epub/7/pg7.txt
 file.mayflower <- "mayflower.txt.gz"
# # hamlet = http://www.gutenberg.org/cache/epub/1787/pg1787.txt
# file.hamlet <- "hamlet.txt.gz"
# # greatexpectations = http://www.gutenberg.org/cache/epub/1400/pg1400.txt
# file.greatexpectations <- "greatexpectations.txt.gz"
# # modest = http://www.gutenberg.org/cache/epub/1080/pg1080.txt
# file.modest <- "modest.txt.gz"
# # moby = http://www.gutenberg.org/cache/epub/2701/pg2701.txt
# file.moby <- "moby.txt.gz"
# # pride = http://www.gutenberg.org/cache/epub/1342/pg1342.txt
# file.pride <- "pride.txt.gz"

texts<-read.csv("wordcloud_texts.csv")

cc<- c("Cylinders" = "cyl",
       "Transmission" = "am",
       "Gears" = "gear")
textLabels <- subset(texts,select=c(DocumentName,Filename))
textFiles <- as.character(texts$Filename)
names(textFiles)<- as.character( paste(texts$DocumentName,'-',texts$YearPublished))

makeWordCloud <- function(fname) {

  library(tm)
  library(SnowballC)
  library(wordcloud)

  thisFile <- paste0("texts/",fname)

  thisText <- readLines(thisFile,skipNul = TRUE)
  wcCorpus <- Corpus(VectorSource(thisText))

  #Next, we will convert the corpus to a plain text document.
  wcCorpus <- tm_map(wcCorpus, PlainTextDocument)

  #Then, we will remove all punctuation and stopwords. Stopwords are commonly used words in the English language such as I, me, my, etc. You can see the full list of stopwords using stopwords('english').
  wcCorpus <- tm_map(wcCorpus, removePunctuation)
  wcCorpus <- tm_map(wcCorpus, removeWords, stopwords('english'))

  #Next, we will perform stemming. This means that all the words are converted to their stem (Ex: learning -> learn, walked -> walk, etc.). This will ensure that different forms of the word are converted to the same form and plotted only once in the wordcloud.
  wcCorpus <- tm_map(wcCorpus, stemDocument)
  #Now, we will plot the wordcloud.

  wordcloud(wcCorpus, max.words = 100, random.order = FALSE)
  #wc
}
start.time <- Sys.time()
makeWordCloud(file.declaration)
end.time <- Sys.time()
time.taken <- paste( as.numeric(round(end.time - start.time,3)*1000), "milliseconds")
time.taken
#mm