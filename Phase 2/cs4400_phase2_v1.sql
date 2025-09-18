-- CS4400: Introduction to Database Systems (Spring 2025)
-- Phase II: Create Table & Insert Statements [v0] Monday, February 3, 2025 @ 17:00 EST

-- Team 15
-- Version 3
-- Aja Sampath (asampath35)
-- Colin Wright (cwright316)
-- Kaitlyn Moreira (kmoreira6)
-- Jessica Wrzesien (jwzresien6)

-- Directions:
-- Please follow all instructions for Phase II as listed on Canvas.
-- Fill in the team number and names and GT usernames for all members above.
-- Create Table statements must be manually written, not taken from an SQL Dump file.
-- This file must run without error for credit.

/* This is a standard preamble for most of our scripts.  The intent is to establish
a consistent environment for the database behavior. */
set global transaction isolation level serializable;
set global SQL_MODE = 'ANSI,TRADITIONAL';
set names utf8mb4;
set SQL_SAFE_UPDATES = 0;

set @thisDatabase = 'airline_management';
drop database if exists airline_management;
create database if not exists airline_management;
use airline_management;

-- Define the database structures
/* You must enter your tables definitions, along with your primary, unique and foreign key
declarations, and data insertion statements here.  You may sequence them in any order that
works for you.  When executed, your statements must create a functional database that contains
all of the data, and supports as many of the constraints as reasonably possible. */

CREATE TABLE airline (
	airlineID VARCHAR(50) PRIMARY KEY,
    revenue INT
);

CREATE TABLE location (
	locationID VARCHAR(50) PRIMARY KEY
);

CREATE TABLE airport (  
    airportID CHAR(3) PRIMARY KEY, 
    locationID VARCHAR(50) NOT NULL, 
    airport_name CHAR(100) NOT NULL UNIQUE, 
    city CHAR(100) NOT NULL, 
    state CHAR(100) NOT NULL, 
    country CHAR(100) NOT NULL, 
    FOREIGN KEY (locationID) REFERENCES location(locationID)
		ON UPDATE CASCADE
        ON DELETE RESTRICT
); 

CREATE TABLE leg ( 
	legID CHAR(50) PRIMARY KEY, 
    distance INT NOT NULL, 
    departure_airport CHAR(3) NOT NULL, 
    arrival_airport CHAR(3) NOT NULL, 
    FOREIGN KEY (departure_airport) REFERENCES airport(airportID)
		ON UPDATE CASCADE
        ON DELETE RESTRICT, 
    FOREIGN KEY (arrival_airport) REFERENCES airport(airportID) 
		ON UPDATE CASCADE
        ON DELETE RESTRICT
); 

CREATE TABLE airplane ( 
	tail_num VARCHAR(50), 
	airlineID VARCHAR(50) NOT NULL, 
    seat_cap INT NOT NULL, 
    speed INT NOT NULL, 
    locationID VARCHAR(50), 
    plane_type VARCHAR(50), 
    maintained BOOLEAN, 
    model VARCHAR(50), 
    variant VARCHAR(10), 
    FOREIGN KEY (airlineID) REFERENCES airline(airlineID)
		ON UPDATE CASCADE
        ON DELETE RESTRICT, 
    FOREIGN KEY (locationID) REFERENCES location(locationID)
		ON UPDATE CASCADE
        ON DELETE RESTRICT, 
    PRIMARY KEY (tail_num, airlineID) 
); 

CREATE TABLE route (
	routeID VARCHAR(50) PRIMARY KEY,
    legID VARCHAR(50) NOT NULL,
    sequence VARCHAR(50),
    FOREIGN KEY (legID) REFERENCES leg(legID)
		ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE flight (
    flightID VARCHAR(10) CHECK (flightID REGEXP '^[a-z]{2}_[0-9]{2}') PRIMARY KEY,
    tail_num VARCHAR(10),
    support_airlineID VARCHAR(50) NOT NULL,
    progress INT DEFAULT 0,
    airplane_status VARCHAR(20) NOT NULL,
    next_time DATETIME NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    routeID VARCHAR(50) NOT NULL,
    FOREIGN KEY (tail_num, support_airlineID) REFERENCES airplane(tail_num, airlineID)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (routeID) REFERENCES route(routeID)
		ON UPDATE CASCADE
        ON DELETE RESTRICT
); 

CREATE TABLE pilot (
    personID VARCHAR(50) PRIMARY KEY NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    locationID VARCHAR(50),
    taxID CHAR(11) NOT NULL CHECK (taxID REGEXP '^[0-9]{3}-[0-9]{2}-[0-9]{4}'),
    experience INT NOT NULL,
    flightID VARCHAR(5),
    licenses VARCHAR(255),
    FOREIGN KEY (flightID) REFERENCES flight(flightID)
		ON UPDATE CASCADE
        ON DELETE SET NULL,
	FOREIGN KEY (locationID) REFERENCES location(locationID)
		ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE passenger ( 
    personID VARCHAR(50) PRIMARY KEY, 
    first_name VARCHAR(50) NOT NULL, 
    last_name VARCHAR(50) NOT NULL, 
    funds DECIMAL(10,2) DEFAULT 0, 
    miles INT DEFAULT 0, 
    locationID VARCHAR(50),
    vacations VARCHAR(255),
    FOREIGN KEY (locationID) REFERENCES location(locationID) 
		ON UPDATE CASCADE
        ON DELETE RESTRICT
); 
