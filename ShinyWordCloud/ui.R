library(shiny)

texts<-read.csv("wordcloud_texts.csv")

textFiles <- as.character(texts$Filename)
names(textFiles)<- as.character( paste(texts$DocumentName,'-',texts$YearPublished))


shinyUI(fluidPage(

  # Application title
  titlePanel("WordCloud Generator"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("text2wc", "File:",textFiles, width='600px'),
      actionButton("action","Generate!")
 #     selectInput()
    ),

    mainPanel(
      h3(textOutput("txtSrc")),
      h4(textOutput("txtUrl")),
      h4(textOutput("txtYear")),
      h4(textOutput("txtSize")),
      plotOutput("wcloud")

    )
  )
))