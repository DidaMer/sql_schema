DROP TABLE IF EXISTS agency;
DROP TABLE IF EXISTS route;
DROP TABLE IF EXISTS calendar;
DROP TABLE IF EXISTS calendar_date;
DROP TABLE IF EXISTS trip;
DROP TABLE IF EXISTS stop;
DROP TABLE IF EXISTS stop_time;
DROP TABLE IF EXISTS fare_rules;
DROP TABLE IF EXISTS fare_attributes;

CREATE TABLE agency (
	id int4 NOT NULL,
	"name" varchar(255) NOT NULL,
	url varchar(512) NULL,
	timezone varchar(255) NULL,
	lang varchar(20) NULL,
	phone varchar(255) NULL,
	fare_url varchar(512) NULL,
	email varchar(255) NULL,
	CONSTRAINT agency_pk PRIMARY KEY (id)
);

CREATE TABLE route (
	id int4 NOT NULL,
	agency_id varchar(255) NULL,
	short_name varchar(255) NOT NULL,
	long_name varchar(255) NOT NULL,
	description varchar(255) NULL,
	"type" int4 NULL,
	url varchar(255) NULL,
	CONSTRAINT route_pk PRIMARY KEY (id),
	CONSTRAINT route_agency_fk FOREIGN KEY (agency_id) REFERENCES agency(id)
);

CREATE TABLE calendar (
	service_id varchar(255) NOT NULL,
	monday bool NULL,
	tuesday bool NULL,
	wednesday bool NULL,
	thursday bool NULL,
	friday bool NULL,
	saturday bool NULL,
	sunday bool NULL,
	start_date date NULL,
	end_date date NULL,
    CONSTRAINT calendar_pkey PRIMARY KEY (service_id),
	CONSTRAINT calendar_service_id_feed_id_key UNIQUE (service_id)
);


CREATE TABLE calendar_date (
	service_id varchar(255) NOT NULL,
	"date" date NOT NULL,
    exception_type int4 NOT NULL,
    CONSTRAINT calendar_date_pkey PRIMARY KEY (service_id),
	CONSTRAINT calendar_date_service_id_date_feed_id_key UNIQUE (service_id, date)
);

CREATE TABLE trip (
	trip_id varchar(255) NOT NULL,
	route_id varchar(255) NOT NULL,
	service_id varchar(255) NOT NULL,
    CONSTRAINT trip_pkey PRIMARY KEY (trip_id)
);

CREATE TABLE stop (
	stop_id int4 NOT NULL UNIQUE,
	stop_code int4 NOT NULL,
	stop_name varchar(255) NULL,
	stop_desc varchar(255) NULL,
	stop_lat int4 NOT NULL,
	stop_lon int4 NOT NULL,
	zone_id int4 NULL,
	stop_url varchar(255) NOT NULL,
	location_type varchar(255) NULL,
	wheelchair_boarding int4 NULL,
	level_id int4 NULL,
	platform_code varchar(255) NULL,	
	PRIMARY KEY (stop_id)
);

CREATE TABLE stop_time (
	stop_times_id int NOT NULL UNIQUE,
	stop_id int  NOT NULL,
	arrival_time DATETIME NOT NULL,
	departure_time DATETIME NOT NULL,
	stop_sequence str NOT NULL,	
	PRIMARY KEY (stop_times_id )
	FOREIGN KEY (stop_id) REFERENCES stop(stop_id)
);	

CREATE TABLE fare_rules (
	fare_id varchar(256) NOT NULL,
	route_id varchar(256) NOT NULL,
	origin_id int,
	destination_id int,
	constrains_id int,
	PRIMARY KEY (fare_id)
	FOREIGN KEY (route_id) REFERENCES route(id)
);

CREATE TABLE fare_attributes (
	fare_id varchar(256) NOT NULL,
	price float,
	currency_type varchar(256),
	payment_method int,
	transfers int,
	agency_id varchar(256),
	transfer_duration int,
	PRIMARY KEY (fare_id)
);

