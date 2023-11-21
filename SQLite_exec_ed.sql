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