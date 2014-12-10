library(markdown)
shinyUI(fluidPage(
    
    titlePanel("Tourist expenditure for the year 2012 in Malta"),
    
    fluidRow(
        column(2,
               radioButtons("id1", "Analyse by",
                            c("Sex" = "1",
                            "Age Group" = "2")
         )),
        column(8,
               h4('You entered'),
               verbatimTextOutput("oid1")
        )),

    hr(),
    
    fluidRow(
        column(8, offset = 2,
               includeMarkdown("intro.Rmd")
        )
    ),
    
    hr()
))
