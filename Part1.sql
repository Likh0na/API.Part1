CREATE DATABASE RaceDay;
USE RaceDay;

CREATE TABLE Roles (
role_id INT IDENTITY(1,1) PRIMARY KEY,
rolename VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE users (
user_id INT PRIMARY KEY IDENTITY(1,1),
fullname VARCHAR(50) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
password VARCHAR(200) NOT NULL,
);

CREATE TABLE events (
event_id INT PRIMARY KEY IDENTITY(1,1),
user_id INT NOT NULL,
title VARCHAR(100) NOT NULL,
location VARCHAR(150) NOT NULL,
eventdate DATETIME NOT NULL,
description VARCHAR(MAX) NULL,
);

CREATE TABLE categories (
category_id INT PRIMARY KEY IDENTITY(1,1),
event_id INT NOT NULL,
categoryname VARCHAR(50) NOT NULL,
distanceKm DECIMAL(5,2) NOT NULL,
entryfee DECIMAL(10,2) NOT NULL DEFAULT 0.00,
);

CREATE TABLE EventRegistrations (
registration_id INT PRIMARY KEY IDENTITY(1,1),
participant_id INT NOT NULL,
category_id INT NOT NULL,
registrationdate DATETIME DEFAULT GETDATE(),
);

CREATE TABLE results (
result_id INT PRIMARY KEY IDENTITY(1,1),
registration_id INT NOT NULL UNIQUE,
finishTime VARCHAR(20) NOT NULL, 
Rank INT NULL,
CONSTRAINT FK_Results_Registrations FOREIGN KEY (registration_id) REFERENCES EventRegistrations(registration_id)
);

INSERT INTO Roles (RoleName) VALUES ('Organiser'), ('Participant');

INSERT INTO users (fullname, email, password) VALUES 
('Sindi Dlomo', 'sindi@raceday.co.za', 'bangtan777'),
('Bernado Faria', 'bernado@raceday.co.za', 'bangtan777'),
('Likhona Zilwa', 'likhona@raceday.co.za', 'bangtan777'),
('Thabo Mokoena', 'thabo@raceday.co.za', 'bangtan777');

INSERT INTO Events (user_id, title, location, eventdate, description) VALUES
(1, 'Joburg City Marathon', 'Johannesburg', '2026-10-15 06:00:00', 'Annual road running event in Gauteng.'),
(1, 'Soweto 10km Challenge', 'Soweto', '2026-11-20 07:00:00', 'Fast and flat township route.'),
(2, 'East London Trail Run', 'East London', '2026-12-05 06:30:00', 'Scenic coastal trail run.');

INSERT INTO Categories (categoryname, distanceKm, entryfee) VALUES
('42km Full Marathon', 42.20, 350.00),
('21km Half Marathon', 21.10, 250.00),
('10km Road Race', 10.00, 150.00),
('15km Coastal Trail', 15.00, 200.00);