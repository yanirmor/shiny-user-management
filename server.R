function(input, output, session) {
  # reactive variables ------------------------------------------------------
  active_user <- reactiveVal(NULL)
  
  dynamic_vars <- reactive({
    if(is.null(active_user())) {
      list(
        user = "guest",
        option_1 = actionLink("login", label = "Login"),
        option_2 = actionLink("sign_up", label = "Sign Up")
      )
    } else {
      list(
        user = active_user()$username,
        option_1 = actionLink("log_out", label = "Log Out"),
        option_2 = actionLink("remove_account", label = "Remove Account")
      )
    }
  })
  
  # outputs -----------------------------------------------------------------
  output$welcome <- renderText({
    sprintf("Welcome, %s!", dynamic_vars()$user)
  })
  
  output$options <- renderUI({
    HTML(sprintf("%s or %s", dynamic_vars()$option_1, dynamic_vars()$option_2))
  })
  
  output$last_login <- renderText({
    req(active_user()$last_login)
    sprintf("Last login: %s UTC", active_user()$last_login)
  })

  # login -------------------------------------------------------------------
  observeEvent(input$login, {
    output$login_error <- renderText(NULL)
    showModal(login_modal)
  })
  
  observeEvent(input$login_submit, {
    req(input$login_username != "")
    req(input$login_password != "")
    
    validation <- withProgress(
      value = 0.5,
      message = "Please wait",
      expr = validate_login(
        username = input$login_username, 
        password = input$login_password
      )
    )
    
    if (validation$result == F) {
      output$login_error <- renderText("Wrong username and/or password")
      
    } else {
      active_user(
        list(
          username = input$login_username,
          last_login = validation$last_login
        )
      )
      removeModal()
    }
  })

  # sign up -----------------------------------------------------------------
  observeEvent(input$sign_up, {
    output$sign_up_error <- renderText(NULL)
    showModal(sign_up_modal)
  })
  
  observeEvent(input$sign_up_submit, {
    req(input$sign_up_username != "")
    req(input$sign_up_password != "")
    req(input$sign_up_verify != "")
    
    validation <- validate_sign_up(
      username = input$sign_up_username,
      password = input$sign_up_password,
      verify = input$sign_up_verify
    )
    
    if (validation$result == F) {
      output$sign_up_error <- renderText(validation$message)
      
    } else {
      active_user(
        list(
          username = input$sign_up_username, 
          last_login = validation$last_login)
      )
      removeModal()
    }
  })
  
  # log out -----------------------------------------------------------------
  observeEvent(input$log_out, active_user(NULL))
  
  # remove account ----------------------------------------------------------
  observeEvent(input$remove_account, showModal(remove_account_modal))
  
  observeEvent(input$remove_account_confirm, {
    withProgress(
      value = 0.5,
      message = "Please wait",
      expr = remove_account(username = active_user()$username)
    )
    active_user(NULL)
    removeModal()
  })
}
