library(shiny)

ui <- fluidPage(
  textInput(
    inputId =  "strInput",
    label =  "Text input",
    value = ""
  ),
  helpText(
    'textInput(
    inputId =  "strInput",
    label =  "Text input",
    value = ""
  )'
  ),
  numericInput(
    inputId = "numInput",
    label = "Numeric input",
    value = 0,
    step = 1
  ),
  helpText(
    'numericInput(
    inputId = "numInput",
    label = "Numeric input",
    value = 0,
    step = 1
  )'
  ),
  sliderInput(
    inputId = "sliderInput",
    label = "Slider input",
    min = 0,
    max = 5,
    step = 1,
    value = 0
  ),
  helpText('sliderInput(
    inputId = "sliderInput",
    label = "Slider input",
    min = 0,
    max = 5,
    step = 1,
    value = 0
  )')
)

server <- function(input, output, session) {
}

shinyApp(ui, server)