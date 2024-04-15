#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  data <-
    reactiveValues(
      dataset = data.frame(
        Person = character(0L),
        Group = character(0L),
        Treatment = character(0L),
        Value = numeric(0L)
      )
    )


  mod_data_entry_server("data_entry", data = data)
  mod_modal_data_entry_server("modal_data_entry", data = data)
  mod_import_data_entry_server("excel_import", data = data)
}
