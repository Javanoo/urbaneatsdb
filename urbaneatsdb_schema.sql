/* 
* urban eats database schema
* author : Matthews Offen <matthewsoffen2@gmail.com>
* author github : https://github/javanoo
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
 name VARCHAR(50),
 creation_date  DATETIME DEFAULT CURRENT_TIMESTAMP,
 last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 CONSTRAINT admins_pk PRIMARY KEY (user_type_id),
 UNIQUE idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for `users`
--

CREATE TABLE users ( 
 user_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
 first_name  VARCHAR (50) NOT NULL,
 last_name VARCHAR (50) NOT NULL,
 email VARCHAR(100) DEFAULT NULL,
 phone VARCHAR (10) NOT NULL,
 password_phrase VARCHAR(255) NOT NULL,
 user_type_id SMALLINT UNSIGNED NOT NULL,
 status ENUM('active','suspended') DEFAULT  'active', 
 creation_date  DATETIME DEFAULT CURRENT_TIMESTAMP,
 last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 CONSTRAINT admins_pk PRIMARY KEY (user_id),
 KEY idx_users_last_name (last_name),
 UNIQUE idx_users_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for `opening hours`
--

CREATE TABLE opening_hours (
 opening_hour_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
 restaurant_id INT UNSIGNED NOT NULL,
 day_name ENUM('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun') NOT NULL,
 opens_at TIME DEFAULT NULL,
 closes_at TIME DEFAULT NULL,
 creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
 last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 UNIQUE u_idx_restaurant_id_and_day_name (restaurant_id, day_name),
 CONSTRAINT opening_hours_pk PRIMARY KEY (opening_hour_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for `restaurants`
--

CREATE TABLE restaurants ( 
 restaurant_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
 name  VARCHAR (100) NOT NULL,
 address VARCHAR (250) NOT NULL, 
 city VARCHAR (100) NOT NULL,
 opening_hours SMALLINT UNSIGNED DEFAULT NULL,
 status ENUM('open','closed'),
 rating DECIMAL (2,1),
 manager_id INT UNSIGNED NOT NULL, -- user of restaurant manager type
 creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
 last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 KEY idx_restaurants_name (name),
 CONSTRAINT restaurants_pk PRIMARY KEY (restaurant_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for `menu items category`
--

CREATE TABLE menu_items_category ( 
 menu_item_category_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
 name  VARCHAR(50) NOT NULL,
 creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
 last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 KEY idx_menu_item_category_name (name),
 CONSTRAINT menu_item_category_pk PRIMARY KEY (menu_item_category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
 CONSTRAINT menu_items_pk PRIMARY KEY (menu_item_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for `order items`
--

CREATE TABLE order_items ( 
 order_item_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
 order_id  INT UNSIGNED NOT NULL,
 menu_item_id INT UNSIGNED NOT NULL,
 quantity INT UNSIGNED NOT NULL, 
 price DECIMAL (12,2) DEFAULT 0.00,
 creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
 last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 CONSTRAINT order_items_pk PRIMARY KEY (order_item_id)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
 
--
-- Table structure for `orders`
--

CREATE TABLE orders ( 
 order_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
 restaurant_id INT UNSIGNED NOT NULL,
 customer_id INT UNSIGNED NOT NULL, -- user (customer type) 
 order_status ENUM('placed','on_the_way', 'cancelled') DEFAULT 'placed',
 total_amount DECIMAL (12,2) DEFAULT 0.00,
 delivery_rider_id INT UNSIGNED NOT NULL, -- user (delivery rider type)
 pickup_time TIME DEFAULT NULL,
 delivery_time TIME DEFAULT NULL, 
 creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
 last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 CONSTRAINT orders_pk PRIMARY KEY (order_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- TABLE structure for `payments`
--

CREATE TABLE payments ( 
 payment_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
 customer_id INT UNSIGNED NOT NULL, -- user (customer type)
 order_id INT UNSIGNED NOT NULL,
 payment_method ENUM('card','cash','wallet') DEFAULT 'card',
 payment_status ENUM('pending', 'paid', 'failed') DEFAULT 'pending',
 transaction_id VARCHAR(250) DEFAULT NULL, 
 creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
 last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 KEY idx_payments_transaction_id (transaction_id),
 CONSTRAINT payments_pk PRIMARY KEY (payment_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- referential constraints
-- for users to user types 
ALTER TABLE users ADD CONSTRAINT users_to_user_types 
FOREIGN KEY (user_type_id) 
REFERENCES user_types (user_type_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- for opening_hours to restaurants 
ALTER TABLE opening_hours ADD CONSTRAINT opening_hours_to_restaurants 
FOREIGN KEY (restaurant_id) 
REFERENCES restaurants (restaurant_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- for restaurants to restaurant managers
ALTER TABLE restaurants ADD CONSTRAINT restaurants_to_restaurant_managers_fk 
FOREIGN KEY (manager_id) 
REFERENCES users (user_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE restaurants ADD CONSTRAINT restaurants_to_opening_hours_fk 
FOREIGN KEY (opening_hours) 
REFERENCES opening_hours (opening_hour_id)
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
-- summary views
--
/*
CREATE VIEW urbaneats_statistics_vw (
 item_type,
 entry_count,
 -- oldest_modification,
 recent_activity) 
AS 
SELECT 'admin' AS item_type, COUNT(*) AS entry_count, 
 -- MIN(creation_date) AS oldest_modification,
 ( SELECT concat(
    first_name,' ', last_name, ' (ID : ', admin_id, ')', ' modified at ',
    (SELECT MAX(last_updated) FROM admins))
   FROM admins
   WHERE last_updated = (SELECT MAX(last_updated) FROM admins)
   ORDER BY last_updated DESC
   LIMIT 1 
 ) AS recent_activity
FROM admins
GROUP BY item_type
UNION ALL
SELECT 'customer' AS item_type, COUNT(*) AS entry_count, 
 -- MIN(creation_date) AS oldest_modification,
 ( SELECT concat(
    first_name,' ', last_name, ' ( ID : ', customer_id, ')', ' modified at ',
    (SELECT MAX(last_updated) FROM customers))
   FROM customers
   WHERE last_updated = (SELECT MAX(last_updated) FROM customers)
   ORDER BY last_updated DESC
   LIMIT 1 
 ) AS recent_activity 
FROM customers
GROUP BY item_type
UNION ALL
SELECT 'restaurants' AS item_type, COUNT(*) AS entry_count, 
 -- MIN(creation_date) AS oldest_modification,
 ( SELECT concat(
    name, ' ( ID : ', restaurant_id, ')', ' modified at ',
    (SELECT MAX(last_updated) FROM restaurants))
   FROM restaurants
   WHERE last_updated = (SELECT MAX(last_updated) FROM restaurants)
   ORDER BY last_updated DESC
   LIMIT 1 
 ) AS recent_activity
FROM restaurants
GROUP BY item_type
UNION ALL
SELECT 'delivery riders' AS item_type, COUNT(*) AS entry_count, 
 -- MIN(creation_date) AS oldest_modification,
 ( SELECT concat(
    first_name,' ', last_name, ' ( ID : ', delivery_rider_id, ')', 
    ' modified at ', 
    (SELECT MAX(last_updated) FROM delivery_riders))
   FROM delivery_riders
   WHERE last_updated = (SELECT MAX(last_updated) FROM admins)
   ORDER BY last_updated DESC
   LIMIT 1 
 ) AS recent_activity
FROM delivery_riders
GROUP BY item_type
UNION ALL
SELECT 'payments' AS item_type, COUNT(*) AS entry_count, 
 -- MIN(creation_date) AS oldest_modification,
 MAX(last_updated) AS recent_modification 
FROM payments
GROUP BY item_type;
-- end of file
*/
