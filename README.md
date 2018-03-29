# Shiny User Management
Demonstration of user management in Shiny  
<a target = "_blank" href = https://yanirmor.shinyapps.io/shiny-user-management>
https://yanirmor.shinyapps.io/shiny-user-management
</a>

#### About
This repository contains an app that demonstrates user management in Shiny.  
It connects to a cloud-based database in order to register and authenticate users.  
Besides R, this repository contains code in SQL, CSS and JavaScript.  
You are welcome to fork the repository and share any ideas and bugs by creating issues.

#### Usage
1\. To run a local version of the app, you'll have to set up your own **PostgreSQL** database  
2\. Once you have it, create a table called **users** using 
<a href = "https://github.com/yanirmor/shiny-user-management/R/db_tests.R">this script</a>  
3\. Next, create two R scripts that will hold your secrets (make sure they are private!) 

* The file `key.R` will hold a key chosen by you
	```R
	KEY <- <the_key_you_chosed>
	```
    
* The file `credentials.R` will hold your database credentials
	```R
	DBNAME <- <your_db_name>
	USER <- <your_db_user>
	PASSWORD <- <your_db_password>
	HOST <- <your_db_host>
	PORT <- <your_db_port>
	```
	
---
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)  
Copyright © 2018 Yanir Mor
