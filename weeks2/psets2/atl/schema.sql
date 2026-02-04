-- CS50 SQL – Week 2 (Designing)
-- Problem Set 2: ATL Airport (https://cs50.harvard.edu/sql/psets/2/atl/)
-- Task:
--   Design a relational database for ATL airport to track passengers, airlines, concourses, flights, and check-ins.
-- Output:
--   - passengers (first name, last name, age)
--   - airlines (name)
--   - concourses (code)
--   - airline_concourses (linking airlines to concourses)
--   - flights (flight number, airline, departure/arrival airports and times)
--   - check_ins (passenger check-ins with datetime)
-- Concepts used:
--   - Primary and foreign keys
--   - Many-to-many relationships via join tables (airlines ↔ concourses)
--   - CHECK constraints for data integrity (age ≥ 0, concourse codes valid)
--   - Default values for columns (CURRENT_TIMESTAMP for check-ins)
--   - Normalization to reduce redundancy
CREATE TABLE passengers (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "age" INTEGER NOT NULL CHECK("age" >= 0),
    PRIMARY KEY("id")
);

CREATE TABLE airlines (
    "id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    PRIMARY KEY("id")
);

CREATE TABLE concourses (
    "id" INTEGER,
    "code" TEXT NOT NULL CHECK("code" IN ('A','B','C','D','E','F','T')),
    PRIMARY KEY("id")
);

CREATE TABLE airline_concourses (
    "id" INTEGER,
    "airline_id" INTEGER,
    "concourse_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("airline_id") REFERENCES "airlines"("id"),
    FOREIGN KEY("concourse_id") REFERENCES "concourses"("id")
);

CREATE TABLE flights (
    "id" INTEGER,
    "airline_id" INTEGER,
    "flight_number" INTEGER NOT NULL,
    "departure_time" TEXT NOT NULL,
    "departure_airport" TEXT NOT NULL,
    "arrival_time" TEXT NOT NULL,
    "arrival_airport" TEXT NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("airline_id") REFERENCES "airlines"("id")
);

CREATE TABLE check_ins (
    "id" INTEGER,
    "datetime" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "passenger_id" INTEGER,
    "flight_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("passenger_id") REFERENCES "passengers"("id"),
    FOREIGN KEY("flight_id") REFERENCES "flights"("id")
);