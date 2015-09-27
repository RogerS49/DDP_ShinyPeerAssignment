library(shiny)
library(TTR)
tr <- window(treering, start=1700)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Currently selected dataset
  curdata <- reactive({
    switch(input$dataset, LakeHuron=LakeHuron, Nile=Nile, 
           TreeRing=tr,NewHampshireTemp=nhtemp)
  })
  
  output$plotsunspot <- renderUI({
    plotOutput("plot",height=300) })
  
  output$plot <- renderPlot({
       if( input$sma == 0)
        plot(sunspot.year)
       else {
         switch(input$dataset,
                Nile = ,
                LakeHuron = 
                  plot(SMA(window(sunspot.year,start=1860),n=input$sma),ylab="sunspot.year"),
                TreeRing = 
                   plot(SMA(sunspot.year, n=input$sma),ylab="sunspot.year"),
                NewHampshireTemp =
                  plot(SMA(window(sunspot.year,start=1900),n=input$sma),ylab="sunspot.year")
         )
       }
  })
  
  output$plotselected <- renderUI({
    plotOutput("comp",height=300)})
  
  output$comp <- renderPlot({
    if ( input$sma == 0)
       plot(curdata(), ylab=as.character(input$dataset))
    else
      plot(SMA(curdata(),n=input$sma), ylab=as.character(input$dataset))
    
  })
})