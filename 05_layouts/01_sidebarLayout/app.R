library(shiny)

ui <- fluidPage(
  titlePanel("Simulate a normal distribution"),
  sidebarLayout(
    sidebarPanel(
      h3("Simulate a normal distribution"),
      numericInput("number", "number of data points (n)", value = 50, 
                   min = 10, max = 1000),
      numericInput("mean", "Mean", value = 0,
                   min = -1e8, max = 1e8),
      numericInput("sd", "Standard deviation", value = 1,
                   min = 0, max = 1e8),
      actionButton("submit", "Simulate")
      ),
    mainPanel(
      plotOutput("normalDistPlot")
    )
  )
)

server <- function(input, output, session) {
  # eventReactive is useful, when you only
  # want to update reactive contexts when a button is pushed
  normalData <- eventReactive(input$submit, { # only executes when button is pressed
    rnorm(n = input$number, mean = input$mean, sd = input$sd)
  })
  # this depends on normalData()
  # when the user doesn't press the simulate button
  # the density plot won't be displayed
  output$normalDistPlot <- renderPlot({
    plot(density(normalData()))
  })
}

shinyApp(ui, server)




