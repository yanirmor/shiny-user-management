function(input, output, session) {
  
  # reactive values init -----
  active_user <- reactiveValues(username = NULL, color = NULL)
  
  # dynamic ui -----
  output$dynamic_ui <- renderUI({
    if (is.null(active_user$username)) {
      source(file = "rscripts/signed_out_ui.R", local = T)$value
      
    } else {
      source(file = "rscripts/signed_in_ui.R", local = T)$value
    }
  })
  
  # sign up ----
  source(file = "rscripts/sign_up_server.R", local = T)$value
  
  # sign in ----
  source(file = "rscripts/sign_in_server.R", local = T)$value
  
  # active session ----
  source(file = "rscripts/active_session_server.R", local = T)$value
  
}
