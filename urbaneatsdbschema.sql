// initial draft of urban eats database schema
// author : Matthews Offen <matthewsoffen2@gmail.com>
// author github : https://github/javanoo
// date : 20 February 2026

// user tables (admin, customer, restaurant manager and delivery ride)

CREATE TABLE admins ( admin_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
			first_name  VARCHAR (250) NOT NULL,
			last_name VARCHAR (250) NOT NULL, 
			phone VARCHAR (10) NOT NULL,
			password VARCHAR NOT NULL,
			status ENUM('active','suspend'), 
			creation_date DATE,
			last_updated TIMESTAMP,
			CONSTRAINT admins_pk PRIMARY KEY (admins.admin_id));

CREATE TABLE customers ( customer_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
			first_name  VARCHAR (250) NOT NULL,
			last_name VARCHAR (250) NOT NULL, 
			phone VARCHAR (10) NOT NULL,
			password VARCHAR NOT NULL,
			status ENUM('active','suspend'), 
			creation_date DATE,
			last_updated TIMESTAMP,
			CONSTRAINT customers_pk PRIMARY KEY (customers.customer_id));

CREATE TABLE restaurant_managers ( restaurant_manager_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
			first_name  VARCHAR (250) NOT NULL,
			last_name VARCHAR (250) NOT NULL, 
			phone VARCHAR (10) NOT NULL,
			password VARCHAR NOT NULL,
			status ENUM('active','suspend'), 
			creation_date DATE,
			last_updated TIMESTAMP,
			CONSTRAINT restaurant_managers_pk PRIMARY KEY (restaurant_managers.restaurant_manager_id));

CREATE TABLE delivery_riders ( delivery_rider_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
			first_name  VARCHAR (250) NOT NULL,
			last_name VARCHAR (250) NOT NULL, 
			phone VARCHAR (10) NOT NULL,
			password VARCHAR NOT NULL,
			status ENUM('active','suspend'), 
			creation_date DATE,
			last_updated TIMESTAMP,
			CONSTRAINT delivery_riders_pk PRIMARY KEY (delivery_riders.delivery_rider_id));

// restaurant and other related tables

CREATE TABLE restaurants ( restaurant_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
			name  VARCHAR (250) NOT NULL,
			address VARCHAR (250) NOT NULL, 
			city VARCHAR (100) NOT NULL,
			opening_hours MEDIUM TEXT NOT NULL,
			status ENUM('open','closed'),
			rating DOUBLE,
			restaurant_manager_id INT NOT NULL, 
			creation_date DATE,
			last_updated TIMESTAMP,
			CONSTRAINT restaurants_pk PRIMARY KEY (restaurants.restaurant_id),
			CONSTRAINT restaurants_to_restaurant_managers_fk FOREIGN KEY (restaurants.restaurant_manager_id) 
			REFERENCES restaurant_managers.restaurant_manager_id);

CREATE TABLE menu_items ( menu_item_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
			restaurant_id  INT NOT NULL,
			name VARCHAR (250) NOT NULL, 
			description MEDIUM TEXT NOT NULL,
			price DOUBLE UNSIGNED NOT NULL,
			status ENUM('available','unvailable'),
			category_id INT NOT NULL, 
			creation_date DATE,
			last_updated TIMESTAMP,
			CONSTRAINT menu_items_pk PRIMARY KEY (menu_items.menu_item_id),
			CONSTRAINT menu_items_to_restaurats_fk FOREIGN KEY (menu_items.restaurant_id) 
			REFERENCES restaurants.restaurant_id,
			CONSTRAINT menu_items_to_menu_item_category_fk FOREIGN KEY (menu_items.category_id) 
			REFERENCES menu_items_category.menu_item_category_id);

CREATE TABLE menu_item_category ( menu_item_category_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
			name  VARCHAR NOT NULL,
			creation_date DATE,
			last_updated TIMESTAMP,
			CONSTRAINT menu_item_category_pk PRIMARY KEY (menu_item_category.menu_item_category_id));

CREATE TABLE order_items ( order_item_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
			order_id  INT NOT NULL,
			menu_item_id INT NOT NULL,
			quantity INT UNSIGNED NOT NULL, 
			price DOUBLE UNSIGNED NOT NULL,
			creation_date DATE,
			last_updated TIMESTAMP,
			CONSTRAINT order_items_pk PRIMARY KEY (orders.order_id),
			CONSTRAINT order_items_to_orders_fk FOREIGN KEY (order_items.order_id) 
			REFERENCES orders.order_id,
			CONSTRAINT order_items_to_menu_items_fk FOREIGN KEY (order_items.menu_item_id) 
			REFERENCES menu_items.menu_item_id);

CREATE TABLE orders ( order_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
			restaurant_id INT NOT NULL,
			customer_id INT NOT NULL, 
			order_status ENUM('placed','on_the_way', 'cancelled'),
			total_amount DOUBLE,
			delivery_rider_id INT NOT NULL,
			pickup_time TIME,
			delivery_time TIME,
			payment_id INT NOT NULL, 
			creation_date DATE,
			last_updated TIMESTAMP,
			CONSTRAINT orders_pk PRIMARY KEY (orders.order_id)
			CONSTRAINT orders_to_restaurants_fk FOREIGN KEY (orders.restaurant_id) 
			REFERENCES restaurants.restaurant_id,
			CONSTRAINT orders_to_customers_fk FOREIGN KEY (orders.customer_id) 
			REFERENCES customers.customer_id,
			CONSTRAINT orders_to_delivery_riders_fk FOREIGN KEY (orders.delivery_rider_id) 
			REFERENCES delivery_riders.delivery_rider_id,
			CONSTRAINT orders_to_payments_fk FOREIGN KEY (orders.payment_id) 
			REFERENCES payments.payment_id
			);

CREATE TABLE payments ( payment_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
			customer_id INT NOT NULL,
			order_id INT NOT NULL, 
			payment_amount DOUBLE NOT NULL,
			change DOUBLE NOT NULL,
			payment_method ENUM('card','cash','wallet'),
			payment_status ENUM('pending', 'paid', 'failed')
			transaction_id VARCHAR(250), 
			creation_date DATE,
			last_updated TIMESTAMP,
			CONSTRAINT payments_pk PRIMARY KEY (payments.payment_id),
			CONSTRAINT payments_to_customer_fk FOREIGN KEY (payments.customer_id)
			REFERENCES customers.customer_id,
			CONSTRAINT payments_to_orders_fk FOREIGN KEY (payments.order_id)
			REFERENCES orders.order_id);
// end of file
