
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

words <- readLines("danske_ord.txt", encoding = "UTF-8")

major_sys <- list(benj = c("0" = "d|ø",
	       "1" = "l|i",
	       "2" = "t|o",
	       "3" = "r|e",
	       "4" = "f|u",
	       "5" = "m|æ",
	       "6" = "s|y",
	       "7" = "v|a",
	       "8" = "b|å",
	       "9" = "n|ei|ai"),
		 clas = c("0" = "s|z",
		    "1" = "t|d",
		    "2" = "n",
		    "3" = "m",
		    "4" = "r",
		    "5" = "l",
		    "6" = "j|g",
		    "7" = "k|c",
		    "8" = "f|v",
		    "9" = "b|p"))

text_code <- c(clas = "0 = S / Z<br />
			1 = T OR D<br />
			2 = N<br />
			3 = M<br />
			4 = R<br />
			5 = L<br />
			6 = J / G<br />
			7 = K / C<br />
			8 = F / V<br />
			9 = B / P",
		benj = "0 = D / Ø<br />
    	     1 = L / I<br />
    	     2 = T / O<br />
    	     3 = R / E<br />
    	     4 = F / U<br />
    	     5 = M / Æ<br />
    	     6 = S / Y<br />
    	     7 = V / A<br />
    	     8 = B / Å<br />
    	     9 = N / EI / AI")

vowels <- "aei"


major_words <- function(n, n_words = length(elig_words), system) {
	if(n <= 99) {
		n_str <- strsplit(sprintf("%02d", n), "")[[1]]
		search_string <- ifelse(system == "benj", yes = "^(%s)(%s)", no = "^(%s)[aeiouyæøå]?(%s)")
		elig_words <- grep(sprintf(search_string, major_sys[[system]][n_str][1], 
					   major_sys[[system]][n_str][2]), 
				   words, value = TRUE)
		elig_words <- unique(elig_words)
		paste(elig_words[order(nchar(elig_words))][1:n_words],
		      collapse = "<br/>")
	}
}

library(shiny)

shinyServer(function(input, output) {
	
	output$code <- renderText(text_code[input$system])	

  output$words <- renderText({
  	if (!(input$number %in% 0:99)) stop("You must submit a number between 0 and 99")
	else major_words(input$number, system = input$system)
  	

  })

})
