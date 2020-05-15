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
        saraly2014 <- read.csv("cscsalary2014.csv")
        saraly2015 <- read.csv("cscsalary2015.csv")
        saraly2016 <- read.csv("cscsalary2016.csv")
        saraly2017 <- read.csv("cscsalary2017.csv")
        saraly2018 <- read.csv("cscsalary2018.csv")
        colnames(salary2014)[1] <- "Major"
        colnames(salary2015)[1] <- "Major"
        colnames(salary2016)[1] <- "Major"
        colnames(salary2017)[1] <- "Major"
        colnames(salary2018)[1] <- "Major"
        salary2014$WageGap <- (salary2014$Male - salary2014$Female)
        salary2015$WageGap <- (salary2015$Male - salary2015$Female)
        salary2016$WageGap <- (salary2016$Male - salary2016$Female)
        salary2017$WageGap <- (salary2017$Male - salary2017$Female)
        salary2018$WageGap <- (salary2018$Male - salary2018$Female)
        
    })
}


shinyApp(ui = ui, server = server)
