######################################## 
# CSC 275 Final Project Shiny App Code #
########## Miruna Baciu ################
########################################

library(shiny)

# This defines the UI
ui <- fluidPage(
    
    titlePanel("Evolution of the Wage Gap According to Major from 2014-2018"),
    
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = "major", label = "Academic Major",
                        choices = unique(salary2014$major), 
                        selected = NULL, multiple = TRUE)
        ),

        mainPanel(
           plotOutput(outputId = "wageGapPlot")
        )
    )
)

server <- function(input, output) {

    output$wageGapPlot <- renderPlot({
       # code for creating the plot
    })
}


shinyApp(ui = ui, server = server)
