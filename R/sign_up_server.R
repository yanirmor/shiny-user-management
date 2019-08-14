observeEvent(input$sign_up_button, {
  req(
    input$sign_up_user, 
    input$sign_up_color, 
    input$sign_up_password, 
    input$sign_up_verify_password
  )
  
  # sign up validation -----
  formatted_log(user = input$sign_up_user, content = "sign up validation")

  validation_result <- all(
    input$sign_up_user %>% grepl(pattern = "^[A-z0-9]{4,10}$"),
    input$sign_up_color %>% grepl(pattern = "^[A-z]{1}[A-z -]{0,18}[A-z]{1}$"),
    input$sign_up_password %>% grepl(pattern = "^[A-z0-9]{6,12}$"),
    input$sign_up_password == input$sign_up_verify_password
  )
  
  if (validation_result == F) {
    formatted_log(
      user = input$sign_up_user, 
      error = T, 
      content = "sign up validation failed"
    )
    
    updateTextInput(
      session = session,
      inputId = "sign_up_password",
      value = ""
    )
    
    updateTextInput(
      session = session,
      inputId = "sign_up_verify_password",
      value = ""
    )
    
    session$sendCustomMessage(
      type = "matomoEvent", 
      message = c("Sign Up", "Click", "Validation Failed")
    )
    
    generic_modal(
      content = list(
        "Something went wrong.",
        br(),
        "Please try again with the following rules:", 
        br(), br(),
        tags$li("Username of 4-10 letters or digits"),
        tags$li("Color of 2-20 letters"),
        tags$li("Password of 6-12 letters or digits")
      )
    )
  }
  
  req(validation_result)
  
  # sign up a new user -----
  formatted_log(user = input$sign_up_user, content = "sign up a new user")
  
  withProgress(
    value = 1, 
    message = "Signing up",
    expr = {
      conn <- connect_to_db()
      
      new_row <- data.frame(
        username = input$sign_up_user, 
        color = input$sign_up_color,
        password = hmac(
          key = Sys.getenv(x = "ENCRYPTION_KEY"),
          object = input$sign_up_password,
          algo = "sha512"
        ),
        created_at = strftime(x = Sys.time(), tz = "UTC")
      )
      
      try_result <- try(
        silent = T,
        expr = dbWriteTable(
          conn = conn, 
          name = "user_management",
          value = new_row,
          overwrite = F,
          append = T
        )
      )
      
      dbDisconnect(conn = conn)
    }
  )
  
  # analyze sign up try result -----
  formatted_log(
    user = input$sign_up_user, 
    content = "analyze sign up try result"
  )
  
  if (try_result == T) {
    # successful sign up
    formatted_log(user = input$sign_up_user, content = "successful sign up")
    
    active_user$username <- input$sign_up_user
    active_user$color <- input$sign_up_color
    
    session$sendCustomMessage(type = "aboutSectionHandler", message = "hide")
    
    session$sendCustomMessage(
      type = "matomoEvent", 
      message = c("Sign Up", "Click", "Success")
    )
    
  } else if (
    grepl(
      pattern = "duplicate key value violates unique constraint", 
      x = attributes(try_result)$condition$message
    )
  ) {
    # sign up failed due to taken username
    formatted_log(
      user = input$sign_up_user, 
      error = T,
      content = "sign up failed due to taken username"
    )
    
    updateTextInput(
      session = session,
      inputId = "sign_up_password",
      value = ""
    )
    
    updateTextInput(
      session = session,
      inputId = "sign_up_verify_password",
      value = ""
    )
    
    session$sendCustomMessage(
      type = "matomoEvent", 
      message = c("Sign Up", "Click", "Username Taken Failed")
    )
    
    generic_modal(content = "Username is already taken")
    
  } else {
    # sign up failed due to unknown issue
    formatted_log(
      user = input$sign_up_user, 
      error = T,
      content = attributes(try_result)$condition$message
    )
    
    updateTextInput(
      session = session,
      inputId = "sign_up_password",
      value = ""
    )
    
    updateTextInput(
      session = session,
      inputId = "sign_up_verify_password",
      value = ""
    )
    
    session$sendCustomMessage(
      type = "matomoEvent", 
      message = c("Sign Up", "Click", "Something Failed")
    )
    
    generic_modal(content = "Something went wrong, please try again")
  }
})
