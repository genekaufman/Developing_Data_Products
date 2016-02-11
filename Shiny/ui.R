library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("hp"),
  sidebarPanel(
    h1('sp'),
    h1('11'),
    h2('22'),
    h3('33'),
    h4('44')
  ),
  mainPanel(
    h3('mp text'),
    code('smoething'),
    p('here is a p')
  )
)
)