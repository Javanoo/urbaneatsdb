/* 
* urban eats database schema
* author : Matthews Offen <matthewsoffen2@gmail.com>
* author's github : https://github/javanoo
* date : 20 February 2026
*/ 

DROP DATABASE IF EXISTS urbaneatsdb;
CREATE DATABASE urbaneatsdb;

USE urbaneatsdb;

--
-- Table structure for user_types
--

CREATE TABLE user_types(
 user_type_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
 name VARCHAR(50) NOT NULL,
 creation_date  DATETIME DEFAULT CURRENT_TIMESTAMP,
 last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 CONSTRAINT user_types_pk PRIMARY KEY (user_type_id),
 UNIQUE idx_unique_user_type_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*
* indexed name for uniqueness and faster fetch using the name attribute.
*/

--
-- Table structure for `users`
--

CREATE TABLE users ( 
 user_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
 first_name  VARCHAR (50) NOT NULL,
 last_name VARCHAR (50) NOT NULL,
 email VARCHAR(100) NOT NULL,
 phone VARCHAR (20) NOT NULL,
 password_phrase VARCHAR(255) NOT NULL,
 user_type_id SMALLINT UNSIGNED NOT NULL,
 status ENUM('active','suspended') DEFAULT  'active', 
 creation_date  DATETIME DEFAULT CURRENT_TIMESTAMP,
 last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 CONSTRAINT users_pk PRIMARY KEY (user_id),
 KEY idx_users_last_name (last_name), 
 KEY idx_user_type_id_fk (user_type_id), 
 KEY idx_users_created_date (creation_date),
 UNIQUE idx_users_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*
* indexed last_name and creation_date for faster fetch using these attributes
* unique index on email for uniqueness
* and another index on user_type_id for faster fetch of tables in joins
*/

--
-- Table structure for `opening hours`
--

CREATE TABLE opening_hours (
 opening_hour_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
 restaurant_id INT UNSIGNED NOT NULL,
 day_name ENUM('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun') NOT NULL,
 opens_at TIME DEFAULT '00:00:00',
 closes_at TIME DEFAULT '23:59:59',
 creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
 last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 KEY idx_opening_hours_restaurant_id (restaurant_id),
 KEY idx_opening_hours_opens_at (opens_at),
 KEY idx_opening_hours_closes_at (closes_at), 
 UNIQUE idx_opening_hours_restaurant_id_and_day (restaurant_id, day_name),
 CONSTRAINT opening_hours_pk PRIMARY KEY (opening_hour_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*
* indexed opens and closes at for faster fetch of entries based on these 
* attributes.
* indexed restaurant_id for faster fetch of tables in joins and also here
* restaurant_id is needed to enforce a restaurant from entering opening hours 
* on same day.
*/

-- 
-- Table structure of addresses
-- 

CREATE TABLE addresses ( 
 address_id  SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
 street_name  VARCHAR (100) NOT NULL,
 postal_code VARCHAR(50) NOT NULL, 
 city VARCHAR (100) NOT NULL,
 region ENUM('northern', 'central', 'southern') NOT NULL DEFAULT 'central',
 creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
 last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 KEY idx_addresses_city (city), 
 KEY idx_addresses_region (region),
 CONSTRAINT addresses_pk PRIMARY KEY (address_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*
* indexed city and region for faster fetch of addresses using these attribute
*/

--
-- Table structure for `restaurants`
--

CREATE TABLE restaurants ( 
 restaurant_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
 name  VARCHAR (100) NOT NULL,
 address_id SMALLINT UNSIGNED NOT NULL,
 status ENUM('open','closed') DEFAULT 'open',
 rating DECIMAL (2,1) CHECK (rating >= 0.0 AND rating <= 5.0),
 restaurant_manager_id INT UNSIGNED NOT NULL, 
 creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
 last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 KEY idx_restaurants_name (name), 
 KEY idx_restaurants_address_id (address_id),
 KEY idx_restaurants_restaurant_manager_fk (restaurant_manager_id),
 CONSTRAINT restaurants_pk PRIMARY KEY (restaurant_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*
* manager_id is just user_id of the restaurant_manager type.
* indexed name, for faster fetch of restaurants using the name attribute
* another index on fk address_id for faster fetch of tables in a join
*/

--
-- Table structure for `menu items category`
--

CREATE TABLE menu_items_category ( 
 menu_item_category_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
 name  VARCHAR(50) NOT NULL,
 creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
 last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 UNIQUE idx_menu_items_category_unique_entry (name),
 CONSTRAINT menu_item_category_pk PRIMARY KEY (menu_item_category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*
* indexed name, for faster fetch of categories using name attribute and 
* uniqueness.
*/

--
-- Table structure for `menu items`
--

CREATE TABLE menu_items ( 
 menu_item_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
 restaurant_id  INT UNSIGNED NOT NULL,
 name VARCHAR (250) NOT NULL, 
 description TEXT NOT NULL,
 price DECIMAL (12,2) DEFAULT 0.00,
 status ENUM('available','unavailable') DEFAULT 'available',
 category_id INT UNSIGNED NOT NULL, 
 creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
 last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 KEY idx_menu_items_name (name), 
 KEY idx_menu_items_restaurant_id (restaurant_id), 
 KEY idx_status (status),
 KEY idx_menu_items_category (category_id),
 KEY idx_price (price),
 UNIQUE idx_menu_items_unique_entry_id (restaurant_id, name), 
 CONSTRAINT menu_items_pk PRIMARY KEY (menu_item_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*
* index keys on name, status and price, to enable faster fetch on menu items
* using these attributes.
* additional keys on restaurant_id and category_id for faster fetch of tables 
* during joins.
*/

--
-- Table structure for `order items`
--

CREATE TABLE order_items ( 
 order_item_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
 order_id  INT UNSIGNED NOT NULL,
 menu_item_id INT UNSIGNED NOT NULL,
 item_quantity INT UNSIGNED NOT NULL, 
 price DECIMAL (12,2) DEFAULT 0.00,
 creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
 last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 KEY idx_order_items_order_id (order_id),
 KEY idx_order_items_menu_item_id (menu_item_id),
 CONSTRAINT order_items_pk PRIMARY KEY (order_item_id)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*
* indexed order id and menu item id for faster fetch of tables in joins
*/

--
-- Table structure for `orders`
--

CREATE TABLE orders ( 
 order_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
 restaurant_id INT UNSIGNED NOT NULL,
 customer_id INT UNSIGNED NOT NULL,  
 order_status ENUM('placed','preparing','on the way', 'delivered', 'canceled') 
 DEFAULT 'placed',
 total_amount DECIMAL (12,2) DEFAULT 0.00,
 delivery_rider_id INT UNSIGNED, 
 pickup_time DATETIME DEFAULT NULL,
 delivery_time DATETIME DEFAULT NULL, 
 creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
 last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 KEY idx_orders_restaurant_id (restaurant_id),
 KEY idx_orders_customer_id (customer_id),
 KEY idx_orders_order_status (order_status),
 KEY idx_orders_delivery_rider_id (delivery_rider_id),
 KEY idx_orders_pickup_time (pickup_time),
 CONSTRAINT orders_pk PRIMARY KEY (order_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*
* indexed restaurant id, customer id, and delivery rider id for faster fetch
* of tables in joins
* also indexed order_status and pickup time for faster fetch of orders using 
* these attributes.
*/

--
-- TABLE structure for `payments`
--

CREATE TABLE payments ( 
 payment_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
 customer_id INT UNSIGNED NOT NULL, 
 order_id INT UNSIGNED NOT NULL,
 payment_method ENUM('card','cash','wallet') DEFAULT 'card',
 payment_status ENUM('pending', 'paid', 'failed') DEFAULT 'pending',
 transaction_id VARCHAR(250) DEFAULT NULL, 
 creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
 last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 KEY idx_payments_transaction_id (transaction_id),
 KEY idx_payments_customer_id (customer_id),
 KEY idx_payments_order_id (order_id),
 KEY idx_payments_payment_status (payment_status),
 KEY idx_payments_creation_date (creation_date),
 CONSTRAINT payments_pk PRIMARY KEY (payment_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*
* indexed transaction id, payment status and creation date for faster fetch of 
* payments using these attributes.
* indexed customer id and order id for faster fetch of tables in joins.
*/

-- referential constraints
-- for users to user types 
ALTER TABLE users ADD CONSTRAINT users_to_user_types_fk 
FOREIGN KEY (user_type_id) 
REFERENCES user_types (user_type_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- for opening_hours to restaurants 
ALTER TABLE opening_hours ADD CONSTRAINT opening_hours_to_restaurants_fk 
FOREIGN KEY (restaurant_id) 
REFERENCES restaurants (restaurant_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- for restaurants to restaurant managers
ALTER TABLE restaurants ADD CONSTRAINT restaurants_to_restaurant_managers_fk 
FOREIGN KEY (restaurant_manager_id) 
REFERENCES users (user_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE restaurants ADD CONSTRAINT restaurants_to_address_fk 
FOREIGN KEY (address_id) 
REFERENCES addresses (address_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;
			
-- for menu items to restaurant and category 
ALTER TABLE menu_items ADD CONSTRAINT menu_items_to_restaurants_fk 
FOREIGN KEY (restaurant_id) 
REFERENCES restaurants (restaurant_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE menu_items ADD CONSTRAINT menu_items_to_menu_item_category_fk 
FOREIGN KEY (category_id) 
REFERENCES menu_items_category (menu_item_category_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- for order items to menu items
ALTER TABLE order_items ADD CONSTRAINT order_items_to_menu_items_fk 
FOREIGN KEY (menu_item_id) 
REFERENCES menu_items (menu_item_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE order_items ADD CONSTRAINT order_items_to_orders_fk 
FOREIGN KEY (order_id) 
REFERENCES orders (order_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- for orders to restaurants, customers and delivery riders
ALTER TABLE orders ADD CONSTRAINT orders_to_restaurants_fk 
FOREIGN KEY (restaurant_id) 
REFERENCES restaurants (restaurant_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE orders ADD CONSTRAINT orders_to_customers_fk 
FOREIGN KEY (customer_id) 
REFERENCES users (user_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE orders ADD CONSTRAINT orders_to_delivery_riders_fk 
FOREIGN KEY (delivery_rider_id) 
REFERENCES users (user_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- payments to customers and orders
ALTER TABLE payments ADD CONSTRAINT payments_to_users_fk 
FOREIGN KEY (customer_id)
REFERENCES users (user_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE payments ADD CONSTRAINT payments_to_orders_fk 
FOREIGN KEY (order_id)
REFERENCES orders (order_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

--
-- Triggers on `order_items` table 
--
/*
DELIMITER ;;
CREATE TRIGGER update_order_amount_on_insert AFTER INSERT ON order_items
FOR EACH ROW 
 BEGIN
  UPDATE orders 
  SET total_amount = SUM(
   (SELECT price FROM order_items AS oi WHERE oi.order_id = new.order_id))
  WHERE orders.order_id = new.order_id;
 END;;
 
 CREATE TRIGGER update_order_amount_on_update AFTER UPDATE ON order_items
 FOR EACH ROW 
 BEGIN
  UPDATE orders 
  SET total_amount = SUM(
   (SELECT price FROM order_items AS oi WHERE oi.order_id = new.order_id))
  WHERE orders.order_id = new.order_id;
 END;;
 
DELIMITER ;*/
/*
* update the total amount of an order, when an insert or update happens on the 
* order_items table.
*/
  

-- 
-- View structure for `customer_payments_view`
--

CREATE VIEW customer_payments_view (
customer_id,
full_name,
payment_status,
order_id,
amount,
restaurant,
paid_date
)AS
SELECT py.customer_id, concat( cu.first_name, cu.last_name) AS full_name,
py.payment_status, py.order_id, ors.total_amount, rs.name, py.creation_date
FROM users AS cu
INNER JOIN payments AS py ON cu.user_id = py.customer_id
INNER JOIN orders AS ors ON py.order_id = ors.order_id
INNER JOIN restaurants AS rs ON ors.restaurant_id = rs.restaurant_id;

--
-- view structure for customers_view
-- 

CREATE VIEW customers_view (
user_id,
first_name,
last_name,
email,
phone,
status,
created_date
)AS 
SELECT user_id, first_name, last_name, 
concat(LEFT(email,3), "***", RIGHT(email,2)) AS email, 
phone, status, DATE(creation_date)
FROM users 
WHERE users.user_type_id = (SELECT user_type_id FROM user_types WHERE name = 'customer');

--
-- view structure for restaurants_view
--

CREATE VIEW restaurants_view (
restaurant_id,
name,
manager,
status,
address,
phone,
created_date
)AS 
SELECT rs.restaurant_id, rs.name, concat(first_name, " ", last_name) AS manager,
rs.status, concat(postal_code,', ',street_name,', ', city) as address,
phone, DATE(rs.creation_date)  
FROM restaurants AS rs 
INNER JOIN users ON rs.restaurant_manager_id = users.user_id
INNER JOIN addresses ON rs.address_id = addresses.address_id;

--
-- view structure for delivery_riders_view
-- 

CREATE VIEW delivery_riders_view (
user_id,
first_name,
last_name,
email,
phone,
status,
created_date
)AS 
SELECT user_id, first_name, last_name, 
concat(LEFT(email,3), "***", RIGHT(email,2)) AS email, 
phone, status, DATE(creation_date)
FROM users 
WHERE users.user_type_id = (SELECT user_type_id FROM user_types WHERE name = 'delivery rider');

--
-- view structure for admins_view
-- 

CREATE VIEW admins_view (
user_id,
first_name,
last_name,
email,
phone,
status,
created_date
)AS 
SELECT user_id, first_name, last_name, 
concat(LEFT(email,3), "***", RIGHT(email,2)) AS email, 
phone, status, DATE(creation_date)
FROM users 
WHERE users.user_type_id = (SELECT user_type_id FROM user_types WHERE name = 'administrator');

-- end of file
