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
	agency_id varchar(255) NOT NULL,     
	agency_name varchar(255) NOT NULL, 
	agency_url varchar(512) NULL,        
	agency_timezone varchar(255) NULL,   
	agency_lang varchar(20) NULL,        
	agency_phone varchar(255) NULL,      
	PRIMARY KEY (agency_id)              
);

CREATE TABLE route (
	agency_id varchar(255) NULL,          
	route_id varchar(255) NOT NULL,       
	route_short_name varchar(255) NOT NULL,     
	route_long_name varchar(255) NOT NULL,      
	route_type int4 NOT NULL,
	route_color varchar(255) NULL,
	route_text_color varchar(255) NULL,            
	PRIMARY KEY (route_id), 
	FOREIGN KEY (agency_id) REFERENCES agency(agency_id) 
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
	date date NOT NULL,
    exception_type int4 NOT NULL,
    CONSTRAINT calendar_date_pkey PRIMARY KEY (service_id),
	CONSTRAINT service_id FOREIGN KEY (service_id) REFERENCES calendar(service_id),
	CONSTRAINT calendar_date_service_id_date_feed_id_key UNIQUE (service_id, date)
);

CREATE TABLE trip (
	route_id varchar(255) NOT NULL,
	trip_id varchar(255) NOT NULL,
	trip_headsign varchar(255) NULL,
	service_id varchar(255) NOT NULL,
    direction_id int4 NULL,
	shape_id varchar(255) NULL,
	whellchair_accessible int4 NULL,
	bikes_allowed int4 NULL,
	CONSTRAINT trip_pkey PRIMARY KEY (trip_id)
	CONSTRAINT route_id FOREIGN KEY (route_id) REFERENCES route(route_id)
	CONSTRAINT service_id FOREIGN KEY (service_id) REFERENCES calendar(service_id)
);	

CREATE TABLE stop (
	stop_id int4 NOT NULL UNIQUE,
	stop_code int4 NOT NULL,
	stop_name varchar(255) NULL,
	stop_lat int4 NOT NULL,
	stop_lon int4 NOT NULL,
	zone_id int4 NULL,
	location_type varchar(255) NULL,
	parent_station int4 NULL,
	wheelchair_boarding int4 NULL,
	PRIMARY KEY (stop_id)
);

CREATE TABLE stop_time (
	trip_id varchar(255) NOT NULL,
	stop_id int  NOT NULL,
	arrival_time DATETIME NOT NULL,
	departure_time DATETIME NOT NULL,
	stop_sequence str NOT NULL,	
	pickup_type int4 NULL,
	PRIMARY KEY (stop_id, trip_id)
	FOREIGN KEY (trip_id) REFERENCES trip(trip_id)
	FOREIGN KEY (stop_id) REFERENCES stop(stop_id)
);	

CREATE TABLE fare_rules (
	fare_id varchar(256) NOT NULL,
	route_id varchar(256) NOT NULL,
	origin_id int,
	destination_id int,
	constrains_id int,
	PRIMARY KEY (fare_id)
	FOREIGN KEY (route_id) REFERENCES route(route_id)
);

CREATE TABLE fare_attributes (
	fare_id varchar(256) NOT NULL,
	price float,
	currency_type varchar(256),
	payment_method int,
	transfers int,
	transfer_duration int,
	PRIMARY KEY (fare_id)
);

