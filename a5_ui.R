#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyr)
library(dplyr)
library(plotly)
library(ggplot2)
library(shinythemes)

# Define UI for application
first_page <- tabPanel(
  "Project Overview",
  sidebarPanel(
    h1(strong("About Me")),
    hr(),
    h4("Rohith Sarma"),
    p("rsarma18@uw.edu"),
    br(),
  ),
  mainPanel(
    imageOutput("home_page"),
    h2(strong("INTRODUCTION")),
    br(),
    p("In this interactive shiny web application, I wanted to focus on the carbon dioxide emissions that come from cement production. Instead of creating a barchart of emissions by country, I thought it would be interesting to create a barchart of emissions by continent. Since I think, that would give people a better idea of what parts of the world emit the most carbon dioxide through cement productions."),
    br(),
    h2(strong("VARIABLES")),
    br(),
    p("The variables that I used in this application are cement CO2 emissions, measured in million tonnes. The year range of 1971 through 2021. And the continents of Asia, Africa, Europe, North America, Oceania, and South Americ."),
    br(),
    h2(strong("VALUES")),
    br(),
    p("From this chart, I found several interesting things. The first is that in 1971, Europe had the highest cement CO2 emissions with around 161 million tonnes. The second is that in 2021, Asia had around 1359 million tonnes of CO2 emissions from cement production. Almost 8.5 times as much as Europe did in 1971. The third is that in 1971, Oceania only had around 2.9 million tonnes of CO2 emissions from cement production, and in 2021, it had increased to only 3.2 million tonnes.")
  ))

#2nd page, bar chart of CO2 Emissions by Continent

second_page <- tabPanel(
  "Cement CO2 Emissions",
  mainPanel(
    titlePanel("Cement CO2 Emissions In Continents"),
    sidebarPanel(
      uiOutput("selectContinent")
    ),
    mainPanel(
      plotlyOutput("barchart", width = 700, height = 500),
      hr(),
      h3(strong("About the Graph")),
      p("This bargraph shows the carbon dioxide emissions for cement production in each continent, excluding Antarctica in the past 50 years. The graph is measured in million tonnes. This bar graph is an interactive graph where the user can pick any year since 1972 and see how things have changed. The bar graph is formatted in a way that for each year chosen, the graph will descend from left to right, in order of which continent produced the most CO2 emissions from cement production in a chosen year.")
    )
  )
)

ui <- navbarPage(
  theme = shinytheme("flatly"),
  "Carbon Dioxide Cement Emissions",
  first_page,
  second_page,
)

