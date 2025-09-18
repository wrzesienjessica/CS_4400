-- CS4400: Introduction to Database Systems (Spring 2025)
-- Phase II: Create Table & Insert Statements [v0] Monday, February 3, 2025 @ 17:00 EST

-- Team 15
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
INSERT INTO airline (airlineID, revenue) 
VALUES
	('Delta', 53000),
	('United', 48000),
	('British Airways', 24000),
	('Lufthansa', 35000),
	('Air_France', 29000),
	('KLM', 29000),
	('Ryanair', 10000),
	('Japan Airlines', 9000),
	('China Southern Airlines', 14000),
	('Korean Air Lines', 10000),
	('American', 52000);
    
CREATE TABLE location (
	locationID VARCHAR(50) PRIMARY KEY
);

INSERT INTO location (locationID) 
VALUES  
    ('port_1'), 
    ('port_2'), 
    ('port_3'), 
    ('port_10'), 
    ('port_17'), 
    ('plane_1'), 
    ('plane_5'), 
    ('plane_8'), 
    ('plane_13'), 
    ('plane_20'), 
    ('port_12'), 
    ('port_14'), 
    ('port_15'), 
    ('port_20'), 
    ('port_4'), 
    ('port_16'), 
    ('port_11'), 
    ('port_23'), 
    ('port_7'), 
    ('port_6'), 
    ('port_13'), 
    ('port_21'), 
    ('port_18'), 
    ('port_22'), 
    ('plane_6'), 
    ('plane_18'), 
    ('plane_7'), 
    ('plane_2'), 
    ('plane_3'), 
    ('plane_4'), 
    ('port_24'), 
    ('plane_10'), 
    ('port_25'); 

CREATE TABLE airport (  
    airportID CHAR(3) PRIMARY KEY, 
    locationID VARCHAR(50), 
    airport_name CHAR(100) NOT NULL UNIQUE, 
    city CHAR(100) NOT NULL, 
    state CHAR(100) NOT NULL, 
    country CHAR(3) NOT NULL, 
    FOREIGN KEY (locationID) REFERENCES location(locationID)
		ON UPDATE CASCADE
        ON DELETE RESTRICT
); 

INSERT INTO airport (airportID, locationID, airport_name, city, state, country)
VALUES
	('ATL','port_1','Atlanta Hartsfield_Jackson International','Atlanta','Georgia','USA'),  
	('DXB','port_2','Dubai International','Dubai','Al Garhoud','UAE'), 
	('HND','port_3','Tokyo International Haneda','Ota City','Tokyo','JPN'),  
	('LHR','port_4','London Heathrow','London','England','GBR'),  
	('IST',NULL,'Istanbul International','Arnavutkoy','Istanbul','TUR'),  
	('DFW','port_6','Dallas_Fort Worth International','Dallas','Texas','USA'), ('CAN','port_7','Guangzhou International','Guangzhou','Guangdong','CHN'), ('DEN',NULL,'Denver International','Denver','Colorado','USA'), 
	('LAX',NULL,'Los Angeles International','Los Angeles','California','USA'), ('ORD','port_10','O_Hare International','Chicago','Illinois','USA'),  
	('AMS','port_11','Amsterdam Schipol International','Amsterdam','Haarlemmermeer','NLD'), ('CDG','port_12','Paris Charles de Gaulle','Roissy_en_France','Paris','FRA'), ('FRA','port_13','Frankfurt International','Frankfurt','Frankfurt_Rhine_Main','DEU'), ('MAD','port_14','Madrid Adolfo Suarez_Barajas','Madrid','Barajas','ESP'), ('BCN','port_15','Barcelona International','Barcelona','Catalonia','ESP'),  
	('FCO','port_16','Rome Fiumicino','Fiumicino','Lazio','ITA'), 
	('LGW','port_17','London Gatwick','London','England','GBR'), 
	('MUC','port_18','Munich International','Munich','Bavaria','DEU'), 
	('MDW',NULL,'Chicago Midway International','Chicago','Illinois','USA'), 
	('IAH','port_20','George Bush Intercontinental','Houston','Texas','USA'), ('HOU','port_21','William P_Hobby International','Houston','Texas','USA'), ('NRT','port_22','Narita International','Narita','Chiba','JPN'),  
	('BER','port_23','Berlin Brandenburg Willy Brandt International','Berlin','Schonefeld','DEU'), ('ICN','port_24','Incheon International Airport','Seoul','Jung_gu','KOR'), ('PVG','port_25','Shanghai Pudong International Airport','Shanghai','Pudong','CHN'); 



