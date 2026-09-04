CREATE DATABASE RaceDay;
USE RaceDay;

--this turns a single users table into a role-based system like we've been asked in the assignment
CREATE TABLE Roles (
role_id INT IDENTITY(1,1) PRIMARY KEY,
rolename VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE users (
user_id INT IDENTITY(1,1) PRIMARY KEY,
role_id INT NOT NULL,
fullname VARCHAR(50) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
password VARCHAR(200) NOT NULL,
number VARCHAR(20) NULL,
created_at DATETIME NOT NULL DEFAULT GETDATE(),
CONSTRAINT FK_Users_Roles FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);


CREATE TABLE events (
event_id INT IDENTITY(1,1) PRIMARY KEY,
user_id INT NOT NULL,
title VARCHAR(100) NOT NULL,
location VARCHAR(150) NOT NULL,
eventdate DATETIME NOT NULL,
description VARCHAR(MAX) NULL,
created_at DATETIME NOT NULL DEFAULT GETDATE(),CONSTRAINT FK_Events_Users FOREIGN KEY (user_id) REFERENCES users(user_id)
);


CREATE TABLE categories (
category_id INT IDENTITY(1,1) PRIMARY KEY,
event_id INT NOT NULL,
categoryname VARCHAR(50) NOT NULL,
distanceKm DECIMAL(5,2) NOT NULL,
entryfee DECIMAL(10,2) NOT NULL DEFAULT 0.00,
CONSTRAINT FK_Categories_Events FOREIGN KEY (event_id) REFERENCES events(event_id)
);


CREATE TABLE EventRegistrations (
registration_id INT IDENTITY(1,1) PRIMARY KEY,
participant_id INT NOT NULL,
category_id INT NOT NULL,
registrationdate DATETIME NOT NULL DEFAULT GETDATE(),
status VARCHAR(20) NOT NULL DEFAULT 'Confirmed'
 CHECK (status IN ('Pending', 'Confirmed', 'Cancelled')),
CONSTRAINT FK_Registrations_Users FOREIGN KEY (participant_id) REFERENCES users(user_id),
CONSTRAINT FK_Registrations_Categories FOREIGN KEY (category_id) REFERENCES categories(category_id),
CONSTRAINT UQ_Registration_Participant_Category UNIQUE (participant_id, category_id)
);

CREATE TABLE results (
result_id INT IDENTITY(1,1) PRIMARY KEY,
registration_id INT NOT NULL UNIQUE,
finishTime TIME NULL,
position INT NULL,
status VARCHAR(20) NOT NULL DEFAULT 'DNF'
 CHECK (status IN ('Finished', 'DNF', 'DQ')),
CONSTRAINT FK_Results_Registrations FOREIGN KEY (registration_id) REFERENCES EventRegistrations(registration_id)
);

INSERT INTO Roles (rolename) VALUES ('Organiser'), ('Participant');

INSERT INTO users (role_id, fullname, email, password, number) VALUES
(1, 'Sindi Dlomo', 'sindi@raceday.co.za', 'bangtan777', '0821234567'),
(1, 'Bernado Faria', 'bernado@raceday.co.za', 'bangtan777', '0837654321'),
(2, 'Likhona Zilwa', 'likhona@raceday.co.za', 'bangtan777', '0791112222'),
(2, 'Thabo Mokoena', 'thabo@raceday.co.za', 'bangtan777', '0723334444');

INSERT INTO events (user_id, title, location, eventdate, description) VALUES
(1, 'Joburg City Marathon', 'Johannesburg', '2026-10-15 06:00:00', 'Annual road running event in Gauteng.'),
(1, 'Soweto 10km Challenge', 'Soweto', '2026-11-20 07:00:00', 'Fast and flat township route.'),
(2, 'East London Trail Run', 'East London', '2026-12-05 06:30:00', 'Scenic coastal trail run.');

INSERT INTO categories (event_id, categoryname, distanceKm, entryfee) VALUES
(1, '42km Full Marathon', 42.20, 350.00),
(1, '21km Half Marathon', 21.10, 250.00),
(2, '10km Road Marathon', 10.00, 150.00),
(3, '15km Beach Marathon', 15.00, 200.00);

INSERT INTO EventRegistrations (participant_id, category_id, status) VALUES
(3, 1, 'Confirmed'),
(3, 3, 'Confirmed'),
(4, 2, 'Confirmed'),
(4, 4, 'Pending');

INSERT INTO results (registration_id, finishTime, position, status) VALUES
(1, '03:45:10', 8, 'Finished'),
(2, '00:52:30', 3, 'Finished');
