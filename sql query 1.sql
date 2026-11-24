CREATE DATABASE AERODB;
GO 
USE AERODB;

CREATE TABLE Passengers(
    PassengerID INT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL, 
    LastName VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20)
);

CREATE TABLE Aerocraft(
     Air_id INT Primary key,
     Air_name Varchar(50) NOT NULL,
     capacity INT CHECK(Capacity > 0)
     );

CREATE TABLE Flight
(
    FlightID INT PRIMARY KEY,
    FlightNumber VARCHAR(20) NOT NULL,
    SourceCity VARCHAR(50),
    DestinationCity VARCHAR(50),
    DepartureTime DATETIME,

    Air_id INT,

    FOREIGN KEY (Air_id)
    REFERENCES Aerocraft(Air_id)
);

CREATE TABLE Booking
(
    BookingID INT PRIMARY KEY,
    PassengerID INT NOT NULL,
    FlightID INT NOT NULL,
    BookingDate DATETIME DEFAULT GETDATE(),
    SeatNumber VARCHAR(10),

    FOREIGN KEY (PassengerID)
    REFERENCES Passengers(PassengerID),

    FOREIGN KEY (FlightID)
    REFERENCES Flight(FlightID)
);

INSERT INTO Booking
VALUES
(1,1,101,GETDATE(),'A1'),

(2,1,102,GETDATE(),'B2'),

(3,2,101,GETDATE(),'A2'),

(4,3,103,GETDATE(),'C1');

SELECT * FROM Passengers;

INSERT INTO Passengers
VALUES
(1,'Rahul','Kumar','rahul@gmail.com','9876543210'),
(2,'Priya','Reddy','priya@gmail.com','9876543211'),
(3,'Arjun','Sharma','arjun@gmail.com','9876543212'),
(4,'Sneha','Patel','sneha@gmail.com','9876543213');

INSERT INTO Aerocraft
VALUES
(1,'Boeing 737',180),
(2,'Airbus A320',220),
(3,'Boeing 777',300);

Select * from Aerocraft;

INSERT INTO Flight
VALUES
(101,'AI101','Hyderabad','Delhi','2026-12-01 08:00:00',1),

(102,'AI102','Delhi','Mumbai','2026-12-01 10:00:00',2),

(103,'AI103','Mumbai','Chennai','2026-12-01 12:00:00',3);

Select * from Flight;

INSERT INTO Booking
VALUES
(1,1,101,GETDATE(),'A1'),

(2,1,102,GETDATE(),'B2'),

(3,2,101,GETDATE(),'A2'),

(4,3,103,GETDATE(),'C1');

SELECT
    P.FirstName,
    P.LastName,
    F.FlightNumber,
    B.SeatNumber
FROM Passengers P
JOIN Booking B
    ON P.PassengerID = B.PassengerID
JOIN Flight F
    ON B.FlightID = F.FlightID;

SELECT DISTINCT
    P.PassengerID,
    P.FirstName,
    P.LastName
FROM Passengers P
JOIN Booking B
    ON P.PassengerID = B.PassengerID;

SELECT *
FROM Flight
WHERE SourceCity = 'Hyderabad';

SELECT
    PassengerID,
    COUNT(*) AS NumberOfBookings
FROM Booking
GROUP BY PassengerID;

SELECT
    F.FlightNumber,
    A.Air_name
FROM Flight F
JOIN Aerocraft A
    ON F.Air_id = A.Air_id;

select * from Passengers;
select * from Aerocraft;
select * from Booking;

exec sp_help Booking;

