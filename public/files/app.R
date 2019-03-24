library(shiny)

# task4: add in getDfm function for pre-processing

# task6: add in shinythemes, memoize function

ui <- fluidPage(
  titlePanel("Shakespeare's Plays Word Frequencies") # Application title
  
  # task1: add in the sidebarLayout with sidebarPanel and mainPanel
  
  # task2: add in the inputs in the sidebarPanel
  
  # task1: within the mainPanel, create two tabs (Word Cloud and Frequency)
  
  # task3: add in the outputs in the sidebarPanel
  
  # task6: and modify your counts output object height to 600px
)

server <- function(input, output) {
  
  # task5: add in reactivity for getDfm function based on inputs
  
}

shinyApp(ui = ui, server = server)