CREATE TABLE airplane ( 
	tail_num VARCHAR(10), 
	airlineID VARCHAR(50) NOT NULL, 
    seat_cap INT NOT NULL, 
    speed INT NOT NULL, 
    locationID VARCHAR(50), 
    plane_type VARCHAR(50), 
    maintained BOOLEAN, 
    model VARCHAR(50), 
    variant BOOLEAN, 
    FOREIGN KEY (airlineID) REFERENCES airline(airlineID)
		ON UPDATE CASCADE
        ON DELETE RESTRICT, 
    FOREIGN KEY (locationID) REFERENCES location(locationID)
		ON UPDATE CASCADE
        ON DELETE RESTRICT, 
    PRIMARY KEY (tail_num, airlineID) 
); 

INSERT INTO airplane (tail_num, airlineID, seat_cap, speed, locationID, plane_type, maintained, model, variant)
VALUES 
    ('n106js', 'Delta', 4, 800, 'plane_1', 'Airbus', NULL, NULL, FALSE),
    ('n110jn', 'Delta', 5, 800, 'plane_3', 'Airbus', NULL, NULL, FALSE),
    ('n127js', 'Delta', 4, 600, NULL, 'Airbus', NULL, NULL, TRUE),
    ('n330ss', 'United', 4, 800, NULL, 'Airbus', NULL, NULL, FALSE),
    ('n380sd', 'United', 5, 400, 'plane_5', 'Airbus', NULL, NULL, FALSE),
    ('n616lt', 'British Airways', 7, 600, 'plane_6', 'Airbus', NULL, NULL, FALSE),
    ('n517ly', 'British Airways', 4, 600, 'plane_7', 'Airbus', NULL, NULL, FALSE),
    ('n620la', 'Lufthansa', 4, 800, 'plane_8', 'Airbus', NULL, NULL, TRUE),
    ('n401fj', 'Lufthansa', 4, 300, NULL, NULL, NULL, NULL, NULL),
    ('n653fk', 'Lufthansa', 6, 600, 'plane_10', 'Airbus', NULL, NULL, FALSE),
    ('n118fm', 'Air_France', 4, 400, NULL, 'Boeing', FALSE, '777', NULL),
    ('n815pw', 'Air_France', 3, 400, NULL, 'Airbus', NULL, NULL, FALSE),
    ('n161fk', 'KLM', 4, 600, 'plane_13', 'Airbus', NULL, NULL, TRUE),
    ('n337as', 'KLM', 5, 400, NULL, 'Airbus', NULL, NULL, FALSE),
    ('n256ap', 'KLM', 4, 300, NULL, 'Boeing', FALSE, '737', NULL),
    ('n156sq', 'Ryanair', 8, 600, NULL, 'Airbus', NULL, NULL, FALSE),
    ('n451fi', 'Ryanair', 5, 600, NULL, 'Airbus', NULL, NULL, TRUE),
    ('n341eb', 'Ryanair', 4, 400, 'plane_18', 'Boeing', TRUE, '737', NULL),
    ('n353kz', 'Ryanair', 4, 400, NULL, 'Boeing', TRUE, '737', NULL),
    ('n305fv', 'Japan Airlines', 6, 400, 'plane_20', 'Airbus', NULL, NULL, FALSE),
    ('n443wu', 'Japan Airlines', 4, 800, NULL, 'Airbus', NULL, NULL, TRUE),
    ('n454gq', 'China Southern Airlines', 3, 400, NULL, NULL, NULL, NULL, NULL),
    ('n249yk', 'China Southern Airlines', 4, 400, NULL, 'Boeing', FALSE, '787', NULL),
    ('n180co', 'Korean Air Lines', 5, 600, 'plane_4', 'Airbus', NULL, NULL, FALSE),
    ('n448cs', 'American', 4, 400, NULL, 'Boeing', TRUE, '787', NULL),
    ('n225sb', 'American', 8, 800, NULL, 'Airbus', NULL, NULL, FALSE),
    ('n553qn', 'American', 5, 800, 'plane_2', 'Airbus', NULL, NULL, FALSE);

