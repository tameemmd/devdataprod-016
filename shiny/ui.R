library(markdown)
shinyUI(fluidPage(
    
    titlePanel("Maltese Tourist Analysis for 2012"),
    
    fluidRow(
        column(2,
               radioButtons("choice", "Analyse by:",
                            c("Sex" = "S", "Age Group" = "A", "Travel Route" = "T"), "S"),
               br(),
               selectInput('type', 'Chart type:', c("Stacked Bar", "Bar", "Box Plot"))
        ),
        column(8,
               plotOutput('plotOutput'),
               br(),
               p('The average number of tourists per month was '),
               verbatimTextOutput("meanTourist")
        )),

    hr(),
    
    fluidRow(
        column(8, offset = 2,
               includeMarkdown("intro.md")
        )
    ),
    
    hr()
))
