#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Define UI for application that draws a histogram
mod1_ui <- function(id){
  ns = NS(id)
  fluidPage(
    sidebarLayout(
      sidebarPanel(
        fileInput(ns('file'),"Upload Data", accept= c(".csv", ".xlsx")),
        uiOutput(ns("sheet_select"))
        
      ),
      
      mainPanel(
        verbatimTextOutput(ns("summary"))
      )
      
    )
    
  )
  
}
  

# Define server logic required to draw a histogram
mod1_server <- function(id){
  moduleServer(id, function(input, output, session) {
    ns = session$ns
    
   
    
    # function to read data in csv and excel
    read_data <- function(file_path) {
      if (tools::file_ext(file_path) == "csv") {
        read.csv(file_path)
      } else if (tools::file_ext(file_path) %in% c("xls", "xlsx")) {
        rv$sheets <- readxl::excel_sheets(file_path)
        # Default to the first sheet
        readxl::read_excel(file_path, sheet = 1)
      } else {
        NULL
      }
    }
    
    # Read the file upload
    observeEvent(input$file,{
      if(!is.null(input$file)){
        rv$data = read_data(input$file$datapath)
      }
    })
    
    #Dynamic UI for sheet selection
    output$sheet_select <- renderUI({
      if(!is.null(rv$sheets)){
        selectInput("sheet","Select Excel Sheet", choices = rv$sheets)
      } else {
        NULL
      }
    })
    
    # Summary of uploaded data
    output$summary <- renderPrint({
      if (!is.null(rv$data)) {
        # summary(rv$data)
        "Data is uploaded"
      } else {
        NULL
      }
    })
  })
}

