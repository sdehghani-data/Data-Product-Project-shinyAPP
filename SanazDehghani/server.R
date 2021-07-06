library(plotly)
library(ggplot2)
library(gapminder)
library(shinycustomloader)

server <- function(input, output) {
    filtered_data <- reactive({
        data <- gapminder
        data <- subset(
            data,
            lifeExp >= input$life[1] & lifeExp <= input$life[2]
        )
        if (input$continent != "All") {
            data <- subset(
                data,
                continent == input$continent
            )
        }
        data
    })
    
    
    output$download_data <- downloadHandler(
        filename = function() {
            paste("gapminder-data-", Sys.Date(), ".csv", sep="")
        },
        content = function(file) {
            write.csv(filtered_data(), file)
        }
    )
    
    
    output$plot <- renderPlotly({
        
        ggplotly({
            data <- filtered_data()
            
            p <- ggplot(data, aes(gdpPercap, lifeExp)) +
                geom_point(size = 2) +
                scale_x_log10() +
                ggtitle("GDP vs Life expectancy")
                
                
              
            p
        })
    })
}