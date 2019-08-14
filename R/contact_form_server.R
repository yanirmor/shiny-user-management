observeEvent(input$contact_button, {
  session$sendCustomMessage(
    type = "matomoEvent", 
    message = c("Header Buttons", "Click", "Contact Form")
  )
  
  showModal(
    modalDialog(
      title = "Contact", 
      footer = list(
        actionButton(inputId = "contact_send", label = "Send"),
        actionButton(
          inputId = "contact_dismiss", 
          label = "Dismiss", 
          class = "caution-button"
        )
      ), 
      easyClose = T,
      
      includeScript(path = "js/contact_form_script.js"),
      
      div(
        id = "my_email",
        
        img(src = "icons/email.png"),
        a(href = "mailto:contact@yanirmor.com", "contact@yanirmor.com")
      ),
      
      textInput(inputId = "contact_name", label = NULL, placeholder = "Name"),
      
      textInput(inputId = "contact_email", label = NULL, placeholder = "Email"),
      
      textAreaInput(
        inputId = "contact_message", 
        label = NULL, 
        placeholder = "Message", 
        rows = 3, 
        resize = "none"
      )
    )  
  )
})

observeEvent(input$contact_dismiss, {
  removeModal()
})

observeEvent(input$contact_send, {

  first_validation_result <- any(
    input$contact_name != "",
    input$contact_email != "",
    input$contact_messasge != ""
  )
  
  req(first_validation_result)
  
  # contact form validation -----
  formatted_log(
    user = active_user$username, 
    content = "contact form validation"
  )
  
  second_validation_result <- all(
    nchar(input$contact_name) <= 50,
    nchar(input$contact_email) <= 50,
    nchar(input$contact_messasge) <= 255
  )
  
  if (second_validation_result == F) {
    formatted_log(
      user = active_user$username, 
      error = T, 
      content = "contact form validation failed"
    )
    
    session$sendCustomMessage(
      type = "matomoEvent", 
      message = c("Contact Form", "Send", "Validation Failed")
    )
  }
  
  req(second_validation_result)
  
  # send contact form -----
  formatted_log(user = active_user$username, content = "send contact form")
  
  withProgress(
    value = 1, 
    message = "Sending",
    expr = {
      conn <- connect_to_db()
      
      new_row <- data.frame(
        source = basename(path = getwd()), 
        name = input$contact_name,
        email = input$contact_email,
        message = input$contact_message,
        created_at = strftime(x = Sys.time(), tz = "UTC")
      )
      
      try_result <- try(
        silent = T,
        expr = dbWriteTable(
          conn = conn, 
          name = "contact_forms",
          value = new_row,
          overwrite = F,
          append = T
        )
      )
      
      dbDisconnect(conn = conn)
    }
  )
  
  # analyze send contact form try result -----
  formatted_log(
    user = active_user$username, 
    content = "analyze send contact form try result"
  )
  
  if (try_result == T) {
    # successful send contact form
    formatted_log(
      user = active_user$username, 
      content = "successful send contact form"
    )
    
    updateTextInput(session = session, inputId = "contact_name", value = "")
    updateTextInput(session = session, inputId = "contact_email", value = "")
    updateTextInput(session = session, inputId = "contact_message", value = "")
    
    session$sendCustomMessage(
      type = "matomoEvent", 
      message = c("Contact Form", "Send", "Success")
    )
    
    generic_modal(error = F, content = "The message was sent successfully")
    
  } else {
    # send contact form due to unknown issue
    formatted_log(
      user = active_user$username, 
      error = T,
      content = attributes(try_result)$condition$message
    )
    
    updateTextInput(session = session, inputId = "contact_name", value = "")
    updateTextInput(session = session, inputId = "contact_email", value = "")
    updateTextInput(session = session, inputId = "contact_message", value = "")
    
    session$sendCustomMessage(
      type = "matomoEvent", 
      message = c("Contact Form", "Send", "Something Failed")
    )
    
    generic_modal(content = "Something went wrong, please try again")
  }
})
