#--------------------------------------------------
# load libraries

library(shiny)
library(htmltools)
library(shinyjs)
library(leaflet)
library(dplyr)
library(fresh)
library(glue)

#--------------------------------------------------
# start front end
ui <- shinyUI(
    fluidPage(
        tags$head(HTML("<title>Orte der Sozialdemokratie</title>"), tags$link(rel = "stylesheet", type = "text/css", href = "styling.css")),
        leafletOutput("map", height = "100vh")
    )
)