#' modal_data_entry UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom DT DTOutput
mod_modal_data_entry_ui <- function(id){
  ns <- NS(id)
  tagList(

    DTOutput(ns("table")),
    actionButton(inputId = ns("openModal"), label = "Add Data")

  )
}

#' modal_data_entry Server Functions
#'
#' @noRd
#' @importFrom DT renderDT
mod_modal_data_entry_server <- function(id, data){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # Function to open modal
    observeEvent(input$openModal, {
      showModal(
        modalDialog(
          textInput(ns("name"), "Name"),
          textInput(ns("group"), "Group"),
          textInput(ns("treatment"), "Treatment"),
          numericInput(ns("value"), "Value", value = 0),
          footer = modalButton(label = "Cancel"), actionButton(label = "Add", inputId = ns("addBtn"))
        )
      )
    })

    observeEvent(input$addBtn, {
      data$dataset[nrow(data$dataset) + 1, ] <-
        c(input$name, input$group, input$treatment, input$value)
    }, ignoreInit = TRUE)

    output$table <- renderDT({
      if (nrow(data$dataset) <= 0) {
        validate("Please enter some values")
      }
      data$dataset
    })

  })
}
