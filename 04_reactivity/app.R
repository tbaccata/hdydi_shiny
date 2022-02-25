library(shiny)

ui <- fluidPage(
  fluidRow(
    column(width = 6,
           textInput("name", "What is your name?", placeholder = "Please enter name..."),
           sliderInput("phdAge", "Since when do you do a PhD?", 
                       min = 0, value = 0, max = 10, step = 0.5),
           h3("Greetings"),
           textOutput("greeting"),
           h3("PhD years to cat years converter"),
           textOutput("catYears")  
           ),
    column(width = 6,
           verbatimTextOutput("displayCode")
    )
  )
) 

server <- function(input, output, session) {
  output$greeting <- renderText({
    paste0("Well, hello there ", input$name, "!")
  })
  
  output$catYears <- renderText({
    catYears <- round(input$phdAge * 7, 2)
    paste0(input$phdAge, " human-years spend on PhD is equivalent to ", catYears, " cat-years.")
  })
  
  output$displayCode <- renderPrint({
    out <- 'library(shiny)

ui <- fluidPage(
        textInput("name", "What is your name?", 
        placeholder = "Please enter name..."),
           sliderInput("phdAge", "Since when do you do a PhD?", 
                       min = 0, value = 0, max = 10, step = 0.5),
           h3("Greetings"),
           textOutput("greeting"),
           h3("PhD years to cat years converter"),
           textOutput("catYears")  
)

server <- function(input, output, session) {
  output$greeting <- renderText({
    paste0("Well, hello there ", input$name, "!")
  })
  
  output$catYears <- renderText({
    catYears <- round(input$phdAge * 7, 2)
    paste0(input$phdAge, " human-years spend on PhD is equivalent to ", 
    catYears, 
    " cat-years.")
  })
}'
    cat(out)
  })
}

shinyApp(ui, server)