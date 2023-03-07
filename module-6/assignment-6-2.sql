/**************************************************
** File: assignment-6-2.sql
** Date: 2023-03-06
** Auth: Ramkumar Rajanbabu
***************************************************
** Desc: Assignment 6-2: DML
***************************************************
** Modification History
***************************************************
** Date			Author				Description 
** ----------	------------------  ---------------
** 2023-03-06	Ramkumar Rajanbabu	Started Assignment 6: Copied assignment 5 sql file
** 2023-03-07	Ramkumar Rajanbabu	Completed Assignment 6: Added INSERT, UPDATE, DELETES and JOINS
**************************************************/

-- **Create and Drop Database**
USE master;
GO
-- Drop the database if it already exists
IF  EXISTS (
	SELECT name 
		FROM sys.databases 
		WHERE name = N'ramr2012'
)
DROP DATABASE ramr2012;
GO
CREATE DATABASE ramr2012;
GO
USE ramr2012;
GO

-- **Drop Tables**
DROP TABLE IF EXISTS Addresses;
GO
DROP TABLE IF EXISTS Phones;
GO
DROP TABLE IF EXISTS PhoneTypes;
GO
DROP TABLE IF EXISTS Persons;
GO
DROP TABLE IF EXISTS Employees;
GO
DROP TABLE IF EXISTS Clients;
GO
DROP TABLE IF EXISTS Trainings;
GO

-- **Create Tables**
-- **1) Creates your latest database**
CREATE TABLE Addresses (
	AddressID INT NOT NULL IDENTITY PRIMARY KEY,
	AddressLine1 VARCHAR(200) NOT NULL,
	AddressLine2 VARCHAR(200) NULL,
	City VARCHAR(100) NOT NULL,
	State VARCHAR(2) NOT NULL,
	ZipCode VARCHAR(10) NOT NULL
);
GO
CREATE TABLE Phones (
	PhoneID INT NOT NULL IDENTITY PRIMARY KEY,
	PhoneTypeID INT NOT NULL,
	PhoneNumber VARCHAR(15) NOT NULL
);
GO
CREATE TABLE PhoneTypes (
	PhoneTypeID INT NOT NULL IDENTITY PRIMARY KEY,
	PhoneType VARCHAR(50) NULL
);
GO
CREATE TABLE Persons (
	PersonID INT NOT NULL IDENTITY PRIMARY KEY,
	AddressID INT NOT NULL,
	PhoneID INT NOT NULL,
	PersonType VARCHAR(50),
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL
);
GO
CREATE TABLE Employees (
	EmployeeID INT NOT NULL IDENTITY PRIMARY KEY,
	PersonID INT NOT NULL,
	EmployeeFullName VARCHAR(50) NOT NULL
);
GO
CREATE TABLE Clients (
	ClientID INT NOT NULL IDENTITY PRIMARY KEY,
	PersonID INT NOT NULL,
	ClientFullName VARCHAR(50) NOT NULL
);
GO
CREATE TABLE Trainings (
	TrainingID INT NOT NULL IDENTITY PRIMARY KEY,
	EmployeeID INT NOT NULL,
	ClientID INT NOT NULL,
	TrainingDate DATETIME NOT NULL,
	SoftwareVersion INT NOT NULL,
	TrainingType VARCHAR(50) NOT NULL,
	BillingType VARCHAR(50) NOT NULL,
	TrainingHours INT NOT NULL,
	Price MONEY NOT NULL
);
GO

-- **Add Constraints**
ALTER TABLE Phones
	ADD CONSTRAINT fkPhonesPhoneTypes
		FOREIGN KEY (PhoneTypeID) REFERENCES PhoneTypes (PhoneTypeID)
ALTER TABLE Persons
	ADD CONSTRAINT fkPersonsAddresses
		FOREIGN KEY (AddressID) REFERENCES Addresses (AddressID)
ALTER TABLE Persons
	ADD CONSTRAINT fkPersonsPhones
		FOREIGN KEY (PhoneID) REFERENCES Phones (PhoneID)
ALTER TABLE Employees
	ADD CONSTRAINT fkEmployeesPersons
		FOREIGN KEY (PersonID) REFERENCES Persons (PersonID)
ALTER TABLE Clients
	ADD CONSTRAINT fkClientsPersons
		FOREIGN KEY (PersonID) REFERENCES Persons (PersonID)
ALTER TABLE Trainings
	ADD CONSTRAINT fkTrainingsEmployees
		FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
ALTER TABLE Trainings
	ADD CONSTRAINT fkTrainingsClients
		FOREIGN KEY (ClientID) REFERENCES Clients (ClientID)

-- 2) Inserts at least 5 rows of data in every table
INSERT INTO Addresses
	(AddressLine1, AddressLine2, City, State, ZipCode)
VALUES
	('One Microsoft Way', NULL, 'Redmond', 'WA', '98052'),
	('8520 Evanston Ave N', '#101', 'Seattle', 'WA', '98103'),
	('6449 Independence Ave', NULL, 'Woodland Hills', 'CA', '91367'),
	('860 Hembry St', 'suite 401', 'Lewisville', 'TX', '75057'),
	('782 Pelham Pkwy S', NULL, 'The Bronx', 'NY', '10462')
GO
INSERT INTO PhoneTypes
	(PhoneType)
VALUES
	('Cell'),
	('Work'),
	('Home')
GO
INSERT INTO Phones
	(PhoneTypeID, PhoneNumber)
VALUES
	(2, '8887251047'),
	(1, '2066591781'),
	(3, '8778843994'),
	(1, '9722190729'),
	(1, '7188855500')
GO
INSERT INTO Persons
	(AddressID, PhoneID, PersonType, FirstName, LastName)
