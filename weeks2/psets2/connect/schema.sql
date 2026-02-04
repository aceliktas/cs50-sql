-- CS50 SQL – Week 2 (Designing) (https://cs50.harvard.edu/sql/psets/2/connect/)
-- Problem Set 2: LinkedIn Database
-- Task:
--   Design a relational database for LinkedIn to track users, schools, companies, and connections.
-- Output:
--   - users (first name, last name, username, password)
--   - schools (name, type, location, year founded)
--   - companies (name, industry, location)
--   - education (user-school affiliations, start/end dates, degrees)
--   - employment (user-company affiliations, start/end dates, titles)
--   - connections (mutual user-to-user connections)
-- Concepts used:
--   - Primary and foreign keys
--   - Many-to-many relationships via join tables (users ↔ schools, users ↔ companies)
--   - Self-referential foreign keys for user connections
--   - CHECK constraints for data integrity (start/end dates, valid years, no self-connections)
--   - UNIQUE constraints for usernames and company names
--   - Default and normalized structure to avoid redundancy
CREATE TABLE users (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "username" TEXT NOT NULL UNIQUE,
    "password" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE schools (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    "year" INTEGER NOT NULL CHECK("year" <= DATE(CURRENT_TIMESTAMP) AND "year" > 0),
    PRIMARY KEY("id")
);

CREATE TABLE companies (
    "id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    "industry" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE education (
    "id" INTEGER,
    "user_id" INTEGER,
    "school_id" INTEGER,
    "start_date" TEXT NOT NULL CHECK(DATE("start_date") IS NOT NULL AND DATE("start_date") <= DATE(CURRENT_TIMESTAMP)),
    "end_date" TEXT CHECK(DATE("end_date") > DATE("start_date")),
    "degree" TEXT,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("school_id") REFERENCES "schools"("id")
);

CREATE TABLE employment (
    "id" INTEGER,
    "user_id" INTEGER,
    "company_id" INTEGER,
    "title" TEXT NOT NULL,
    "start_date" TEXT NOT NULL CHECK(DATE("start_date") IS NOT NULL AND DATE("start_date") <= DATE(CURRENT_TIMESTAMP)),
    "end_date" TEXT CHECK(DATE("end_date") > DATE("start_date")),
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("company_id") REFERENCES "companies"("id")
);

CREATE TABLE connections (
    "id" INTEGER,
    "user_id" INTEGER,
    "connected_user_id" INTEGER CHECK("user_id" != "connected_user_id"),
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("connected_user_id") REFERENCES "users"("id")
);