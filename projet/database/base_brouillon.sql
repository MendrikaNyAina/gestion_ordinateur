CREATE SEQUENCE brand_id_seq START WITH 1;
CREATE SEQUENCE role_id_seq START WITH 1;
CREATE SEQUENCE settings_id_seq START WITH 1;
CREATE SEQUENCE store_id_seq START WITH 1;
CREATE SEQUENCE chipset_graphic_id_seq START WITH 1;
CREATE SEQUENCE laptop_id_seq START WITH 1;
CREATE SEQUENCE operating_system_id_seq START WITH 1;
CREATE SEQUENCE processor_id_seq START WITH 1;

CREATE  TABLE brand ( 
	id                   integer DEFAULT nextval('brand_id_seq'::regclass) NOT NULL  ,
	name                 varchar(50)  NOT NULL ,
	CONSTRAINT pk_brand_id PRIMARY KEY ( id )
 );

CREATE  TABLE "role" ( 
	id                   integer DEFAULT nextval('role_id_seq'::regclass) NOT NULL  ,
	name                 varchar(100)  NOT NULL ,
	CONSTRAINT pk_table_id PRIMARY KEY ( id )
 );

CREATE  TABLE settings ( 
	id                   integer DEFAULT nextval('settings_id_seq'::regclass) NOT NULL  ,
	name                 varchar(100)  NOT NULL ,
	"value"              double precision  NOT NULL ,
	CONSTRAINT pk_settings_id PRIMARY KEY ( id )
 );

CREATE  TABLE store ( 
	id                   integer DEFAULT nextval('store_id_seq'::regclass) NOT NULL  ,
	name                 varchar(100)  NOT NULL ,
	description          text   ,
	address              varchar(100)  NOT NULL ,
	role_id              integer  NOT NULL ,
	contact              varchar(15)  NOT NULL ,
	email                varchar(100)  NOT NULL ,
	username             varchar(100)  NOT NULL ,
	"password"           varchar(100)  NOT NULL ,
	CONSTRAINT pk_store_id PRIMARY KEY ( id ),
	CONSTRAINT idx_store UNIQUE ( email ) ,
	CONSTRAINT idx_store0 UNIQUE (contact ) ,
	CONSTRAINT idx_store1 UNIQUE (username ) ,
	CONSTRAINT fk_store_role FOREIGN KEY ( role_id ) REFERENCES "role"( id )  
 );

CREATE  TABLE chipset_graphic ( 
	ids                  integer DEFAULT nextval('chipset_graphic_id_seq'::regclass) NOT NULL  ,
	name                 varchar(100)  NOT NULL ,
	CONSTRAINT pk_chipset_graphic_ids PRIMARY KEY ( ids )
 );



CREATE  TABLE operating_system ( 
	id                   integer DEFAULT nextval('operating_system_id_seq'::regclass) NOT NULL  ,
	name                 varchar(100)  NOT NULL ,
	CONSTRAINT pk_operating_system_id PRIMARY KEY ( id )
 );

CREATE  TABLE processor ( 
	id                   integer DEFAULT nextval('processor_id_seq'::regclass) NOT NULL  ,
	name                 varchar(100)  NOT NULL ,
	CONSTRAINT pk_processor_id PRIMARY KEY ( id )
 );

 CREATE  TABLE laptop ( 
	id                   integer DEFAULT nextval('laptop_id_seq'::regclass) NOT NULL  ,
	name                 varchar(100)  NOT NULL ,
	description          text   ,
	brand_id             integer  NOT NULL ,
	processor_id         integer  NOT NULL ,
	chipset_graphic_id   integer  NOT NULL ,
	os_id                integer  NOT NULL ,
	size_screen          double precision  NOT NULL ,
	nb_core              integer  NOT NULL ,
	weight               double precision  NOT NULL ,
	image                varchar(100)   ,
	CONSTRAINT pk_laptop_id PRIMARY KEY ( id ),
	CONSTRAINT fk_laptop_brand FOREIGN KEY ( brand_id ) REFERENCES brand( id )  ,
	CONSTRAINT fk_laptop_chipset_graphic FOREIGN KEY ( chipset_graphic_id ) REFERENCES chipset_graphic( ids )  ,
	CONSTRAINT fk_laptop_operating_system FOREIGN KEY ( os_id ) REFERENCES operating_system( id )  ,
	CONSTRAINT fk_laptop_processor FOREIGN KEY ( processor_id ) REFERENCES processor( id )  
 );

CREATE  TABLE reference ( 
	id   integer DEFAULT nextval('reference_id_seq'::regclass) NOT NULL  ,
	name                 varchar(100)  NOT NULL ,
	brand_id             integer  NOT NULL ,
	processor_id         integer  NOT NULL ,
	screen_type_id       integer  NOT NULL ,
	size_screen          float8  NOT NULL ,
	ram_size             integer  NOT NULL ,
	rom_size             integer  NOT NULL ,
	rom_type_id          integer  NOT NULL ,
	CONSTRAINT pk_reference_id PRIMARY KEY ( id ),
	CONSTRAINT fk_reference_brand FOREIGN KEY ( brand_id ) REFERENCES brand( id )  ,	
	CONSTRAINT fk_laptop_processor FOREIGN KEY ( processor_id ) REFERENCES processor( id )  ,
	CONSTRAINT fk_laptop_rom_type FOREIGN KEY ( rom_type_id ) REFERENCES rom_type( id )  ,
	CONSTRAINT fk_laptop_screen_type FOREIGN KEY ( screen_type_id ) REFERENCES screen_type( id )  ,
 );
