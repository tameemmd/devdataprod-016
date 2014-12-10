# This project will analyse data available for public download from the Open Data Malta website.
# The dataset being analysed deals with a breakdown of tourist expenditure for the year 2012.

library(reshape2)

loadData <- function() {
    url = "http://www.opendatamalta.org/ckan/dataset/50cfd96f-246e-4d57-a0ce-86c8ce88e9d6/resource/fad12a26-2965-404f-9320-c0bc82353315/download/Profileofdepartingtourists2012.csv"
    file = "../data/tourists2012.csv"
    rData = "../shiny/tourists2012.Rdata"
    
    if (file.exists(rData)) {
        load(rData)
        cat(paste0("The data was downloaded on ", downloadDt))
        ans <- readline("Delete this data and download again from Open Data Malta website? [Y - to clear] ") 
        if (tolower(ans) == "y") {
            file.remove(rData)
        }
        rm (ans)
    }
    
    if (!file.exists(rData)) {
        download.file(url, destfile = file)
        downloadDt <- format(Sys.Date(), format = "%d %B %Y")
        
        ## Clean the data
        data <- read.csv(file, strip.white=TRUE,blank.lines.skip=TRUE, na.strings=c("", "NA"))
        
        data <- data[complete.cases(data),]  # keep only complete entries
        
        # remove the data is not needed for this analysis
        data <- data[c(2:9),]
        
        dataM <- melt(data, id.vars = c("X"))
        
        # split the data sets (Sex)
        dataSex <- subset(dataM, X == "Males" | X == "Females")
        colnames(dataSex) <- c("Sex", "Month", "Tourists")
        # clear existing factor information and refactorize
        dataSex$Sex <- as.factor(as.character(dataSex$Sex))
        dataSex$Tourists <- as.numeric(gsub(",","", dataSex$Tourists))
     
        # split the data sets (Travel Route)
        dataRoute <- subset(dataM, X == "Air" | X == "Sea")
        colnames(dataRoute) <- c("Route", "Month", "Tourists")
        # clear existing factor information and refactorize
        dataRoute$Route <- as.factor(as.character(dataRoute$Route))
        dataRoute$Tourists <- as.numeric(gsub(",","", dataRoute$Tourists))
        
        # split the data sets (Age Group)
        dataAgeG <- subset(dataM, X == "0-24" | X == "25-44" | X == "45-64" | X == "65+")
        colnames(dataAgeG) <- c("AgeG", "Month", "Tourists")
        # clear existing factor information and refactorize
        dataAgeG$AgeG <- as.factor(as.character(dataAgeG$AgeG))
        dataAgeG$Tourists <- as.numeric(gsub(",","", dataAgeG$Tourists))
        
        save(dataSex, dataAgeG, dataRoute, downloadDt, file=rData)
        
    }
    
    return (list(dataSex = dataSex, dataRoute = dataRoute, dataAgeG = dataAgeG))
}

data <- loadData()
dataSex <- data$dataSex
dataRoute <- data$dataRoute
dataAgeG <- data$dataAgeG
rm(data)

summary(dataSex)
library(scales)
## by Sex
g <- ggplot(dataSex, aes(y=Tourists, x=Month, fill=Sex)) + geom_bar(stat="identity")
g <- g + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
    ggtitle("Tourist Expenditure\nin Malta by Sex") + xlab("2012") + ylab("Euro")
g
    


g <- ggplot(dataSex, aes(factor(Sex), Tourists)) 
g + geom_boxplot() + ggtitle("Tourist Expenditure\nin Malta by Sex") + xlab("2012") +
    scale_y_continuous(name="Euro", labels = comma)
           
### by Agegroup
g <- ggplot(dataAgeG, aes(y=Tourists, x=Month, fill=AgeG)) + geom_bar(stat="identity")
g <- g + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
    ggtitle("Tourist Expenditure\nin Malta by Age Group") + xlab("2012") + ylab("Euro")
g

    