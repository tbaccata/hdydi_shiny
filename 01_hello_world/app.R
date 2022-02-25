library(shiny)

ui <- fluidPage(
  h1("h1 Header"), # HTML header
  h2("h2 Header"), # HTML header
  h3("h3 Header"), # HTML header
  h4("h4 Header"), # HTML header
  h5("h5 Header"), # HTML header
  h6("h6 Header"), # HTML header
  p("This is a HTML paragraph."), # HTML paragraph
  em("This text is in italics."), # HTML italics
  p("Hello world!")
)

server <- function(input, output, session) {
}

shinyApp(ui, server)