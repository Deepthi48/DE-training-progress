-- Create a new database
CREATE DATABASE AirlineNormalizationDB;
GO

USE AirlineNormalizationDB;
GO

-- Create a new UNF table
CREATE TABLE AIRLINE_BOOKING_UNF_V2 (
    BookingID VARCHAR(10),
    PassengerID VARCHAR(10),
    PassengerName VARCHAR(50),
    FlightID VARCHAR(10),
    FlightName VARCHAR(100),
    PilotID VARCHAR(10),
    PilotName VARCHAR(50),
    PilotLicenseNo VARCHAR(20),
    SeatNumbers VARCHAR(50),      -- Non-atomic attribute
    Services VARCHAR(100)         -- Non-atomic attribute
);
GO

-- Insert sample data
INSERT INTO AIRLINE_BOOKING_UNF_V2
VALUES
('B01','P01','Deepthi','F01','Hyderabad-Chennai',
 'PI01','Kumar','LIC1001','A1,A2','Meal,WiFi'),

('B02','P02','Rahul','F01','Hyderabad-Chennai',
 'PI01','Kumar','LIC1001','B1,B2','Meal'),

('B03','P03','Sneha','F02','Chennai-Bangalore',
 'PI02','Ramesh','LIC1002','C1,C2,C3','WiFi,Extra Baggage'),

('B04','P04','Anil','F03','Delhi-Mumbai',
 'PI03','Suresh','LIC1003','D1,D2','Meal,Lounge Access');
GO

-- Check the data
SELECT *
FROM AIRLINE_BOOKING_UNF_V2;
GO
--1NF
SELECT
    A.BookingID,
    A.PassengerID,
    A.PassengerName,
    TRIM(S.value) AS SeatNumber,
    TRIM(V.value) AS Service
FROM AIRLINE_BOOKING_UNF_V2 A
CROSS APPLY STRING_SPLIT(A.SeatNumbers, ',') S
CROSS APPLY STRING_SPLIT(A.Services, ',') V;


--2NF
SELECT DISTINCT
    BookingID,
    PassengerID,
    PassengerName
FROM AIRLINE_BOOKING_UNF_V2
ORDER BY BookingID;

SELECT DISTINCT
    A.BookingID,
    TRIM(S.value) AS SeatNumber
FROM AIRLINE_BOOKING_UNF_V2 A
CROSS APPLY STRING_SPLIT(A.SeatNumbers, ',') S
ORDER BY A.BookingID, SeatNumber;

SELECT DISTINCT
    A.BookingID,
    TRIM(V.value) AS Service
FROM AIRLINE_BOOKING_UNF_V2 A
CROSS APPLY STRING_SPLIT(A.Services, ',') V
ORDER BY A.BookingID, Service;

--3NF
SELECT DISTINCT
    PassengerID,
    PassengerName
FROM AIRLINE_BOOKING_UNF_V2
ORDER BY PassengerID;

SELECT DISTINCT
    FlightID,
    FlightName
FROM AIRLINE_BOOKING_UNF_V2
ORDER BY FlightID;

SELECT DISTINCT
    PilotID,
    PilotName,
    PilotLicenseNo
FROM AIRLINE_BOOKING_UNF_V2
ORDER BY PilotID;


SELECT DISTINCT
    BookingID,
    PassengerID,
    FlightID,
    PilotID
FROM AIRLINE_BOOKING_UNF_V2
ORDER BY BookingID;

--BCNF
SELECT
    BookingID,
    COUNT(*) AS BookingCount
FROM AIRLINE_BOOKING_UNF_V2
GROUP BY BookingID;

SELECT
    PassengerID,
    COUNT(DISTINCT PassengerName) AS NameCount
FROM AIRLINE_BOOKING_UNF_V2
GROUP BY PassengerID;

SELECT
    FlightID,
    COUNT(DISTINCT FlightName) AS FlightNameCount
FROM AIRLINE_BOOKING_UNF_V2
GROUP BY FlightID;

SELECT DISTINCT
    A.BookingID,
    TRIM(S.value) AS SeatNumber
FROM AIRLINE_BOOKING_UNF_V2 A
CROSS APPLY STRING_SPLIT(A.SeatNumbers, ',') S
ORDER BY A.BookingID, SeatNumber;

SELECT DISTINCT
    A.BookingID,
    TRIM(V.value) AS Service
FROM AIRLINE_BOOKING_UNF_V2 A
CROSS APPLY STRING_SPLIT(A.Services, ',') V
ORDER BY A.BookingID, Service;