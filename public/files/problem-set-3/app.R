library(shiny)

ui <- fluidPage(
  titlePanel("Shakespeare's Plays Word Frequencies") # Application title
  
  # task1: add in the sidebarLayout with sidebarPanel and mainPanel
  
  # task2: add in the inputs in the sidebarPanel
  
  # task1: within the mainPanel, create two tabs (Word Cloud and Frequency)
  
  # task2: add in the outputs in the sidebarPanel
)

server <- function(input, output) {
}

shinyApp(ui = ui, server = server)