VALUES
	(1, 1, 'Employee', 'Bill', 'Gates'),
	(1, 1, 'Employee', 'Spencer', 'Cook'),
	(1, 1, 'Employee', 'Rylee', 'Crane'),
	(1, 1, 'Employee', 'Rosa', 'Watts'),
	(1, 1, 'Employee', 'Wade', 'Perez'),
	(2, 2, 'Client', 'Dallas', 'Valdez'),
	(3, 3, 'Client', 'Peck', 'Marcos'),
	(4, 4, 'Client', 'Kelly', 'Case'),
	(5, 5, 'Client', 'Nick', 'Reid'),
	(5, 5, 'Client', 'Lyla', 'Watkins')
GO
INSERT INTO Employees
	(PersonID, EmployeeFullName)
VALUES
	(1, 'Bill Gates'),
	(2, 'Spencer Cook'),
	(3, 'Rylee Crane'),
	(4, 'Rosa Watts'),
	(5, 'Wade Perez')
GO
INSERT INTO Clients
	(PersonID, ClientFullName)
VALUES
	(6, 'Dallas Valdez'),
	(7, 'Peck Marcos'),
	(8, 'Kelly Case'),
	(9, 'Nick Reid'),
	(10, 'Lyla Watkins')
GO
INSERT INTO Trainings
	(EmployeeID, ClientID, TrainingDate, SoftwareVersion, TrainingType, BillingType, TrainingHours, Price)
VALUES
	(1, 1, '2023-01-01', 1, 'Onsite', 'Standard Class', 3, 500.00),
	(1, 3, '2023-02-10', 3, 'Online', 'Hourly Based Class', 2, 400.00),
	(2, 4, '2023-01-15', 1, 'Onsite', 'Hourly Based Class', 1, 200.00),
	(3, 5, '2023-01-30', 2, 'Online', 'Hourly Based Class', 6, 1200.00),
	(5, 2, '2023-03-01', 1, 'Onsite', 'Standard Class', 3, 500.00)
GO

-- 3) Updates at least 2 values in any table
-- *Update BillingType Standard Class*
UPDATE Trainings 
SET Price = 300.00
WHERE BillingType = 'Standard Class';
GO
-- *Update PhoneID 3*
UPDATE Phones
SET PhoneNumber = '99919919999'
WHERE PhoneID = 3;
GO

-- 4) Deletes at least 2 values in any table
-- *Delete ClientID 5*
-- Could not delete directly from Clients table due to FOREIGN KEY CONSTRAINT
--DELETE FROM Clients
--WHERE ClientID = 5;
--GO
DELETE FROM Trainings
WHERE ClientID = 5;
GO
DELETE FROM Clients
WHERE ClientID = 5;
GO
-- *Delete TrainingID 5*
DELETE FROM Trainings
WHERE TrainingID = 5;
GO

-- 5) Joins at least 2 tables. More joins get higher grades
-- *Join Persons table and Employees table*
--SELECT * 
--FROM Persons
--INNER JOIN Employees
--ON Persons.PersonID = Employees.PersonID;
--GO
-- *Join previous query with Clients table*
--SELECT * 
--FROM Persons
--LEFT JOIN Employees
--ON Persons.PersonID = Employees.PersonID
--LEFT JOIN Clients
--ON Persons.PersonID = Clients.PersonID;
--GO
-- Join previous query with Addresses table*
--SELECT * 
--FROM Persons
--LEFT JOIN Employees
--ON Persons.PersonID = Employees.PersonID
--LEFT JOIN Clients
--ON Persons.PersonID = Clients.PersonID
--LEFT JOIN Addresses
--ON Persons.AddressID = Addresses.AddressID;
--GO
-- Join previous query with Phones table*
--SELECT * 
--FROM Persons
--LEFT JOIN Employees
--ON Persons.PersonID = Employees.PersonID
--LEFT JOIN Clients
--ON Persons.PersonID = Clients.PersonID
--LEFT JOIN Addresses
--ON Persons.AddressID = Addresses.AddressID
--LEFT JOIN Phones
--ON Persons.PhoneID = Phones.PhoneID;
--GO
-- Join previous query with PhoneTypes table*
--SELECT * 
--FROM Persons
--LEFT JOIN Employees
--ON Persons.PersonID = Employees.PersonID
--LEFT JOIN Clients
--ON Persons.PersonID = Clients.PersonID
--LEFT JOIN Addresses
--ON Persons.AddressID = Addresses.AddressID
--LEFT JOIN Phones
--ON Persons.PhoneID = Phones.PhoneID
--LEFT JOIN PhoneTypes
--ON Phones.PhoneTypeID = PhoneTypes.PhoneTypeID;
--GO
-- Cleaned up Joined Query
SELECT
	Persons.PersonID,
	Persons.PersonType,
	Employees.EmployeeFullName,
	Clients.ClientFullName,
	PhoneTypes.PhoneType,
	Phones.PhoneNumber,
	Addresses.AddressLine1,
	Addresses.AddressLine2,
	Addresses.City,
	Addresses.State,
	Addresses.ZipCode
FROM Persons
LEFT JOIN Employees
ON Persons.PersonID = Employees.PersonID
LEFT JOIN Clients
ON Persons.PersonID = Clients.PersonID
LEFT JOIN Addresses
ON Persons.AddressID = Addresses.AddressID
LEFT JOIN Phones
ON Persons.PhoneID = Phones.PhoneID
LEFT JOIN PhoneTypes
ON Phones.PhoneTypeID = PhoneTypes.PhoneTypeID;
GO

-- View Tables
SELECT * FROM Phones
SELECT * FROM Addresses
SELECT * FROM Persons
SELECT * FROM Employees
SELECT * FROM Clients
SELECT * FROM Trainings