# Urbaneats database
## Introduction
This is database for a fictitious start up company tending to venture into the food delivery and restaurant <br>
logistics industry. This repo contains the ER diagram, the schema and dummy data. Should it be fit for you,<br>
you can use this as a base model for a more refined and professional model, as a learning resource and/or as a <br> 
benchmark for your work.

The main concept of the business model, is that it provides a convinient method of food ordering and customer <br>
management establishing and easy and trusted network between suppliers and customers.

## The ER diagram design - Thought process 
The database has the following tables
### admins 
For users who will be administering the system.
This table is not related to any other table subject to future changes.

### customers
For user who will be interating with the system. 
They may order food, make payments, update their profile and check <br> 
progress just to mention a few. This table relates to the payments and <br> 
orders table, as an order / payment belongs to one and one only customer, <br>
take note that customers can make many payments/orders.

### restaurant_managers
For users who will be managing the online restaurants.
They may manage the restaurant from time to time hence they relate <br> 
to the restaurants table (each restaurant should have atleast one manager).

### delivery_riders
For user who will be delivering food when prepared.
They may update the system on the pickup and delivery time of the <br> 
food. Each order has a delivery rider, hence this table related with the orders tables.

### restaurants
For online restaurants.
This relates with the orders table (as each order is directed towards a specific restaurant), menu items ( as each item belongs <br> 
to a specific restaurant), restauarant managers (as depicted in the above discription) and opening hours (as each restaurant has one).

### menu_items
For online menus belonging to various restaurants.
it relates with the restaurants table and menu items category table (since each item belongs to a certain category).

### menu_items_category
For various categories of food.
relates with menu items as above description.

### opening_hours
For various online and offline time of various restaurants.
relates to restaurants, see above.

### Order items

11. Orders
12. Payments

