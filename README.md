CSUY 3083 Team Project

members: Kelly Wu, Xuhang He, Zhenwei Zhan

What's done: 

1. part of the html files 
2. implement access to databases with role 'viewer'
3. login
4. added check for unique userID
5. implement register (Done)
6. implement search (Done)
	1. Implement return button and show the satisfied rows.
7. setup index page (or change login page to index page) (Done)
8. login failure: (Done)
	1. probably want to add a pop-up that says login failure? 
9. registration failure (Done)

TODO:
1. implement 'host' roles
	1. based on permission, each page should leave a concsole that could input sql commands and change tables
	2. For each table should allow insert, modify users
2. implement 'officer/employee' role?
	1. these users can see the full table without any limitations
	2. however, they dont have the add/delete/update buttons/options

Testing: 
create new databses with XAMPP, import Criminal_Records.sql and usrs.sql. 
after that, input all the commands
