function(input, output, session) {
  
  # reactive values init -----
  active_user <- reactiveValues(username = NULL, color = NULL)
  
  # dynamic ui -----
  output$dynamic_ui <- renderUI({
    if (is.null(active_user$username)) {
      source(file = "R/signed_out_ui.R", local = T)$value
      
    } else {
      source(file = "R/signed_in_ui.R", local = T)$value
    }
  })
  
  # sign up ----
  source(file = "R/sign_up_server.R", local = T)$value
  
  # sign in ----
  source(file = "R/sign_in_server.R", local = T)$value
  
  # active session ----
  source(file = "R/active_session_server.R", local = T)$value
  
  # contact form -----
  source(file = "R/contact_form_server.R", local = T)$value
  
  # privacy notice -----
  observeEvent(input$privacy_notice_agree, {
    session$sendCustomMessage(type = "privacyNoticeOk", message = "placeholder")
  })
}