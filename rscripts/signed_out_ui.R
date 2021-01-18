tagList(
  includeScript(path = "js/signed_out_script.js"),
  
  div(
    id = "sign_in_section",
    div(class = "content-title", "Sign In"),
    
    textInput(
      inputId = "sign_in_user", 
      label = NULL, 
      placeholder = "Username"
    ),
    
    passwordInput(
      inputId = "sign_in_password", 
      label = NULL, 
      placeholder = "Password"
    ),
    
    actionButton(inputId = "sign_in_button", label = "Sign In")
  ),
  
  div(
    class = "vr-separator",
    
    div(class = "vr-line"),
    img(src = "icons/user.png"),
    div(class = "vr-line")
  ),
  
  tags$form(
    id = "sign_up_section",
    div(class = "content-title", "Sign Up"),
    
    textInput(
      inputId = "sign_up_user", 
      label = NULL, 
      placeholder = "Username (4-10 characters)"
    ),
    
    textInput(
      inputId = "sign_up_color", 
      label = NULL, 
      placeholder = "Favorite Color"
    ),
    
    passwordInput(
      inputId = "sign_up_password", 
      label = NULL, 
      placeholder = "Password (6-12 characters)"
    ),
    
    passwordInput(
      inputId = "sign_up_verify_password", 
      label = NULL, 
      placeholder = "Verify Password"
    ),
    
    actionButton(inputId = "sign_up_button", label = "Sign Up")
  )
)
