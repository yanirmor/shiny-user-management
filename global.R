# environment -----
rm(list = ls())
invisible(gc())
options(encoding = "UTF-8", scipen = 999, stringsAsFactors = F)
if (interactive()) options(shiny.autoreload = T)

# packages -----
suppressPackageStartupMessages({
  library(shiny)
  library(dplyr)
  library(RPostgres)
  library(DBI)
  library(digest)
})

# scripts -----
source(file = "functions.R")
