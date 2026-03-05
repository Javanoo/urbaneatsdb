# Urbaneats database 
## Introduction
This is database for a fictitious start up company tending to venture into the food delivery and restaurant <br>
logistics industry. This repo contains the ER diagram, the schema and dummy data. Should it be fit for you,<br>
you can use this as a base model for a more refined and professional model, as a learning resource and/or as a <br> 
benchmark for your work.

The main concept of the business model, is that it provides a convinient method of food ordering and customer <br>
management establishing an easy and trusted network between suppliers and customers.

### Tools
![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![draw.io](https://img.shields.io/badge/Draw.io-Diagrams-orange?logo=diagramsdotnet)
## The ER diagram design - Thought process 
![urbanseats ER Diagram](https://github.com/Javanoo/urbaneatsdb/blob/master/urbaneatsdb.drawio.svg)
The database has the following tables
### Users_Types
Holds information about a user's type, which can be either an adminstrator,<br> 
customer, delivery rider or restaurant manager. Its relationship is with the<br> 
Users table, described as a one to many, as in one type can be identified by<br> 
many users.<br>



### restaurants
For online restaurants.
This relates with the orders table (as each order is directed towards a <br> 
specific restaurant), menu items ( as each item belongs to a specific restaurant), <br>
restauarant managers (as depicted in the above discription) and opening hours <br> 
(as each restaurant has one).

### menu_items
For online menus belonging to various restaurants.
it relates with the restaurants table and menu items category table (since each <br>
item belongs to a certain category).

### menu_items_category
For various categories of food.<br>
relates with menu items as above description.

### opening_hours
For various online and offline time of various restaurants.<br>
relates to restaurants, see above.

### Order items
For ordered food items.<br>
relates with menu item (as they contain menu items) and order (as they belong to a specific order).

### Orders
For orders comprising of ordered food items.<br>
relates with customers (as they belong to one and one only customer), restaurant (as they belong to a specific restaurant),<br>
order items( as they are comprised of the order items) and delivery riders (since they are assigned to them for deliveries)

### Payments
For payment transactions.<br>
relates with customers (they make the pay) and orders (the are made against a particular order for the customers).

## Installations and Try out
as a prerequisite, you will need a MySQL server and mysql-cli tool, and then you are good to go.<br>
for installations of these, read <a href="https://dev.mysql.com/doc/mysql-installation-excerpt/5.7/en/"> here</a>

After installing and setting up the server, please download the source file or clone this repo into your local working <br>
directory and load them through the mysql-cli tool by issuing this command: 

mysql > `source urbaneatsdb_schema.sql urbaneatsdb_data.sql`

after that, you are good to go. explore and play around with it.

## Future Improvements
yeah features and future revisions are inevitable, hence they are welcomed. you might be wondering what features? <br>
well you could : <br>

- create views for various use cases.<br>
- create procedures/triggers to facilitate consistency and many more, i provided one view but, it barely does anything impressive.
- can be normalized even further with maintenance in mind of course.

[^1]:Oh aaand, feel free to reach out, whether you need help, want to collab, or just critic, i am open for that, thanks.
[^2]:ciao!!
