library(shiny)
library(RColorBrewer)
texts<-read.csv("wordcloud_texts.csv")

textFiles <- as.character(texts$Filename)
names(textFiles)<- as.character( paste(texts$DocumentName,'-',texts$YearPublished))
colorPals <- sort(row.names(brewer.pal.info))

shinyUI(fluidPage(

  # Application title
  titlePanel("WordCloud Generator"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("text2wc", "File:",textFiles, width='600px'),
      sliderInput("maxWords","Maximum # words",5,100,50,1),
      selectInput("colorPal", "Color Palette:",c("None (Black)",colorPals), width='600px'),
      checkboxInput("doStemming","Perform Stemming",FALSE),
      p(em("Stemming means that different forms of the same word (i.e. (walk, walking), (horse, horses)) are consolidated to a single word in the word cloud")),
      actionButton("action","Generate!"),
      hr(),
      strong("Directions:"),
      p("Choose a text file to wordcloud-ize"),
      p("Set options"),
      p("Click Generate! to make wordcloud"),
      em("note that bigger texts increase generation time")

    ),

    mainPanel(
      h3(textOutput("txtSrc")),
      plotOutput("wcloud")

    )
  )
))