CREATE TABLE route (
	routeID VARCHAR(50) PRIMARY KEY,
    legs VARCHAR(1000) NOT NULL
);

INSERT INTO route (routeID, legs) 
VALUES
	('americas_hub_exchange', 'leg_4:ATL-->ORD:600mi'),
	('americas_one', 'leg_2:ATL-->AMS:3900mi, leg_1:AMS-->BER:400mi'),
	('americas_three', 'leg_31:ORD-->CDG:3700mi, leg_14:CDG-->MUC:400mi'),
	('americas_two', 'leg_3:ATL-->LHR:3700mi, leg_22:LHR-->BER:600mi'),
	('big_europe_loop', 'leg_23:LHR-->MUC:500mi, leg_29:MUC-->FCO:400mi, leg_16:FCO-->MAD:800mi, leg_25:MAD-->CDG:600mi, leg_13:CDG-->LHR:200mi'),
	('euro_north', 'leg_16:FCO-->MAD:800mi, leg_24:MAD-->BCN:300mi, leg_5:BCN-->CDG:500mi, leg_14:CDG-->MUC:400mi, leg_27:MUC-->BER:300mi, leg_8:BER-->LGW:600mi'),
	('euro_south', 'leg_21:LGW-->BER:600mi, leg_9:BER-->MUC:300mi, leg_28:MUC-->CDG:400mi, leg_11:CDG-->BCN:500mi, leg_6:BCN-->MAD:300mi, leg_26:MAD-->FCO:800mi'),
	('germany_local', 'leg_9:BER-->MUC:300mi, leg_30:MUC-->FRA:200mi, leg_17:FRA-->BER:300mi'),
	('pacific_rim_tour', 'leg_7:BER-->CAN:4700mi, leg_10:CAN-->HND:1600mi, leg_18:HND-->NRT:100mi'),
	('south_euro_loop', 'leg_16:FCO-->MAD:800mi, leg_24:MAD-->BCN:300mi, leg_5:BCN-->CDG:500mi, leg_12:CDG-->FCO:600mi'),
	('texas_local', 'leg_15:DFW-->IAH:200mi, leg_20:IAH-->HOU:100mi, leg_19:HOU-->DFW:300mi'),
	('korea_direct', 'leg_32:DFW-->ICN:6800mi');


CREATE TABLE unused_legs ( 
	legID CHAR(50) PRIMARY KEY, 
    distance INT NOT NULL, 
    departure_airport CHAR(3) NOT NULL, 
    arrival_airport CHAR(3) NOT NULL 
); 

INSERT INTO unused_legs (legID, distance, departure_airport, arrival_airport) 
VALUES
	('leg_33', 4400, 'ICN', 'LHR'),
	('leg_34', 5900, 'ICN', 'LAX'),
	('leg_35', 3700, 'CDG', 'ORD'),
	('leg_36', 100, 'NRT', 'HND'),
	('leg_37', 500, 'PVG', 'ICN'),
	('leg_38', 6500, 'LAX', 'PVG');

