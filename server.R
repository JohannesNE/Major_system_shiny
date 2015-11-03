
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

words <- readLines("danske_ord.txt")

major_sys <- c("0" = "s|z",
	       "1" = "t|d",
	       "2" = "n",
	       "3" = "m",
	       "4" = "r",
	       "5" = "l",
	       "6" = "j|g",
	       "7" = "k|c",
	       "8" = "f|v",
	       "9" = "b|p")

major_words <- function(n, n_words = length(elig_words)) {
	if(n <= 99) {
		n_str <- strsplit(sprintf("%02d", n), "")[[1]]
		elig_words <- grep(sprintf("^(%s).(%s)", major_sys[n_str][1], major_sys[n_str][2]), 
				   words, value = TRUE)
		elig_words <- unique(elig_words)
		paste(elig_words[order(nchar(elig_words))][1:n_words],
		      collapse = "<br/>")
	}
}

library(shiny)

shinyServer(function(input, output) {

  output$words <- renderText({
  	if (!(input$number %in% 0:99)) stop("You must submit a number between 0 and 99")
	else major_words(input$number)
  	

  })

})
