library(shiny)
library(ggplot2)
library(scales)
rData = "tourists2012.Rdata"
load(rData)

shinyServer(
    function(input, output) {
        output$meanTourist <- renderPrint(mean(dataSex$Tourists)*2)
        output$plotOutput <- renderPlot({
            if (input$choice == "S") {
                
                ag <- aggregate(Tourists ~ Sex, dataSex, function(x) c(Mean = mean(x), Std.Dev=sd(x)))
                colnames(ag)[2] <- ""  # Clear out the word Tourist
                output$aggTourist <- renderPrint(ag)
                
                if (input$type == "Stacked Bar") {
                    g <- ggplot(dataSex, aes(x=Month, y=Tourists, fill=Sex)) + 
                        geom_bar(stat="identity") +
                        theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
                        ggtitle("Tourist in Malta by Sex") + 
                        xlab("2012") + 
                        ylab("Euro")
                } else if (input$type == "Bar") {
                        g <- ggplot(dataSex, aes(x=Month, y=Tourists, fill=Sex)) + 
                            geom_bar(stat="identity", position=position_dodge()) +
                            theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
                            ggtitle("Tourist in Malta by Sex") + 
                            xlab("2012") + 
                            ylab("Euro")
                    } else {
                        g <- ggplot(dataSex, aes(factor(Sex), Tourists)) +
                        geom_boxplot() + 
                        ggtitle("Tourist in Malta by Sex") + 
                        xlab("2012") +
                        scale_y_continuous(name="Euro", labels = comma)
                }
            } else if (input$choice == "A") {

                ag <- aggregate(Tourists ~ AgeG, dataAgeG, function(x) c(Mean = mean(x), Std.Dev=sd(x)))
                colnames(ag)[2] <- ""  # Clear out the word Tourist
                output$aggTourist <- renderPrint(ag)
                
                if (input$type == "Stacked Bar") {
                    g <- ggplot(dataAgeG, aes(y=Tourists, x=Month, fill=AgeG)) + 
                        geom_bar(stat="identity") +
                        theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
                        ggtitle("Tourist in Malta by Age Group") + 
                        xlab("2012") + 
                        ylab("Euro")
                } else if (input$type == "Bar") {
                    g <- ggplot(dataAgeG, aes(y=Tourists, x=Month, fill=AgeG)) + 
                        geom_bar(stat="identity", position=position_dodge()) +
                        theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
                        ggtitle("Tourist in Malta by Age Group") + 
                        xlab("2012") + 
                        ylab("Euro")
                } else {
                    g <- ggplot(dataAgeG, aes(factor(AgeG), Tourists)) +
                        geom_boxplot() + 
                        ggtitle("Tourist in Malta by Age Group") + 
                        xlab("2012") +
                        scale_y_continuous(name="Euro", labels = comma)
                }
            }
            else {
                
                ag <- aggregate(Tourists ~ Route, dataRoute, function(x) c(Mean = mean(x), Std.Dev=sd(x)))
                colnames(ag)[2] <- ""  # Clear out the word Tourist
                output$aggTourist <- renderPrint(ag)
                
                if (input$type == "Stacked Bar") {
                    g <- ggplot(dataRoute, aes(y=Tourists, x=Month, fill=Route)) + 
                        geom_bar(stat="identity") +
                        theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
                        ggtitle("Tourist in Malta by Travel Route") + 
                        xlab("2012") + 
                        ylab("Euro")
                } else if (input$type == "Bar") {
                    g <- ggplot(dataRoute, aes(y=Tourists, x=Month, fill=Route)) + 
                        geom_bar(stat="identity", position=position_dodge()) +
                        theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
                        ggtitle("Tourist in Malta by Travel Route") + 
                        xlab("2012") + 
                        ylab("Euro")
                } else {
                    g <- ggplot(dataRoute, aes(factor(Route), Tourists)) +
                        geom_boxplot() + 
                        ggtitle("Tourist in Malta by Travel Route") + 
                        xlab("2012") +
                        scale_y_continuous(name="Euro", labels = comma)
                }
            }
            g
        })
    }
)
