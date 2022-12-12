#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(plotly)
library(ggplot2)
library(shinythemes)

a5_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")


# Define server logic 
server <- function(input, output) {
  
  # Makes Dataframe of Cement CO2 Emissions since 1928  
  agg_tbl1 <- a5_data %>%
    group_by(year, country, cement_co2) %>%
    drop_na(cement_co2) %>%
    filter(cement_co2 > 0) %>%
    filter(year > 1971) %>%
    summarise(Occurrences = n())
  
  # Makes Dataframe of Cement C02 Emissions in Different Continents since 1928"
  continents_cement_co2 <- agg_tbl1[agg_tbl1$country %in% c("Africa", "North America", "South America", "Europe", "Asia", "Oceania"),]
  
  #image
  output$home_page <- renderImage({
    list(src = "CO2.jpeg",
         width = "100%",
         height = 350)
  },deleteFile = F)
  
  # Creates Interactive Bar Graph
  output$selectContinent <- renderUI({
    selectInput("Years", "Choose Year", choices = unique(continents_cement_co2$year))
  })
  barplot <- reactive({
    chartdata <- continents_cement_co2 %>%
      filter(year %in% input$Years)
    chartdata2 <- chartdata %>%
      arrange((cement_co2), by.group = TRUE)
    ggplot(chartdata2, aes(x = reorder(country,-cement_co2), y = cement_co2, color = country, fill = country)) +
      geom_col(width = 1) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      guides(fill=guide_legend(title="Continent")) +
      labs(
        x = "Continents",
        y = "Cement CO2 Emissions in Million Tonnes",
        title = "Cement CO2 Emissions in Million Tonnes By Continent Since 1972",
        color = "")
  })
  output$barchart <- renderPlotly({
    barplot()
  }) 
}
  




