#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom bslib page_navbar bs_theme nav_panel
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    page_navbar(
      title = "PSI Mocks",
      theme = bs_theme(bootswatch = "minty"),
      nav_panel(title = "Sidebar Data Entry", mod_data_entry_ui("data_entry")),
      nav_panel(title = "Modal Data Entry", mod_modal_data_entry_ui("modal_data_entry")),
      nav_panel(title = "Excel Import", mod_import_data_entry_ui("excel_import"))
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path("www",
                    app_sys("app/www"))

  tags$head(favicon(),
            bundle_resources(path = app_sys("app/www"),
                             app_title = "psimocks"))
}
