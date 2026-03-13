# Urbaneats database 
## Introduction
This is database for a fictitious start up company tending to venture into the food delivery and restaurant <br>
logistics industry. This repo contains the ER diagram, the schema and dummy data. Should it be fit for you,<br>
you can use this as a base model for a more refined and professional model, as a learning resource and/or as a <br> 
benchmark for your work.

The main concept of the business model, is that, providing a convenient method of food ordering and customer <br>
management - establishing an easy and trusted network between suppliers and customers.

### Tools
![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![draw.io](https://img.shields.io/badge/Draw.io-Diagrams-orange?logo=diagramsdotnet)
## The ER diagram design(Crows foot notation) - Thought process 
![urbanseats ER Diagram](https://github.com/Javanoo/urbaneatsdb/blob/master/urbaneatsdb.drawio.svg)
The database has the following tables
### users_types
Holds information about a user's type, which can be either an administrator, 
customer, delivery rider or restaurant manager. Its relationship is with the 
Users table, described as a one to many, as in one type can be used to
identify many users.<br>

### users
Holds information about users, who can attain the role of an administrator, 
customer, delivery rider or restaurant manager defined in the user_types
relation. Unlike user types, this relation interacts with quite a few other
relations namely the payments, orders, restaurants and user_types(as
mentioned earlier) relations.<br>
On top of this, the relation has the following indexes for faster retrieval
of tuples using various attributes.<br>

indices: `users_pk`, `idx_users_last_name`, `idx_users_creation_date`<br>
attributes: `user_id`, `last_name`, `creation_date`, `user_type_id` <br>
additionally, a special key on the foreign key attribute `user_type_id` to <br>
facilitate faster table retrievals during relation joins.<br>

Please refer to the ER diagram above if lost at any point.<br>

### opening_hours
Holds information regarding the opening and closing hours of a restaurant.
Restaurants relate with it in a one to many relationship, as one
restaurant can have multiple opening hours grouped by days.<br>
it has the following indexes and attributes for faster operations<br>

indices: `idx_opening_hours_restaurant_id`,`idx_opening_hours_opens_at`,
`idx_opening_hours_closes_at`<br>
attributes:`opening_hour_id`,`restaurant_id`, `opens_at`, `closes_at`<br>
special keys on foreign key `restaurant_id` and unique compound key on
`restaurant_id and day_name` (necessary for unique entries).<br>

### addresses
Holds information about where a restaurant is situated. common attributes 
include, street name, city, region and postal code. This relation relates with
the restaurants relation in a one to one relation as one address can be used 
to represent a restaurant's location.<br>
Key indexes supporting faster operations include<br>

indices: `idx_addresses_city`, `idx_addresses_region`, 
`address_id_pk`<br>
attrributes: `city`, `region`, `address_id`<br>
This relation does not have any special key.

### restaurants
Holds information about various restaurants available. which includes,
its name, address, manager, status(whether operating - open or not - closed)
, rating (automatically generated and ranges out of 5) and various metadata
about a tuple. This relation interacts with the users relation to establish
a restaurant manager relationship and it also interacts with the addresses,
opening hours relations and other relations refer to it to establish their
own relationships.<br>
it has the following indexes and attributes for faster operations<br>

indices: `restaurants_pk`, `idx_restaurants_name`, `restaurants_address_id`<br>
attributes: `restaurant_id`, `name`, `address_id`, `restaurant_manager_id`<br>
special key on foreign key `restaurant_manager_id` for faster table joins.<br>

### menu_items
Holds information about different menus from various restaurants. As such, it 
relates with the restaurants relation to establish menu ownership and the 
menu items category relation as each menu item can be grouped into a specific
category. The relationship presented is one to many for both relationships
since restaurants can host multiple menu items and one category can be used
to group many menu items.<br>
The relation has the following index keys: <br>

indices: `menu_items_id_pk`, `idx_menu_items_name`, 
`idx_menu_items_restaurant_id`,`idx_status`, 
`menu_items_category`, `idx_price`<br>
attributes: `name`, `restaurant_id`, `status`, `category_id`, `price`<br>
special key on foreign key `restaurant_id` and unique compound key 
`restaurant_id and name` (to avoid duplicate entries by same restaurant)<br>


### menu_items_category
Holds information about the categories to a menu item may belong to, for example
it could a starter or dessert or beverage or some other category. This relation
relation relates with the menu items relation in a one to many fashion, since 
one category can be used to represent many menu items.<br>
The relation has the following index keys: <br>

indices: `menu_item_category_pk`<br>
attributes: `menu_item_category_id`, `name`<br>
special key on unique key `name` for unique entries.<br>


### order_items
Hold information about with menu item has been included in an order by a 
customer. As such this relation relates with the menu items relation in a one
to one relationship as each order item references one menu item and it also
relates with the orders relation in a one to many relationship since an order
can be comprised of many order items.<br>
it has the following index keys:<br> 

indices: `order_items_pk`<br>
attributes: `order_item_id`, `menu_item_id`, `order_id`<br>
special key on foreign keys `order_id` and `menu_item_id`<br>

### orders
Holds information regarding an order placed by a customer. This relation relates
with various relations to establish references necessary for defining the order
such as customer, restaurant and delivery rider data. The relationships with
these relations can be studied from previous discussion on the respective 
relation in question, and use the ER diagram to supplement the read.<br>
Like all over relations before this, it has the following index keys:<br>

indices: `orders_pk`,`idx_orders_pickup_time`, `idx_orders_order_status`<br>
attributes: `order_id`, `pickup_time`, `order_status`, `restaurant_id`,
`customer_id`, `delivery_rider_id`<br>
special key on foreign keys `restaurant_id`,`customer_id` and
`delivery_rider_id` 

### payments
Holds information about a payment initiated by a customer. This relation 
relates with the customer and orders relations for references on data to 
satisfy the payments definition. The relationship between this relation and
the customer relation is one to many as one customer can make many payments
and between orders relations is one to one as each payment is made for 
a specific order<br>
It has the following Keys:<br>

indices: `idx_payments_payments_pk`, `idx_payments_payment_status`, 
`idx_payments_creation_date`, `idx_payments_transaction_id`<br>
attributes: `payment_id`, `payment_status`, `creation_date`, `restaurant_id`<br>
,`customer_id`, `order_id`,`transaction_id`<br>
special key on foreign keys `restaurant_id`,`customer_id`, `order_id`<br> 


## Installation and Testing
As a prerequisite, you will need a MySQL server and mysql-cli tool.<br>
for installations of these, read <a href="https://dev.mysql.com/doc/mysql-installation-excerpt/5.7/en/"> here</a>

After installing and setting up the server, please download the source file or clone this repo into your local working <br>
directory and load the scripts through the mysql-cli tool by issuing these two commands: 

`mysql > source urbaneatsdb_schema.sql` 
`mysql > source urbaneatsdb_data.sql`

This should set up the whole database for you, ready for testing.

## Future Improvements
Features and future revisions are inevitable, hence they are welcomed. you might be wondering what features? <br>
well you could : <br>

- create more views for various use cases, this db has the following views for a start: <br> 
  1. user statistics 
  2. customer payments
- create procedures/triggers to facilitate consistency and many more. like the views, i have included some triggers as well
- can be normalized even further with maintenance in mind of course, like the city attribute having its own table for scalability.

