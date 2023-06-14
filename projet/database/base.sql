CREATE SEQUENCE brand_id_seq START WITH 1;

CREATE SEQUENCE laptop_id_seq START WITH 1;

CREATE SEQUENCE processor_id_seq START WITH 1;

CREATE SEQUENCE role_id_seq START WITH 1;

CREATE SEQUENCE settings_id_seq START WITH 1;

CREATE SEQUENCE store_id_seq START WITH 1;

CREATE SEQUENCE users_id_seq START WITH 1;

CREATE SEQUENCE screen_type_id_seq START WITH 1;

CREATE SEQUENCE rom_type_id_seq START WITH 1;

CREATE SEQUENCE central_stock_id_seq START WITH 1;

CREATE SEQUENCE sale_id_seq START WITH 1;

CREATE SEQUENCE sale_details_id_seq START WITH 1;

CREATE SEQUENCE transfert_id_seq START WITH 1;

CREATE SEQUENCE reference_id_seq START WITH 1;
CREATE SEQUENCE receipt_id_seq START WITH 1;
CREATE SEQUENCE commission_id_seq START WITH 1;


CREATE TABLE brand (
	id integer DEFAULT nextval('brand_id_seq' :: regclass) NOT NULL,
	name varchar(50) NOT NULL,
	actif BOOLEAN NOT NULL DEFAULT true,
	CONSTRAINT pk_brand_id PRIMARY KEY (id)
);

CREATE TABLE processor (
	id integer DEFAULT nextval('processor_id_seq' :: regclass) NOT NULL,
	name varchar(100) NOT NULL,	
	actif BOOLEAN NOT NULL DEFAULT true,
	CONSTRAINT pk_processor_id PRIMARY KEY (id)
);

CREATE TABLE "role" (
	id integer DEFAULT nextval('role_id_seq' :: regclass) NOT NULL,
	name varchar(100) NOT NULL,
	CONSTRAINT pk_table_id PRIMARY KEY (id)
);

CREATE TABLE rom_type (
	id integer DEFAULT nextval('rom_type_id_seq' :: regclass) NOT NULL,
	name varchar(100) NOT NULL,
	CONSTRAINT pk_rom_type_id PRIMARY KEY (id)
);

CREATE TABLE screen_type (
	id integer DEFAULT nextval('screen_type_id_seq' :: regclass) NOT NULL,
	name varchar(100) NOT NULL,	
	actif BOOLEAN NOT NULL DEFAULT true,
	CONSTRAINT pk_screen_type_id PRIMARY KEY (id)
);

CREATE TABLE settings (
	id integer DEFAULT nextval('settings_id_seq' :: regclass) NOT NULL,
	name varchar(100) NOT NULL,
	"value" float8 NOT NULL,
	CONSTRAINT pk_settings_id PRIMARY KEY (id)
);


CREATE TABLE store (
	id integer DEFAULT nextval('store_id_seq' :: regclass) NOT NULL,
	name varchar(100) NOT NULL,
	description text,
	address varchar(100) NOT NULL,
	role_id integer NOT NULL,
	contact varchar(15) NOT NULL,
	email varchar(100) NOT NULL,	
	actif BOOLEAN NOT NULL DEFAULT true,
	CONSTRAINT pk_store_id PRIMARY KEY (id),
	CONSTRAINT idx_store UNIQUE (email),
	CONSTRAINT fk_store_role FOREIGN KEY (role_id) REFERENCES "role"(id)
);

CREATE INDEX idx_store_0 ON store (contact);

CREATE TABLE "users" (
	id integer DEFAULT nextval('users_id_seq' :: regclass) NOT NULL,
	username varchar(100) NOT NULL,
	"password" varchar(100) NOT NULL,
	store_id integer,	
	actif BOOLEAN NOT NULL DEFAULT true,
	CONSTRAINT pk_table_id_0 PRIMARY KEY (id),
	CONSTRAINT idx_table UNIQUE (username),
	CONSTRAINT fk_users_store FOREIGN KEY (store_id) REFERENCES store(id)
);