CREATE TABLE flight (
    flightID VARCHAR(10) CHECK (flightID REGEXP '^[a-z]{2}_[0-9]{2}') PRIMARY KEY,
    tail_num VARCHAR(10),
    support_airlineID VARCHAR(50) NOT NULL,
    progress DECIMAL(5,2) DEFAULT 0,
    airplane_status VARCHAR(20) NOT NULL,
    next_time TIME NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    routeID VARCHAR(50) NOT NULL,
    FOREIGN KEY (tail_num, support_airlineID) REFERENCES airplane(tail_num, airlineID)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (routeID) REFERENCES route(routeID)
		ON UPDATE CASCADE
        ON DELETE RESTRICT
); 

INSERT INTO flight (flightID, tail_num, support_airlineID, progress, airplane_status, next_time, cost, routeID)
VALUES 
    ('dl_10', 'n106js', 'Delta', 1.00, 'in_flight', '08:00:00', 200.00, 'americas_one'),
    ('un_38', 'n380sd', 'United', 2.00, 'in_flight', '14:30:00', 200.00, 'americas_three'),
    ('ba_61', 'n616lt', 'British Airways', 0.00, 'on_ground', '09:30:00', 200.00, 'americas_two'),
    ('lf_20', 'n620la', 'Lufthansa', 3.00, 'in_flight', '11:00:00', 300.00, 'euro_north'),
    ('km_16', 'n161fk', 'KLM', 6.00, 'in_flight', '14:00:00', 400.00, 'euro_south'),
    ('ba_51', 'n517ly', 'British Airways', 0.00, 'on_ground', '11:30:00', 100.00, 'big_europe_loop'),
    ('ja_35', 'n305fv', 'Japan Airlines', 1.00, 'in_flight', '09:30:00', 300.00, 'pacific_rim_tour'),
    ('ry_34', 'n341eb', 'Ryanair', 0.00, 'on_ground', '15:00:00', 100.00, 'germany_local'),
    ('aa_12', 'n553qn', 'American', 1.00, 'on_ground', '12:15:00', 150.00, 'americas_hub_exchange'),
    ('dl_42', 'n110jn', 'Delta', 0.00, 'on_ground', '13:45:00', 220.00, 'texas_local'),
    ('ke_64', 'n180co', 'Korean Air Lines', 0.00, 'on_ground', '16:00:00', 500.00, 'korea_direct'),
    ('lf_67', 'n653fk', 'Lufthansa', 6.00, 'on_ground', '21:23:00', 900.00, 'euro_north');



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

INSERT INTO pilot (personID, first_name, last_name, locationID, taxID, experience, licenses, flightID) 
VALUES
	('p19', 'Doug', 'Fowler', 'port_17', '386-39-7881', 2, 'airbus', NULL),
	('p2', 'Roxanne', 'Byrd', 'port_1', '842-88-1257', 9, 'airbus, boeing', 'dl_10'),
	('p3', 'Tanya', 'Nguyen', 'port_1', '750-24-7616', 11, 'airbus', 'un_38'),
	('p8', 'Bennie', 'Palmer', 'port_2', '701-38-2179', 12, 'boeing', 'ry_34'),
	('p14', 'Dana', 'Perry', 'port_3', '454-71-7847', 13, 'airbus', 'km_16'),
	('p7', 'Sonya', 'Owens', 'port_2', '450-25-5617', 13, 'airbus', 'lf_20'),
	('p9', 'Marlene', 'Warner', 'port_3', '936-44-6941', 13, 'airbus, boeing, general', 'lf_20'),
	('p10', 'Lawrence', 'Morgan', 'port_3', '769-60-1266', 15, 'airbus', 'lf_20'),
	('p11', 'Sandra', 'Cruz', 'port_3', '369-22-9505', 22, 'airbus, boeing', 'km_16'),
	('p18', 'Esther', 'Pittman', 'plane_10', '250-86-2784', 23, 'airbus', 'lf_67'),
	('p13', 'Bryant', 'Figueroa', 'port_3', '513-40-4168', 24, 'airbus', 'km_16'),
	('p12', 'Dan', 'Ball', 'port_3', '680-92-5329', 24, 'boeing', 'ry_34'),
	('p4', 'Kendra', 'Jacobs', 'port_1', '776-21-8098', 24, 'airbus, boeing', 'un_38'),
	('p5', 'Jeff', 'Burton', 'port_1', '933-93-2165', 27, 'airbus', 'ba_61'),
	('p16', 'Edna', 'Brown', 'port_10', '598-47-5172', 28, 'airbus', 'ja_35'),
	('p20', 'Thomas', 'Olson', 'port_17', '522-44-3098', 28, 'airbus', NULL),
	('p15', 'Matt', 'Hunt', 'port_10', '153-47-8101', 30, 'airbus, boeing, general', 'ja_35'),
	('p1', 'Jeanne', 'Nelson', 'port_1', '330-12-6907', 31, 'airbus', 'dl_10'),
	('p17', 'Ruby', 'Burgess', 'plane_3', '865-71-6800', 36, 'airbus, boeing', 'dl_42'),
	('p6', 'Randal', 'Parks', 'port_1', '707-84-4555', 38, 'airbus, boeing', 'ba_61');

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

