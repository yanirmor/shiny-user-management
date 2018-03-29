login_modal <- modalDialog(
  title = h3("Login"), size = "s", easyClose = T, footer = NULL,
  textInput("login_username", label = "Username"),
  passwordInput("login_password", label = "Password"),
  textOutput("login_error"), 
  br(),
  fluidRow(
    actionButton("login_submit", label = "Submit"), 
    align = "center"
  )
)

sign_up_modal <- modalDialog(
  title = h3("Sign Up"), size = "s", easyClose = T, footer = NULL,
  textInput("sign_up_username", label = "Username"),
  passwordInput("sign_up_password", label = "Password"),
  passwordInput("sign_up_verify", label = "Verify Password"),
  textOutput("sign_up_error"),
  br(),
  fluidRow(
    actionButton("sign_up_submit", label = "Submit"),
    align = "center"
  )
)

remove_account_modal <- modalDialog(
  title = h3("Remove Account"), size = "s", easyClose = T, footer = NULL,
  "Are you sure?",
  br(),
  "Click anywhere to cancel",
  br(), br(),
  fluidRow(
    actionButton("remove_account_confirm", label = "Confirm"),
    align = "center"
  )
)
