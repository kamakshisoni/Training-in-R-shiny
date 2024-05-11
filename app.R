#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
rm(list = ls())
library(shiny)
library(shinydashboard)
library(dplyr)
source("global.R")
source("modules/data_upload.R")
source("modules/data_view.R")
app <- shinyApp(
  ui <- dashboardPage(
    dashboardHeader(title = 'Test App'),
    dashboardSidebar(
      sidebarMenu(
        menuItem("Data Upload", tabName = "data_upload"),
        menuItem("Data View", tabName = "view")
      )
    ),
    dashboardBody(
      tabItems(
        tabItem(tabName = "data_upload", mod1_ui('data_upload')),
        tabItem(tabName = "view", mod2_ui('view'))
                
        )
      
    )
  ), 
  
  server <- function(input, output){
    mod1_server('data_upload')
    mod2_server('view')
    
  })
