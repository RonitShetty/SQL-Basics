CREATE DATABASE TRANSPORTATION;
USE DATABASE TRANSPORTATION;
CREATE SCHEMA SMART;
USE SCHEMA SMART;

CREATE OR REPLACE TABLE BUSES (
    bus_id INT PRIMARY KEY,
    bus_number VARCHAR(50),
    capacity INT,
    assigned_route_id INT
);

CREATE OR REPLACE TABLE ROUTES (
    route_id INT PRIMARY KEY,
    route_name VARCHAR(50),
    start_point VARCHAR(50),
    end_point VARCHAR(50),
    distance_km FLOAT
);

CREATE OR REPLACE TABLE DRIVERS (
    driver_id INT PRIMARY KEY,
    name VARCHAR(100),
    license_number VARCHAR(50),
    experience_years INT
);

CREATE OR REPLACE TABLE SCHEDULES (
    schedule_id INT PRIMARY KEY,
    bus_id INT,
    driver_id INT,
    departure_time TIME,
    arrival_time TIME,
    trip_date DATE
);

CREATE OR REPLACE TABLE PASSENGERS (
    passenger_id INT PRIMARY KEY,
    name VARCHAR(100),
    gender VARCHAR(20),
    age INT
);

CREATE OR REPLACE TABLE TICKETS (
    ticket_id INT PRIMARY KEY,
    passenger_id INT,
    schedule_id INT,
    fare NUMBER(10, 2),
    purchase_time TIMESTAMP
);

SHOW TABLES;



