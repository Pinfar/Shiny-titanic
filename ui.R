library(shiny)
shinyUI(fluidPage(
  titlePanel("Titanic"),
  sidebarLayout(
    sidebarPanel(
      h3('Buy a ticket!'),
      h4('Enter your data:'),
      textInput("Name", label="Name", placeholder = "Name"),
      textInput("Surame", label="Surame", placeholder = "Surame"),
      selectInput("Sex", label="Sex", choices = c("male", "female"), selected = "male"),
      sliderInput("Age", "Age", 0, 120, 25, step=1),
      sliderInput("Class", "Class", 1,3,1,step=1)
    ),
    mainPanel(
      plotlyOutput("survivability_plot"),
      textOutput("welcome_text"),
      tags$head(tags$style(type="text/css", "#survivability_plot {  max-width: 800px;}"))
    )
  )
))