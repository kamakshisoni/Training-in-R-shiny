#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Define UI for application that draws a histogram
mod2_ui <- function(id){
  ns = NS(id)
  fluidPage(
        box(title = "Data Summary",width = 12,
            tabBox(width = 12,
                   tabPanel(
                     title = "Data Preview",
                     box(dataTableOutput(ns('data_preview')), width = 12)
                   ),
                   tabPanel(
                     title = "Data Summary",
                     box(dataTableOutput(ns('data_summary')), width = 12)
                   ),
                   tabPanel(
                     title = "Data Types",
                     uiOutput(ns("col_output")),
                     textOutput(ns("col_text")),
                     uiOutput(ns("type_output")),
                     textOutput(ns("type_text"))
                   )
                   
              
            ))
      )
      
}
  

# Define server logic required to draw a histogram
mod2_server <- function(id){
  moduleServer(id, function(input, output, session) {
    ns = session$ns
    
    output$data_preview <- renderDataTable({
      
      DT::datatable(rv$data)
      
    })
    
    output$data_summary <- renderDataTable({
      
      Summary_df <- as.data.frame(t(do.call(cbind, lapply(rv$data, summary)))) %>%
        tibble::rownames_to_column() %>%
        rename('Variables Name' = 'rowname')
      
      DT::datatable(Summary_df)
      
      
    })
    
    output$col_output <- renderUI({
      selectInput(ns('col_name'), 
                  label = "Select Column",
                  #selected = colnames(rv$data)[1],
                  choices = colnames(rv$data)
                  # multiple = TRUE
      )
    })
    
    output$type_output <- renderUI({
      req(input$col_name)
      column_selecter <- input$col_name
      column_type <- class(rv$data[[column_selecter]])
      
      selectInput(ns('type_name'), 
                  label = "Select Data Type",
                  selected = column_type,
                  choices = list('character','numeric','integer','date','boolean')
                  # multiple = TRUE
      )
    })
    
    output$col_text <- renderText({
      selected_col <- input$col_name
      paste("Your selected column:", selected_col)
      
    })
    
    output$type_text <- renderText({
      datatype_selected_col <- input$type_name
      paste("Data Type of Selected Column:", datatype_selected_col)
      
    })
    

  })
}

