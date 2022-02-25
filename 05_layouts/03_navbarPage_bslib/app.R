library(shiny)
library(bslib)

ui <- navbarPage(
  "Navbar page app",
  theme = bs_theme( # check out some themes: https://bootswatch.com/minty/
    version = 4, # alternatively, define your own theme!
    primary = '#519631',
    secondary = '#9cc653',
    accent = "#6dacde",
    base_font = font_google("Sora") # check out google fonts!
  ),
  # let's create two panels to simulate a normal distribution
  # and to simulate the central limit theorem
  tabPanel("Normal distribution", 
           sidebarLayout(
             sidebarPanel(
               h3("Simulate a normal distribution"),
               numericInput("normNumber", "number of data points (n)", value = 50, 
                            min = 10, max = 1000),
               numericInput("mean", "Mean", value = 0,
                            min = -1e8, max = 1e8),
               numericInput("sd", "Standard deviation", value = 1,
                            min = 0, max = 1e8),
               actionButton("submitNormal", "Simulate")
             ),
             mainPanel(
               plotOutput("normalDistPlot")
             )
           )
           ),
  tabPanel("Central Limit Theorem",
           sidebarLayout(
             sidebarPanel(
               numericInput("m", "Number of samples:", 2, min = 1, max = 100)
             ),
             mainPanel(
               plotOutput("hist")
             )
           )
           ),
  tabPanel("panel 3", "three"),
  navbarMenu("subpanels", 
             tabPanel("panel 4a", "four-a"),
             tabPanel("panel 4b", "four-b"),
             tabPanel("panel 4c", "four-c")
  )
)
server <- function(input, output, session) {
  # eventReactive is useful, when you only
  # want to update reactive contexts when a button is pushed
  normalData <- eventReactive(input$submitNormal, { # only executes when button is pressed
    rnorm(n = input$normNumber, mean = input$mean, sd = input$sd)
  })
  
  binomData <- eventReactive(input$submitBinom, { # only executes when button is pressed
    dbinom(x = input$binNumber, size = input$binSize, prob = input$binProb)
  })
  
  # this depends on normalData()
  # when the user doesn't press the simulate button
  # the density plot won't be displayed
  output$normalDistPlot <- renderPlot({
    plot(density(normalData()))
  }, res = 96)
  
  output$hist <- renderPlot({
    means <- replicate(1e4, mean(runif(input$m)))
    hist(means, breaks = 20)
  }, res = 96)
}

shinyApp(ui, server)