library(shiny)

texts<-read.csv("wordcloud_texts.csv")
textFiles <- as.character(texts$Filename)

shinyServer(function(input, output) {

  output$txtSrc <- renderText({as.character(texts[which(texts$Filename==input$text2wc),1])})
#   hold4now <- reactive(
#     fullText <- as.character(texts[which(texts$Filename==input$text2wc),1])
#   )

    output$wcloud <- renderPlot({
    if (input$action > 0) {
      input$action
      isolate(makeWordCloud(input$text2wc,
                          maxwords = input$maxWords,
                          stemming = input$doStemming,
                          cPal = input$colorPal))
    }
  })

})

makeWordCloud <- function(fname,maxwords=100,stemming=FALSE,cPal=NULL) {
  ## Implement wordcloud method described in
  ## http://www.r-bloggers.com/building-wordclouds-in-r/

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
  if (stemming) {
    wcCorpus <- tm_map(wcCorpus, stemDocument)
  }
  #Now, we will plot the wordcloud.

  if (cPal != "None (Black)") {
    pal <- brewer.pal(8,cPal)
    pal <- pal[-(1)]
  } else {
    pal <- NULL
  }
  wordcloud(wcCorpus, max.words = maxwords, random.order = FALSE, colors=pal)
}
