# User interface for a webapp, that looks up possible words, to use in the Major System,
# A mnemonic system for remembering numbers.
# https://en.wikipedia.org/wiki/Mnemonic_major_system

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Major System Word Search - Danish/Dansk"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
    	numericInput("number", label = "Two-digit number:", value = 00, 
    		     min = 00, max = 99, step = 1, width = NULL),
    
    	htmlOutput("code"),
    	
    	selectInput("system", label = h3("System"), 
    		    choices = list("Benjamins" = "benj", "Classic" = "clas"), 
    		    selected = 1)
    	
    	
    ),

    # Show a plot of the generated distribution
    mainPanel(
    	htmlOutput("words")
    )
  )
))
