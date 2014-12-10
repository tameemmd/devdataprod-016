library(markdown)
shinyUI(fluidPage(
    
    titlePanel("Tourist expenditure for the year 2012 in Malta"),
    
    fluidRow(
        column(2,
               radioButtons("choice", "Analyse by:",
                            c("Sex" = "S", "Age Group" = "A", "Travel Route" = "T"), "S"),
               br(),
               selectInput('type', 'Chart type:', c("Bar", "Box Plot"))
        ),
        column(8,
               plotOutput('plotOutput')
        )),

    hr(),
    
    fluidRow(
        column(8, offset = 2,
               includeMarkdown("intro.html")
        )
    ),
    
    hr()
))
