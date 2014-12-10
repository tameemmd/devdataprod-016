library(shiny)
library(ggplot2)
rData = "../data/tourists2012.Rdata"
load(rData)

shinyServer(
    function(input, output) {
        output$plotOutput <- renderPlot({
            if (input$choice == "S") {
                g <- ggplot(dataSex, aes(y=Tourists, x=Month, fill=Sex)) + geom_bar(stat="identity")
                g <- g + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
                    ggtitle("Tourist Expenditure\nin Malta by Sex") + xlab("2012") + ylab("Euro")
            } else {
                g <- ggplot(dataAgeG, aes(y=Tourists, x=Month, fill=AgeG)) + geom_bar(stat="identity")
                g <- g + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
                    ggtitle("Tourist Expenditure\nin Malta by Age Group") + xlab("2012") + ylab("Euro")
            }
            g
        })
}
)