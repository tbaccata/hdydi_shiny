library(shiny)

ui <- fluidPage(
  fluidRow(
    column(4,
           tableOutput("tblOutput"),
           ),
    column(4,
           textOutput("strOutput"),
    ),
    column(4,
           plotOutput("pltOutput")
    )
  )
)

server <- function(input, output, session) {
  output$strOutput <- renderText({"I am a text send from the server."})
  output$tblOutput <- renderTable({head(iris)}) # iris is default loaded data
  output$pltOutput <- renderPlot({plot(iris$Sepal.Length, iris$Sepal.Width)})
}

shinyApp(ui, server)