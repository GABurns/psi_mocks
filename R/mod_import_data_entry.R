#' import_data_entry UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList helpText
#' @importFrom datamods import_modal import_server
mod_import_data_entry_ui <- function(id){
  ns <- NS(id)
  tagList(
    h2("Import Data"),
    helpText("Record your results in the MS Excel template. "),
    reactableOutput(ns("table")),
    actionButton(ns("import_modal"), "Import Data From Excel")
  )
}

#' import_data_entry Server Functions
#'
#' @noRd
mod_import_data_entry_server <- function(id, data){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    observeEvent(input$import_modal, {

      import_modal(
        id = ns("myid"),
        from = "file",
        title = "Import data to be used in application",
        size = "l"
      )
    })

    imported <- import_server("myid", return_class = "data.frame")

    observeEvent(imported$data(), {
      req(length(imported$data()))
      data$dataset <-  imported$data()
    })



    output$table <- renderReactable({
      if (nrow(data$dataset) <= 0) {
        validate("Please enter some values")
      }
      reactable(data = data$dataset)
    })

  })
}
