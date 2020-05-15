### CSC 275 Final Project ### 
####### Miruna Baciu ########

library(dplyr)
library(lubridate)
library(ggplot2)
library(shiny)

# This imports the data 
listings <- read.csv("listings.csv")
# Filters the listings so only ones that have a minimum night 
# requirement greater than 14 are used. This is so airbnbs that
# are typically used for long-term stays are the only ones inlcuded
lt_listing <- listings %>%
   filter(minimum_nights >= 14)
min_price <- min(lt_listing$price) # Finds minimum price
max_price <- max(lt_listing$price) # Finds maximum price

ui <- fluidPage(
    # Application title
    titlePanel("Most Reviewed Long-Term Paris Airbnbs"),
    # Makes the range slider 
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
            filter(price >= input$range[1] &        # Filters so that only listings with prices 
                       price <= input$range[2]) %>% # in the inputed range are included
            group_by(name) %>%
            summarize(max_review=max(number_of_reviews)) %>% # Gets the most reviewed listings
            arrange(desc(max_review)) %>% # Arranges them in descending order
            head(15) %>% # Get's the top 10 for each price range
            ungroup()
        joined_reviews <- inner_join(lt_listing, top_reviews, by="name") 
        # Joins the table so that the neighbourhood is included
        ggplot(joined_reviews, aes(x=name, y=number_of_reviews, fill=neighbourhood)) + 
            geom_bar(stat="identity") +
            theme(axis.text.x=element_text(angle=50, hjust=1)) +
            labs(x="Name of Airbnb", y="Number of Reviews", fill="Nearby Attractions")
        # Plots the joined_reviews data
    })
}

# Runs the application 
shinyApp(ui = ui, server = server)