CREATE TABLE laptop (
	id integer DEFAULT nextval('laptop_id_seq' :: regclass) NOT NULL,
	description text,
	reference varchar UNIQUE NOT NULL,
	brand_id integer NOT NULL,
	processor_id integer NOT NULL,
	screen_type_id integer NOT NULL,
	size_screen float8 NOT NULL,
	ram_size integer NOT NULL,
	rom_size integer NOT NULL,
	rom_type_id integer NOT NULL,
	image varchar(100),
	price double precision NOT NULL,	
	actif BOOLEAN NOT NULL DEFAULT true,
	purchase_price double precision NOT NULL,
	CONSTRAINT pk_laptop_id PRIMARY KEY (id),
	CONSTRAINT fk_reference_brand FOREIGN KEY (brand_id) REFERENCES brand(id),
	CONSTRAINT fk_laptop_processor FOREIGN KEY (processor_id) REFERENCES processor(id),
	CONSTRAINT fk_laptop_rom_type FOREIGN KEY (rom_type_id) REFERENCES rom_type(id),
	CONSTRAINT fk_laptop_screen_type FOREIGN KEY (screen_type_id) REFERENCES screen_type(id)
);

CREATE TABLE sale (
	id integer DEFAULT nextval('sale_id_seq' :: regclass) NOT NULL,
	client varchar(100) NOT NULL,
	date_sale date NOT NULL,
	store_id integer,
	users_id integer NOT NULL,
	remise double precision DEFAULT 0 NOT NULL,
	CONSTRAINT pk_sale_id PRIMARY KEY (id),
	CONSTRAINT fk_sale_store FOREIGN KEY (store_id) REFERENCES store(id),
	CONSTRAINT fk_sale_users FOREIGN KEY (users_id) REFERENCES "users"(id)
);

CREATE TABLE central_stock (
	id integer DEFAULT nextval('central_stock_id_seq' :: regclass) NOT NULL,
	laptop_id integer NOT NULL,
	date_add date NOT NULL,
	quantity integer not null,
	CONSTRAINT pk_central_stock_id PRIMARY KEY (id),
	CONSTRAINT fk_central_stock_laptop FOREIGN KEY (laptop_id) REFERENCES laptop(id)
);

CREATE TABLE sale_details (
	id integer DEFAULT nextval('sale_details_id_seq' :: regclass) NOT NULL,
	sale_id integer not null,
	laptop_id integer NOT NULL,
	unit_price float8 NOT NULL,
	quantity integer NOT NULL,
	CONSTRAINT pk_sale_details_id PRIMARY KEY (id),
	CONSTRAINT fk_sale_details_central_stock FOREIGN KEY (laptop_id) REFERENCES laptop(id),
	CONSTRAINT fk_sale_details_sale FOREIGN KEY (sale_id) REFERENCES sale(id)
);

CREATE TABLE transfert (
	id integer DEFAULT nextval('transfert_id_seq' :: regclass) NOT NULL,
	laptop_id integer NOT NULL,
	date_transfert date NOT NULL,
	store_id integer NOT NULL,
	users_id integer NOT NULL,
	type integer not null,
	quantity integer not null,
	--1 si transfert, 2 si renvoie
	CONSTRAINT pk_transfert_id PRIMARY KEY (id),
	CONSTRAINT fk_transfert_laptop FOREIGN KEY (laptop_id) REFERENCES laptop(id),
	CONSTRAINT fk_transfert_store FOREIGN KEY (store_id) REFERENCES store(id),
	CONSTRAINT fk_transfert_users FOREIGN KEY (users_id) REFERENCES "users"(id)
);

CREATE TABLE receipt(
	id integer DEFAULT nextval('receipt_id_seq' :: regclass) NOT NULL,
	laptop_id integer not null,
	quantity integer not null,
	date_receive DATE NOT NULL,
	store_id integer NOT NULL,
	users_id integer NOT NULL,
	transfert_id integer ,
	CONSTRAINT pk_receipt_id PRIMARY KEY (id),
	CONSTRAINT fk_receipt_laptop FOREIGN KEY (laptop_id) REFERENCES laptop(id),
	CONSTRAINT fk_receipt_store FOREIGN KEY (store_id) REFERENCES store(id),
	CONSTRAINT fk_receipt_users FOREIGN KEY (users_id) REFERENCES "users"(id),
	CONSTRAINT fk_receipt_transfert FOREIGN KEY (transfert_id) REFERENCES transfert(id)
);

CREATE TABLE commission(
	id integer DEFAULT nextval('commission_id_seq' :: regclass) NOT NULL,
	total_min DOUBLE PRECISION NOT NULL,
	total_max DOUBLE PRECISION ,
	commission DOUBLE PRECISION NOT NULL, --entre 0 et 1
	CONSTRAINT pk_commission_id PRIMARY KEY (id)
);


