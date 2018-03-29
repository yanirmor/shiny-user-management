library(dplyr)
library(DBI)
library(RPostgres)

# connect -----------------------------------------------------------------
source("R/functions.R")
connection <- connect_to_db()

# create table ------------------------------------------------------------
var <- dbListTables(connection)
dbRemoveTable(connection, "users")
x <- dbSendQuery(
  connection, 
  statement = read_sql_file("SQL/create_users_table.sql")
)
dbClearResult(x)

# read table --------------------------------------------------------------
df <- dbReadTable(connection, "users")

# columns info ------------------------------------------------------------
x <- dbSendQuery(
  connection, 
  statement = "SELECT * FROM information_schema WHERE table_name = 'users';"
)
df <- dbFetch(x)
dbClearResult(x)

# disconnect --------------------------------------------------------------
dbDisconnect(connection)
