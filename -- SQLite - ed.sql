-- SQLite
CREATE TABLE agency (
	id varchar(255) NOT NULL,
	"name" varchar(255) NOT NULL,
	url varchar(512) NULL,
	timezone varchar(255) NULL,
	lang varchar(20) NULL,
	phone varchar(255) NULL,
	fare_url varchar(512) NULL,
	email varchar(255) NULL,
	CONSTRAINT agency_pkey PRIMARY KEY (id)
);

CREATE TABLE route (
	id varchar(255) NOT NULL,
	agency_id varchar(255) NULL,
	short_name varchar(255) NOT NULL,
	long_name varchar(255) NOT NULL,
	description varchar(255) NULL,
	"type" int4 NULL,
	url varchar(255) NULL,
	CONSTRAINT route_pk PRIMARY KEY (id),
	CONSTRAINT route_agency_fk FOREIGN KEY (agency_id) REFERENCES agency(id)
);