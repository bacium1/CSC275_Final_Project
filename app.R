### CSC 275 Final Project ### 
####### Miruna Baciu ########

library(dplyr)
library(lubridate)
library(ggplot2)
library(shiny)

listings <- read.csv("listings.csv")
lt_listing <- listings %>%
   filter(minimum_nights >= 14)
min_price <- min(lt_listing$price)
max_price <- max(lt_listing$price)

ui <- fluidPage(
    # Application title
    titlePanel("Most Reviewed Long-Term Paris Airbnbs"),
    
    sidebarLayout(
        sidebarPanel(
            sliderInput("range",
                        "Airbnb Price",
                        min = min_price,
                        max = max_price,
                        step = 10,
                        value = c(10,100))
        ),
        mainPanel(
            plotOutput("revPlot")
        )
    )
)


server <- function(input, output) {
    
    output$revPlot <- renderPlot({
        top_reviews <- lt_listing %>%
            filter(#price >= input$range[1] &
                       price <= input$range[1]) %>%
            group_by(name) %>%
            summarize(max_review=max(number_of_reviews)) %>%
            arrange(desc(max_review)) %>%
            head(10) %>%
            ungroup()
        joined_reviews <- inner_join(lt_listing, top_reviews, by="name")
        ggplot(joined_reviews, aes(x=name, y=number_of_reviews, fill=neighbourhood)) + 
            geom_bar(stat="identity") +
            theme(axis.text.x=element_text(angle=40, hjust=1)) +
            labs(x="Name of Airbnb", y="Number of Reviews", fill="Name of Neighborhood")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
