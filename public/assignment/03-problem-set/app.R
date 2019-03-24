library(shiny)
library(quanteda)
library(wordcloud)
library(memoise)
library(ggplot2)
library(RColorBrewer)

# The list of valid books
books <- list("A Mid Summer Night's Dream" = "summer",
               "The Merchant of Venice" = "merchant",
               "Romeo and Juliet" = "romeo")

# Using "memoise" to automatically cache the results
getDfm <- memoise(function(book, minterms, stem, punct, ngrams) {
  # check that only one of three books is selected
  if (!(book %in% books))
    stop("Unknown book")
  
  text <- readLines(sprintf("./%s.txt", book), encoding="UTF-8")
  
  # could also pass column of text/character instead
  myCorpus <- corpus(text)
  
  # if... else if statement depending on 
  if(ngrams == "unigram"){
    ng = 1
  }else if(ngrams == "both"){
    ng = 1:2
  }else if(ngrams == "bigram"){
    ng = 2
  }
  
  dfm(myCorpus, remove = stopwords('english'), remove_punct = punct, stem = stem, ngrams = ng) %>%
    dfm_trim(min_termfreq = minterms, verbose = FALSE)
})

ui <- fluidPage(
  titlePanel("Shakespeare's Plays Word Frequencies"), # Application title
  
  sidebarLayout(
    # Sidebar with a slider and selection inputs
    sidebarPanel(
      selectInput("selection", "Choose a book:",
                  choices = books),
      checkboxInput("stem", "Stem words:", value = FALSE),
      checkboxInput("punct", "Remove punctuation:", value = TRUE),
      radioButtons("ngram", "Choice in n-grams:", 
                   choices = c("Unigrams only" = "unigram",
                               "Unigrams & Bigrams" = "both",
                               "Bigrams only" = "bigram")),
      sliderInput("freq", "Minimum Frequency:",
                  min = 1,  max = 50, value = 10),
      hr(), # add in a line
      actionButton("update", "Rerun")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Word Cloud", plotOutput("plot")), # show word cloud
        tabPanel("Counts", plotOutput("freq")) # show frequency plot
      )
    )
  )
)

server <- function(input, output) {
  # Define a reactive expression for the document term matrix
  dfm <- reactive({
    # Change when the "update" button is pressed...
    input$update
    isolate({ # ...but not for anything else
      withProgress({
        setProgress(message = "Processing corpus...")
        getDfm(input$selection, input$freq, input$stem, input$punct, input$ngram)
      })
    })
  })
  
  # Make the wordcloud drawing same since includes random number
  wordcloud_rep <- repeatable(textplot_wordcloud)
  
  output$plot <- renderPlot({
    v <- dfm()
    wordcloud_rep(v, min_size=0.5, max_size=6, max_words=100, color=brewer.pal(8, "Dark2"))
  })
  
  output$freq <- renderPlot({
    v <- dfm()
    dfm_freq <- textstat_frequency(v, n = 50)
    dfm_freq$feature <- with(dfm_freq, reorder(feature, frequency)) # sort in descending
    
    ggplot(dfm_freq, aes(x = feature, y = frequency)) +
      geom_point() + 
      coord_flip() + # flip coords
      theme(text = element_text(size = 18)) # enlarge font to 18 for entire lot
  })
}

shinyApp(ui = ui, server = server)
