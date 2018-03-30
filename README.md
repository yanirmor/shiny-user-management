# Shiny User Management
Demonstration of user management in Shiny  
<a href = "https://yanirmor.shinyapps.io/shiny-user-management">
https://yanirmor.shinyapps.io/shiny-user-management</a>

#### About
This repository contains code for a user management app in Shiny.  
The app connects to a cloud database for user registration and authentication purposes.  
Besides R, you will find here code written in SQL, CSS and JavaScript.  
You are welcome to fork the repository and share any ideas and bugs by creating issues.

#### Usage
1\. To run a local version of the app, you'll have to set up your own **PostgreSQL** database  
2\. Once you have it, create a table called **users** using 
<a href = "https://github.com/yanirmor/shiny-user-management/blob/master/SQL/create_users_table.sql">
this statement</a>    
3\. Next, create two R scripts under the folder "R". These will hold your secrets (make sure they are private!)    

* The file `key.R` will hold a key chosen by you
	```R
	KEY <- <the_key_you_chose>
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
