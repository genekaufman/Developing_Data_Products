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
      selectInput("text2wc", "File:",textFiles, width='600px')
 #     selectInput()
    ),

    mainPanel(
      h3(textOutput("caption")),
      plotOutput("wcloud"),
      h4(textOutput("statusMessage"))

    )
  )
))