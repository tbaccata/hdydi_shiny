library(shiny)

ui <- navbarPage(
  "Navbar page app",   
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
               numericInput("m", "Number of samples:", 1, min = 1, max = 100)
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
  normalData <- eventReactive(input$submitNormal, { # only executes when button is pressed
    rnorm(n = input$normNumber, mean = input$mean, sd = input$sd)
  })
  
  output$normalDistPlot <- renderPlot({
    plot(density(normalData()))
  }, res = 96) # res is the resolution
  
  output$hist <- renderPlot({
    means <- replicate(1e3, mean(runif(input$m))) # runif gives uniformly distr. random numbers
    # replicate will calculate 1e3 means of a uniform distribution with input$m numbers
    hist(means, breaks = 20)
  }, res = 96) # res is the resolution
}

shinyApp(ui, server)