/**************************************************
** File: ramr2012.sql
** Date: 2023-03-01
** Auth: Ramkumar Rajanbabu
***************************************************
** Desc: Assignment 5
***************************************************
** Modification History
***************************************************
** Date			Author				Description 
** ----------	------------------  ---------------
** 2023-03-01	Ramkumar Rajanbabu	Started Assignment 5: Created tables and drop tables
** 2023-03-04	Ramkumar Rajanbabu	Finished Assignment 5: Added constraints and comments
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
CREATE TABLE Addresses (
	AddressID INT NOT NULL IDENTITY PRIMARY KEY,
	AddressLine1 VARCHAR(200) NOT NULL,
	AddressLine2 VARCHAR(200) NOT NULL,
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
	PersonID INT NOT NULL,
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
	ADD CONSTRAINT fkTrainingsPersons
		FOREIGN KEY (PersonID) REFERENCES Persons (PersonID)