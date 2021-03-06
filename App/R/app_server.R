options(shiny.maxRequestSize=30*1024^3)
#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {

  app_data <- shiny::reactive({

    if (length(input$tribunal) == 0) {
      tribunais <- unique(inovaCNJ::da_incos$tribunal)
    } else {
      tribunais <- input$tribunal
    }

    aux_tribunal <- inovaCNJ::da_totais %>%
      dplyr::filter(tribunal == input$tribunal)

    aux_justica <- inovaCNJ::da_totais %>%
      dplyr::filter(justica == aux_tribunal$justica)

    incos <- inovaCNJ::da_incos %>%
      dplyr::filter(tribunal %in% tribunais)

    list(
      incos = incos,
      totais_justica = aux_justica,
      totais_tribunal = aux_tribunal
    )

  })

  mod_input_server("input_ui_1")
  mod_geral_server("geral_ui_1", app_data)
  mod_incos_server("incos_ui_1", app_data)
  mod_verificacao_server("verificacao_ui_1", app_data)
  mod_feedback_server("feedback_ui_1")
  # mod_teste_server("teste_ui_1")

}
