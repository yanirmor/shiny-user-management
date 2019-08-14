observeEvent(input$sign_in_button, {
  req(input$sign_in_user, input$sign_in_password)
  
  # sign in validation -----
  formatted_log(user = input$sign_in_user, content = "sign in validation")
  
  withProgress(
    value = 1, 
    message = "Signing in",
    expr = {
      query <- sqlInterpolate(
        conn = ANSI(), 
        sql = read_sql_file(path = "sql/sign_in_validation.sql"),
        username = input$sign_in_user,
        password = hmac(
          key = Sys.getenv(x = "ENCRYPTION_KEY"),
          object = input$sign_in_password,
          algo = "sha512"
        )
      )
      
      conn <- connect_to_db()
      
      try_result <- try(
        silent = T, 
        expr = dbGetQuery(conn = conn, statement = query)
      )
      
      dbDisconnect(conn = conn)
    }
  )
  
  # analyze sign in try result -----
  formatted_log(
    user = input$sign_in_user, 
    content = "analyze sign in try result"
  )
  
  if (class(try_result) == "try-error") {
    # sign in failed for unknown reasons
    formatted_log(
      user = input$sign_in_user, 
      error = T,
      content = attributes(try_result)$condition$message
    )
    
    updateTextInput(session = session, inputId = "sign_in_user", value = "")
    updateTextInput(session = session, inputId = "sign_in_password", value = "")
    
    session$sendCustomMessage(
      type = "matomoEvent", 
      message = c("Sign In", "Click", "Something Failed")
    )
    
    generic_modal(content = "Something went wrong, please try again")
    
  } else if (nrow(try_result) == 0) {
    # sign in failed due to wrong credentials
    formatted_log(
      user = input$sign_in_user, 
      error = T,
      content = "sign in failed due to wrong credentials"
    )
    
    updateTextInput(session = session, inputId = "sign_in_user", value = "")
    updateTextInput(session = session, inputId = "sign_in_password", value = "")
    
    session$sendCustomMessage(
      type = "matomoEvent", 
      message = c("Sign In", "Click", "Credentials Failed")
    )
    
    generic_modal(content = "Username and/or password are wrong")
    
  } else {
    # successful sign in
    formatted_log(user = input$sign_in_user, content = "successful sign in")
    
    active_user$username <- try_result$username
    active_user$color <- try_result$color
    
    session$sendCustomMessage(type = "aboutSectionHandler", message = "hide")
    
    session$sendCustomMessage(
      type = "matomoEvent", 
      message = c("Sign In", "Click", "Success")
    )
  }
})
