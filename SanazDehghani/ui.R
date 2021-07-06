library(plotly)
library(ggplot2)
library(gapminder)
library(shinycustomloader)

ui <- fluidPage(
    
    # here we have App title 
    titlePanel("Shiny Application for Interacting Gapminder Data"),
    
    # input and output definitions
    sidebarLayout(
        
        # Sidebar panel for inputs
        sidebarPanel(
            
            # drop down Input for selecting continent
            selectInput("continent", "Continent",
                        choices = c("All", levels(gapminder$continent))),
            #sliderbar for selecting range of life expectancy
            sliderInput(inputId = "life", label = "Life expectancy",
                        min = 0, max = 120,
                        value = c(30, 50)),
        ),
        
        # outputs panel
        mainPanel(
            
            # Output plot
             withLoader(plotlyOutput("plot")) ),
                        
            )
        )
