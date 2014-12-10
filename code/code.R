# This project will analyse data available for public download from the Open Data Malta website.
# The dataset being analysed deals with a breakdown of tourist expenditure for the year 2012.

library(reshape2)
url = "http://www.opendatamalta.org/ckan/dataset/50cfd96f-246e-4d57-a0ce-86c8ce88e9d6/resource/fad12a26-2965-404f-9320-c0bc82353315/download/Profileofdepartingtourists2012.csv"
file = "../data/tourists2012.csv"
rData = "../data/tourists2012.Rdata"

if (file.exists(rData)) {
    load(rData)
    paste0("The data was downloaded on ", downloadDt)
    ans <- readline("Delete this data and download again from Open Data Malta website? [Y - to clear] ") 
    if (tolower(ans) == "y") {
        file.remove(rData)
    }
    rm (ans, downloadDt, data)
}

if (!file.exists(rData)) {
    download.file(url, destfile = file)
    downloadDt <- format(Sys.Date(), format = "%d %B %Y")

    ## Clean the data
    data <- read.csv(file, strip.white=TRUE,blank.lines.skip=TRUE, na.strings=c("", "NA"))
    
    data <- data[complete.cases(data),]  # keep only complete entries
    
    # remove the data is not needed for this analysis
    data <- data[c(4:9),]
    
    dataM <- melt(data, id.vars = c("X"))
    
    rm(data)
    
    # split the data sets
    dataSex <- subset(dataM, X == "Males" | X == "Females")
    colnames(dataSex) <- c("Sex", "Month", "Tourists")
    dataSex$Sex <- as.factor(dataSex$Sex)
    
    dataAgeG <- subset(dataM, X != "Males" & X != "Females")
    colnames(dataAgeG) <- c("AgeG", "Month", "Tourists")
    dataAgeG$AgeG <- as.factor(dataAgeG$AgeG)
    
    save(dataSex, dataAgeG, downloadDt, file=rData)
}