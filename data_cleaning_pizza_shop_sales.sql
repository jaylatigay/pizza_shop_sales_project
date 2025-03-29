# DATA CLEANING

-- DATA CLEANING 
-- 1. remove duplicates (none in dataset)
-- 2. Standardized the data
-- 3. Null Values / blank values
-- 4. Remove unecessary columns 

# To view data type of each columns in a table
DESCRIBE order_details;
DESCRIBE orders;
DESCRIBE pizza_types;
DESCRIBE pizzas;


# changed type from text to date and changed column name to order_date
ALTER TABLE orders
CHANGE COLUMN `date` order_date DATE;

# changed type from text to time nd changed column name to order_time
ALTER TABLE orders
CHANGE COLUMN `time` order_time TIME;


#creates a combined table of order_details and orders table called order_summary 
CREATE TABLE order_summary (
	order_details_id INT,
    order_id INT,
    pizza_id TEXT,
    quantity INT,
    order_date DATE,
    order_time TIME,
    amount_due DOUBLE
);

#inserts necessary columns into the order_summary table
INSERT INTO order_summary (order_details_id, order_id, pizza_id, quantity, order_date, order_time, amount_due)
SELECT 
	ord_det.order_details_id,
    ord_det.order_id,
    ord_det.pizza_id,
    ord_det.quantity,
    ord.order_date,
    ord.order_time,
	ord_det.quantity * info.price
FROM order_details AS ord_det
INNER JOIN orders AS ord
	ON ord_det.order_id = ord.order_id
INNER JOIN pizza_info AS info
	ON ord_det.pizza_id = info.pizza_id;
    

#changed column name to pizza_name
ALTER TABLE pizza_types
CHANGE COLUMN `name` pizza_name TEXT;

#creates a combined table of pizzas and pizza_types table called pizza_info
CREATE TABLE pizza_info (
	pizza_type_id TEXT,
    pizza_name TEXT,
	category TEXT,
	pizza_id TEXT,
	size TEXT,
    price DOUBLE
);

#inserts necessary columns into the pizza_info table
INSERT INTO pizza_info (pizza_type_id, pizza_name, category, pizza_id, size, price)
SELECT 
	pizza_types.pizza_type_id,
    pizza_types.pizza_name,
	pizza_types.category,
	pizzas.pizza_id,
	pizzas.size,
    pizzas.price
FROM pizzas
INNER JOIN pizza_types
	ON pizzas.pizza_type_id = pizza_types.pizza_type_id ;

#displays the created tables
SELECT * 
FROM order_summary;
SELECT * 
FROM pizza_info;