INSERT INTO passenger (personID, first_name, last_name, funds, miles, locationID, vacations)
VALUES 
    ('p21', 'Mona', 'Harrison', 700.00, 771, 'plane_1', 'AMS'),
    ('p22', 'Arlene', 'Massey', 200.00, 374, 'plane_1', 'AMS'),
    ('p23', 'Judith', 'Patrick', 400.00, 414, 'plane_1', 'BER'),
    ('p24', 'Reginald', 'Rhodes', 500.00, 292, 'plane_5', 'MUC, CDG'),
    ('p25', 'Vincent', 'Garcia', 300.00, 390, 'plane_5', 'MUC'),
    ('p26', 'Cheryl', 'Moore', 600.00, 302, 'plane_5', 'MUC'),
    ('p27', 'Michael', 'Rivera', 400.00, 470, 'plane_8', 'BER'),
    ('p28', 'Luther', 'Matthews', 400.00, 208, 'plane_8', 'LGW'),
    ('p29', 'Moses', 'Parks', 700.00, 292, 'plane_13', 'FCO, LHR'),
    ('p30', 'Ora', 'Steele', 500.00, 686, 'plane_13', 'FCO, MAD'),
    ('p31', 'Antonio', 'Flores', 400.00, 547, 'plane_13', 'FCO'),
    ('p32', 'Glenn', 'Ross', 500.00, 257, 'plane_13', 'FCO'),
    ('p33', 'Irma', 'Thomas', 600.00, 564, 'plane_20', 'CAN'),
    ('p34', 'Ann', 'Maldonado', 200.00, 211, 'plane_20', 'HND'),
    ('p35', 'Jeffrey', 'Cruz', 500.00, 233, 'port_12', 'LGW'),
    ('p36', 'Sonya', 'Price', 400.00, 293, 'port_12', 'FCO'),
    ('p37', 'Tracy', 'Hale', 700.00, 552, 'port_12', 'FCO, LGW, CDG'),
    ('p38', 'Albert', 'Simmons', 700.00, 812, 'port_14', 'MUC'),
    ('p39', 'Karen', 'Terry', 400.00, 541, 'port_15', 'MUC'),
    ('p40', 'Glen', 'Kelley', 700.00, 441, 'port_20', 'HND'),
    ('p41', 'Brooke', 'Little', 300.00, 875, 'port_3', NULL),
    ('p42', 'Daryl', 'Nguyen', 500.00, 691, 'port_4', NULL),
    ('p43', 'Judy', 'Willis', 300.00, 572, 'port_14', NULL),
    ('p44', 'Marco', 'Klein', 500.00, 572, 'port_15', NULL),
    ('p45', 'Angelica', 'Hampton', 500.00, 663, 'port_16', NULL),
    ('p46', 'Janice', 'White', 5000.00, 690, 'plane_10', 'LGW');