connect_to_db <- function() {
  source("R/credentials.R", local = T)
  dbConnect(
    drv = Postgres(),
    dbname = DBNAME, 
    user = USER, 
    password = PASSWORD, 
    host = HOST, 
    port = PORT
  )
}

read_users_table <- function() {
  connection <- connect_to_db()
  df <- dbReadTable(conn = connection, name = "users")
  dbDisconnect(conn = connection)
  return(df)
}

read_sql_file <- function(path) {
  path %>% readLines() %>% paste(collapse = "")
}

generate_hash <- function(password) {
  source("R/key.R", local = T)
  hmac(key = KEY, object = password, algo = "sha256")
}

validate_login <- function(username, password) {
  users <- read_users_table()
  password_hash <- generate_hash(password = password)
  
  users <- users %>% 
    filter(username == !!username, password_hash == !!password_hash)
  
  if (nrow(users) == 0) return(list(result = F))
  
  update_last_login(
    last_login = as.character(now(tzone = "UTC")),
    username = username
  )
  
  list(result = T, last_login = users$last_login)
}

update_last_login <- function(last_login, username) {
  connection <- connect_to_db()
  statement <- read_sql_file(path = "SQL/update_last_login.sql")
  
  statement <- sqlInterpolate(
    conn = connection, sql = statement, 
    last_login = last_login, username = username
  )
  
  result <- dbSendQuery(conn = connection, statement = statement)
  dbClearResult(res = result)
  dbDisconnect(conn = connection)
  return()
}

validate_sign_up <- function(username, password, verify) {
  if (nchar(username) > 12 | nchar(password) > 12) {
    return(list(result = F, message = "Maximum 12 characters"))
  }
  
  if (!grepl("^[[:alnum:]]+$", username) | !grepl("^[[:alnum:]]+$", password)) {
    return(list(result = F, message = "Only letters and digits are allowed"))
  }
  
  if (password != verify) {
    return(list(result = F, message = "Passwords don't match"))
  }
  
  withProgress(
    value = 0.5,
    message = "Please wait",
    expr = {
      users <- read_users_table()
      
      if (username %in% users$username) {
        return(list(result = F, message = "Username already exists"))
      }
      
      current_time <- as.character(now(tzone = "UTC"))
      
      add_user(
        username = username, 
        password = password,
        current_time = current_time
      )
      
      list(result = T, last_login = current_time)
    }
  )
}

add_user <- function(username, password, current_time) {
  connection <- connect_to_db()
  statement <- read_sql_file(path = "SQL/add_user.sql")
  password_hash <- generate_hash(password = password)
  
  statement <- sqlInterpolate(
    conn = connection, 
    sql = statement, 
    username = username, 
    password_hash = password_hash, 
    sign_up = current_time,
    last_login = current_time
  )
  
  result <- dbSendQuery(conn = connection, statement = statement)
  dbClearResult(res = result)
  dbDisconnect(conn = connection)
  return()
}

remove_account <- function(username) {
  connection <- connect_to_db()
  statement <- read_sql_file(path = "SQL/remove_account.sql")
  
  statement <- sqlInterpolate(
    conn = connection, 
    sql = statement, 
    username = username
  )
  
  result <- dbSendQuery(conn = connection, statement = statement)
  dbClearResult(res = result)
  dbDisconnect(conn = connection)
  return()
}
