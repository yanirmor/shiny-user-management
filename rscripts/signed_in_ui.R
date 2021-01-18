tagList(
  includeScript(path = "js/signed_in_script.js"),
  
  div(
    div(class = "content-title", textOutput(outputId = "signed_in_title")),
    
    "This content is only accessible by you.",
    br(),
    
    htmlOutput(outputId = "signed_in_color"),
    br(),
    
    tags$form(
      class = "inline-parent signed-in-form",
      
      textInput(
        inputId = "signed_in_new_color", 
        label = NULL, 
        placeholder = "Change Favorite Color"
      ),
      
      actionButton(inputId = "signed_in_new_color_button", label = "Apply")
    ),
    
    tags$form(
      class = "signed-in-form",
      
      passwordInput(
        inputId = "signed_in_new_password", 
        label = NULL, 
        placeholder = "New Password (6-12 characters)"
      ),
      
      div(
        class = "inline-parent",
        
        passwordInput(
          inputId = "signed_in_verify_new_password", 
          label = NULL, 
          placeholder = "Verify New Password"
        ),
        
        actionButton(inputId = "signed_in_new_password_button", label = "Apply")
      )
    ),
    
    div(
      id = "signed_in_buttons",

      actionButton(inputId = "sign_out_button", label = "Sign Out"),
      actionButton(
        inputId = "remove_account_button", 
        label = "Remove Account",
        class = "caution-button"
      )
    )
  )
)
