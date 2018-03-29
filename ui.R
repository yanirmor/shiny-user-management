fluidPage(
  # css and js --------------------------------------------------------------
  includeCSS("www/style.css"),
  includeScript("www/script.js"),

  # header ------------------------------------------------------------------
  fluidRow(column(width = 4, offset = 4, wellPanel(
    id = "header",
    h1("User Management App"),
    h4("Created by Yanir Mor"),
    h5("Visit my", a(
      "GitHub", 
      href = "https://github.com/yanirmor/shiny-user-management", 
      target="_blank"
    ))
  ))),
  
  # main --------------------------------------------------------------------
  fluidRow(column(width = 4, offset = 4, wellPanel(
    id = "main",
    fluidRow(column(12, textOutput("welcome"))),
    fluidRow(column(12, textOutput("last_login"))),
    fluidRow(column(12, uiOutput("options")))
  )))
)
