/* 
* initial draft of urban eats database schema
* author : Matthews Offen <matthewsoffen2@gmail.com>
* author github : https://github/javanoo
* date : 20 February 2026
*/ 

CREATE DATABASE urbaneatsdb;

use urbaneatsdb;

/*Table creation queries*/
CREATE TABLE admins ( admin_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
			first_name  VARCHAR (50) NOT NULL,
			last_name VARCHAR (50) NOT NULL,
			email VARCHAR(100),
			phone VARCHAR (10) NOT NULL,
			password_phrase VARCHAR(255) NOT NULL,
			status ENUM('active','suspended') DEFAULT  'active', 
			creation_date  DATETIME DEFAULT CURRENT_TIMESTAMP,
			last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
			CONSTRAINT admins_pk PRIMARY KEY (admin_id),
			UNIQUE idx_admins_email (email));

CREATE TABLE customers ( customer_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
			first_name  VARCHAR (50) NOT NULL,
			last_name VARCHAR (50) NOT NULL,
			email VARCHAR(100),
			phone VARCHAR (10) NOT NULL,
			password_phrase VARCHAR(255) NOT NULL,
			status ENUM('active','suspended') DEFAULT  'active', 
			creation_date  DATETIME DEFAULT CURRENT_TIMESTAMP,
			last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
			CONSTRAINT customers_pk PRIMARY KEY (customer_id),
			KEY idx_customers_full_name (last_name, first_name),
			UNIQUE idx_customers_email (email));

CREATE TABLE restaurant_managers ( restaurant_manager_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
			first_name  VARCHAR (50) NOT NULL,
			last_name VARCHAR (50) NOT NULL,
			email VARCHAR(100),
			phone VARCHAR (10) NOT NULL,
			password_phrase VARCHAR(255) NOT NULL,
			status ENUM('active','suspended') DEFAULT  'active', 
			creation_date  DATETIME DEFAULT CURRENT_TIMESTAMP,
			last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
			CONSTRAINT restaurant_managers_pk PRIMARY KEY (restaurant_manager_id),
			UNIQUE idx_restaurant_managers_email (email));

CREATE TABLE delivery_riders ( delivery_rider_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
			first_name  VARCHAR (50) NOT NULL,
			last_name VARCHAR (50) NOT NULL,
			email VARCHAR(100),
			phone VARCHAR (10) NOT NULL,
			password_phrase VARCHAR(255) NOT NULL,
			status ENUM('active','suspended') DEFAULT  'active', 
			creation_date  DATETIME DEFAULT CURRENT_TIMESTAMP,
			last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
			CONSTRAINT delivery_riders_pk PRIMARY KEY (delivery_rider_id),
			UNIQUE idx_delivery_riders_email (email));

CREATE TABLE restaurants ( restaurant_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
			name  VARCHAR (100) NOT NULL,
			address VARCHAR (250) NOT NULL, 
			city VARCHAR (100) NOT NULL,
			opening_hours MEDIUMTEXT NOT NULL,
			status ENUM('open','closed'),
			rating DECIMAL (2,1),
			restaurant_manager_id INT UNSIGNED NOT NULL, 
			creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
			last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
			CONSTRAINT restaurants_pk PRIMARY KEY (restaurant_id));

CREATE TABLE menu_items_category ( menu_item_category_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
			name  VARCHAR(50) NOT NULL,
			creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
			last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
			CONSTRAINT menu_item_category_pk PRIMARY KEY (menu_item_category_id));

CREATE TABLE menu_items ( menu_item_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
			restaurant_id  INT UNSIGNED NOT NULL,
			name VARCHAR (250) NOT NULL, 
			description MEDIUMTEXT NOT NULL,
			price DECIMAL (12,2) DEFAULT 0.00,
			status ENUM('available','unavailable'),
			category_id INT UNSIGNED NOT NULL, 
			creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
			last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
			CONSTRAINT menu_items_pk PRIMARY KEY (menu_item_id));

CREATE TABLE order_items ( order_item_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
			order_id  INT UNSIGNED NOT NULL,
			menu_item_id INT UNSIGNED NOT NULL,
			quantity INT UNSIGNED NOT NULL, 
			price DECIMAL (12,2) DEFAULT 0.00,
			creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
			last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
			CONSTRAINT order_items_pk PRIMARY KEY (order_item_id));

CREATE TABLE orders ( order_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
			restaurant_id INT UNSIGNED NOT NULL,
			customer_id INT UNSIGNED NOT NULL, 
			order_status ENUM('placed','on_the_way', 'cancelled'),
			total_amount DECIMAL (12,2) DEFAULT 0.00,
			delivery_rider_id INT UNSIGNED NOT NULL,
			pickup_time TIME,
			delivery_time TIME,
			payment_id INT UNSIGNED, 
			creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
			last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
			CONSTRAINT orders_pk PRIMARY KEY (order_id));

CREATE TABLE payments ( payment_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
			customer_id INT UNSIGNED NOT NULL,
			order_id INT UNSIGNED NOT NULL, 
			payment_amount DECIMAL (12,2) DEFAULT 0.00,
			payment_method ENUM('card','cash','wallet'),
			payment_status ENUM('pending', 'paid', 'failed') DEFAULT 'pending',
			transaction_id VARCHAR(250) DEFAULT NULL, 
			creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
			last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
			CONSTRAINT payments_pk PRIMARY KEY (payment_id));

/* relationships */
/* for restaurants to restaurant managers*/
ALTER TABLE restaurants ADD CONSTRAINT restaurants_to_restaurant_managers_fk FOREIGN KEY (restaurant_manager_id) 
			REFERENCES restaurant_managers (restaurant_manager_id);
			
/* for menu items to restaurant and category*/
ALTER TABLE menu_items ADD CONSTRAINT menu_items_to_restaurants_fk FOREIGN KEY (restaurant_id) 
			REFERENCES restaurants (restaurant_id);
ALTER TABLE menu_items ADD CONSTRAINT menu_items_to_menu_item_category_fk FOREIGN KEY (category_id) 
			REFERENCES menu_items_category (menu_item_category_id);

/* for order items to menu items*/
ALTER TABLE order_items ADD CONSTRAINT order_items_to_menu_items_fk FOREIGN KEY (menu_item_id) 
			REFERENCES menu_items (menu_item_id);
ALTER TABLE order_items ADD CONSTRAINT order_items_to_orders_fk FOREIGN KEY (order_id) 
			REFERENCES orders (order_id);

/* for orders to restaurants, customers and delivery riders*/
ALTER TABLE orders ADD CONSTRAINT orders_to_restaurants_fk FOREIGN KEY (restaurant_id) 
			REFERENCES restaurants (restaurant_id);
ALTER TABLE orders ADD CONSTRAINT orders_to_customers_fk FOREIGN KEY (customer_id) 
			REFERENCES customers (customer_id);
ALTER TABLE orders ADD CONSTRAINT orders_to_delivery_riders_fk FOREIGN KEY (delivery_rider_id) 
			REFERENCES delivery_riders (delivery_rider_id);
ALTER TABLE orders ADD CONSTRAINT orders_to_payments_fk FOREIGN KEY (payment_id) 
			REFERENCES payments (payment_id);

/* for payments to customers and orders*/
ALTER TABLE payments ADD CONSTRAINT payments_to_customer_fk FOREIGN KEY (customer_id)
			REFERENCES customers (customer_id);
ALTER TABLE payments ADD CONSTRAINT payments_to_orders_fk FOREIGN KEY (order_id)
			REFERENCES orders (order_id);

/* end of file */
