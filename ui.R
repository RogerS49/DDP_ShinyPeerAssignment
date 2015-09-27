library(shiny)
library(markdown)
shinyUI(fluidPage(
  tags$head(
    tags$style(HTML("
                    /* Smaller font for preformatted text */
                    pre, table.table {
                    font-size: smaller;
                    }
                    body {
                    min-height: 2000px;
                    }
                    .option-group {
                    border: 1px solid #ccc;
                    border-radius: 6px;
                    padding: 0px 5px;
                    margin: 5px -10px;
                    background-color: #f5f5f5;
                    }
                    .option-header {
                    color: #79d;
                    text-transform: uppercase;
                    margin-bottom: 5px;
                    }
                    "))
    ),
  
  # Application title
  titlePanel("DDP Assignment"),
  
  fluidRow(
    column(width=3,
           div(class = "option-group",
               radioButtons("dataset", "Data set",
                            choices = c("LakeHuron", "Nile", "TreeRing","NewHampshireTemp"), inline = FALSE)
           )
    ),
    column(width=3,
           div(class = "option-group",
               sliderInput("sma",
                           "Moving Average:",
                           min = 0,
                           max = 30,
                           value = 0 )
           )
    )
           
  ),
  fluidRow(
    column(width = 6,
           uiOutput("plotsunspot")
    ),
    column(width = 6,
           uiOutput("plotselected")
    )
    
  ),
  

    # Show a plot of the generated distribution
    fluidRow(
      column(width=10,
        tabsetPanel(
         tabPanel(p("Description"),
                  mainPanel(
                            p("The point of this Shiny App is to compare different 
                               annual time series data with yearly sun spot data 1700  
                               to 1988, in order to see if there exists any similar trend"),
                            p("The data sets chosen are :-"),
                            tags$ul(
                              tags$li("LakeHuron; Water level of Lake 1875 to 1972"), 
                              tags$li("Nile; Water flow of Nile 1871 to 1970"), 
                              tags$li("Tree Rings; Tree ring growth 1700 to 1979"),
                              tags$li("New Hampshire Temps; Average temps 1912 to 1971"))
                            ),
                            p("As these are all time series we use a smoothing function to
                              reliase any trends inherent in the data. We use SMA. "),
                            p("SMA calculates the arithmetic mean of the series over the 
                              past n observations."),
                            p("The Moving Average Slider value is applied to both plots simultaneously
                              giving a smoothed curve allowing any trend to be identified")
                  ),
         tabPanel("Explanation",
                  mainPanel(
                    p("It is thought the effects of sunspots is to lower the temperature of the 
                      surface of the Sun."),
                    p("Therefore you might expect tree growth rings to be smaller with more sunspots"),
                    p("The level of the lake to be higher with more sunspots"),
                    p("The flow of the Nile to be greater with more sunspots. The flow is also 
                      disrupted because of the dams along it's length"),
                    p("The average yearly temperature in New Hampshire to drop with more Sunspots")
                  )),
         tabPanel("About",
                  mainPanel(includeMarkdown("about.md")))
         
      ))
    )
  
))