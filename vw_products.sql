CREATE TABLE customers (
	customer_key INT PRIMARY KEY,
	gender VARCHAR(20),
	name VARCHAR(150),
	city VARCHAR(100),
	state_code VARCHAR(50),
	state VARCHAR(100),
	zip_code VARCHAR(50),
	country VARCHAR(100),
	continent VARCHAR(50),
	birthday DATE
);

CREATE TABLE stores (
	store_key INT PRIMARY KEY,
	country VARCHAR(100),
	state VARCHAR(100),
	square_meters INT,
	open_date DATE
);

CREATE TABLE products (
	product_key INT PRIMARY KEY,
	product_name VARCHAR (255),
	brand VARCHAR (50),
	color VARCHAR (20),
	unit_cost_usd TEXT,
	unit_price_usd TEXT,
	sub_category_key INT,
	sub_category VARCHAR (100),
	category_key INT,
	category VARCHAR (50) 
);

CREATE TABLE sales (
	order_number INT,
	line_item INT, 		
	order_date DATE,
	delivery_date DATE,
	customer_key INT,
	store_key INT,
	product_key INT,
	quantity INT,
	currency_code VARCHAR (3),
	PRIMARY KEY (order_number, line_item)
);

CREATE TABLE exchange_rates (
	date DATE,
	currency VARCHAR (3),
	exchange NUMERIC (10,4),
	PRIMARY KEY (date, currency)	
);

ALTER DATABASE global_eletronics_retailer SET datestyle TO 'ISO, MDY'