library(shiny)
shinyServer(
    function(input, output) {
        output$oid1 <- renderPrint({input$id1})
    }    
    )