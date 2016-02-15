#http://shiny.rstudio.com/tutorial/lesson1/
# UGGGGGHHHHHH http://shiny.rstudio.com/gallery/word-cloud.html
#
library(shiny)
# library(tm)
# library(SnowballC)
# library(wordcloud)


shinyServer(function(input, output) {

  globTime<-"please wait"
  waitMessage<-"please wait"


    output$caption <- renderText({
    input$text2wc
  })

  output$wcloud <- renderPlot({
    thisTime<-timeWordCloud(input$text2wc,FALSE)
    globTime<<-thisTime
  })

  output$statusMessage <-  renderText({paste("Generation time:",globTime
  )})

})

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
  #wcCorpus <- tm_map(wcCorpus, stemDocument)
  #Now, we will plot the wordcloud.

  wordcloud(wcCorpus, max.words = 100, random.order = FALSE)
  #wc
}

timeWordCloud<-function(fname,useMS) {
  start.time <- Sys.time()
  makeWordCloud(fname)
  end.time <- Sys.time()
  elapsedTime <- end.time - start.time
  if (useMS) {
    time.taken <- paste( as.numeric(round(elapsedTime,3)*1000), "milliseconds")
  } else {
    time.taken <- paste( as.numeric(round(elapsedTime,3)), "seconds")
  }
  time.taken
}