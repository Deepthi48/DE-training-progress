SELECT DB_NAME() AS CurrentDatabase;
GO

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';
GO

select * from Passengers;
select DISTINCT LastName from Passengers;
select * from Passengers where LastName = 'Reddy';
select * from Passengers order by PassengerID DESC;
SELECT TOP 3 * FROM Passengers;

SELECT * from Passengers order by PassengerID ASC OFFSET 1 rows fetch next 3 rows only;

exec sp_help 'Flight';

select * from Flight;

SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Flights';

insert into Flight ( FlightID,FlightNumber,SourceCity, DestinationCity,DepartureTime,Air_id) values(104,'AI105', 'HYDERABAD', 'DELHI', '2026-12-02 09:00:00', 1);
UPDATE Flight SET SourceCity = 'Mumbai' where FlightID = 104;
delete from Flight where FlightID = 104;

create table FlightStatus(
Statue_ID INT PRIMARY KEY,
Flight_ID int,
status VARCHAR(30),
Remark Varchar(100));

alter table FlightStatus add Updated DATETIME;

DROP TABLE FlightStatus;

select * from Flight where FlightID > 101;

select * from Flight where SourceCity = 'Hyderabad' and DestinationCity = 'Delhi';

select * from Flight where not DestinationCity = 'Mumbai';

SELECT *
FROM Flight
WHERE FlightNumber LIKE 'AI%';

select * from Flight where SourceCity = 'Hyderabad';

select * from Flight where FlightID between 101 and 102;

select * from Flight where FlightNumber like 'AI%';

exec sp_help 'Booking';

SELECT
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Booking';

select count(*) as Totalbooking from Booking;
select min(BookingID) AS HighestBookingID from Booking;

SELECT
    COUNT(*) AS TotalBookings,
    MAX(BookingID) AS HighestBookingID,
    MIN(BookingID) AS LowestBookingID,
    SUM(BookingID) AS TotalBookingIDs,
    AVG(BookingID) AS AverageBookingID
FROM Booking;

SELECT
    SeatNumber,
    LOWER(SeatNumber) AS lowercaseSeat
FROM Booking;

SELECT
    SeatNumber,
    LEN(SeatNumber) AS SeatLength
FROM Booking;

SELECT
    CONCAT('Booking-', BookingID) AS BookingReference
FROM Booking;

SELECT GETDATE() AS CurrentDateTime;

SELECT
    BookingID,
    DAY(BookingDate) AS BookingDay
FROM Booking;

SELECT
    BookingID,
    CAST(BookingID AS VARCHAR(20)) AS BookingIDText
FROM Booking;

SELECT
    BookingDate,
    CONVERT(VARCHAR(20), BookingDate, 103) AS FormattedDate
FROM Booking;

SELECT
    Passengers.PassengerID,
    Passengers.FirstName,
    Passengers.LastName,
    Booking.BookingID,
    Booking.FlightID,
    Booking.SeatNumber
FROM Passengers
INNER JOIN Booking
ON Passengers.PassengerID = Booking.PassengerID;

SELECT
    Passengers.PassengerID,
    Passengers.FirstName,
    Passengers.LastName,
    Booking.BookingID,
    Booking.FlightID,
    Booking.SeatNumber
FROM Passengers
LEFT JOIN Booking
ON Passengers.PassengerID = Booking.PassengerID;

SELECT
    Passengers.PassengerID,
    Passengers.FirstName,
    Passengers.LastName,
    Booking.BookingID,
    Booking.FlightID,
    Booking.SeatNumber
FROM Passengers
RIGHT JOIN Booking
ON Passengers.PassengerID = Booking.PassengerID;

SELECT
    Passengers.PassengerID,
    Passengers.FirstName,
    Passengers.LastName,
    Booking.BookingID,
    Booking.FlightID,
    Booking.SeatNumber
FROM Passengers
FULL OUTER JOIN Booking
ON Passengers.PassengerID = Booking.PassengerID;

SELECT
    Passengers.PassengerID,
    Passengers.FirstName,
    Flight.FlightID,
    Flight.FlightNumber
FROM Passengers
CROSS JOIN Flight;

CREATE TABLE Employees
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    ManagerID INT NULL
);

INSERT INTO Employees VALUES
(1, 'Rahul', NULL),
(2, 'Priya', 1),
(3, 'Arjun', 1),
(4, 'Sneha', 2);

SELECT
    E.EmployeeName AS Employee,
    M.EmployeeName AS Manager
FROM Employees E
LEFT JOIN Employees M
ON E.ManagerID = M.EmployeeID;

CREATE TABLE BookingDetailsDemo
(
    BookingID INT,
    PassengerID INT,
    SeatNumber VARCHAR(10),

    PRIMARY KEY (BookingID, PassengerID)
);