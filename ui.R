basicPage(
  # page set up -----
  tags$head(
    tags$meta(charset = "UTF-8"),
    
    tags$meta(
      name = "keywords",
      content = "R Shiny, Shiny, Shiny User Management, Shiny Authentication, Yanir Mor"
    ),
    
    tags$meta(
      name = "description",
      content = "Demonstration of user management and authentication system in R Shiny. Users can see content specific to them, which no other user can access."
    ),
    
    tags$link(href = "icons/user.png", rel = "icon"),
    tags$link(href = "icons/user.png", rel = "apple-touch-icon"),
    tags$link(
      rel = "stylesheet", 
      href = "https://fonts.googleapis.com/css?family=Open+Sans"
    ),
    tags$title("R Shiny User Management & Authentication")
  ),
  
  includeCSS(path = "style.css"),
  includeCSS(path = "media_style.css"),
  includeScript(path = "script.js"),
  
  # header -----
  tags$header(
    div(
      id = "header_title", 
      
      img(src = "icons/user.png"), 
      span("R Shiny", class = "third-color"),
      "User Management",
      span("&", class = "third-color"),
      "Authentication"
    ),
    
    div(
      id = "header_buttons",
      
      a(
        href = "https://www.yanirmor.com", 
        target = "_blank", 
        img(src = "icons/website.png"),
        title = "My Website"
      ),
      
      actionLink(
        inputId = "contact_button", 
        label = img(src = "icons/email.png"),
        title = "Contact"
      ),
      
      a(
        href = "https://github.com/yanirmor/shiny-user-management", 
        target = "_blank", 
        img(src = "icons/github.png"),
        title = "Source Code"
      )
    )
  ),
  
  # body -----
  div(
    class = "wrapper",
    
    # about section -----
    div(
      id = "about",
      
      div(class = "content-title", "About"),
      "This app demonstrates a secured user management and authentication system in R Shiny.", 
      br(),
      "Users can sign up, and their credentials are stored in a PostgreSQL database.", 
      br(),
      "Once signed in, a user can see content specific to him/her (in this case, a favorite color), which no other user can access."
    ),
    
    # dynamic ui section -----
    uiOutput(outputId = "dynamic_ui")
  ),
  
  # footer -----
  tags$footer(
    div(
      id = "footer_copyright",
      "2019", 
      span(class = "third-color", "Yanir Mor"), 
      HTML("&copy;"), 
      "All Rights Reserved",
      span(
        id = "licenses",
        span(class = "third-color", "(Licenses)"),
        div(
          "Icon by Typicons / Iconfinder (CC BY-SA 3.0)"
        )
      )
    )
  )
)
