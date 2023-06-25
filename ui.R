#--------------------------------------------------
# load libraries

library(shiny)
library(htmltools)
library(shinyjs)
library(leaflet)
library(dplyr)
library(fresh)
library(glue)
library(sf)

#--------------------------------------------------
# start front end
ui <- shinyUI(
    fluidPage(
        tags$head(HTML("<title>Orte der Sozialdemokratie</title>")),
        leafletOutput("map", height = "100vh")
    )
)