library(shiny)
source('classifier.R')
source('charts.R')
shinyServer(
  function(input, output) {
    get_survivability_chart_reactive <- reactive({get_survivability_chart(calculateSurvivability(input$Class, input$Sex, input$Age))})
    output$survivability_plot <- renderPlotly({get_survivability_chart_reactive()})
    output$welcome_text <- renderText({
      paste("Hi ", input$Name, " ", input$Surame,"! You have to pay ",format(round(getFare(input$Class), 2), nsmall = 2)," and have ",getSurvivabilityAsPercent(input$Class, input$Sex, input$Age)," chance to survive!")
      })
  }
)