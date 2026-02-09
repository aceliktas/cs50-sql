-- CS50 SQL – Week 3 (Writing) 
-- Problem Set: Meteorite Cleaning (https://cs50.harvard.edu/sql/psets/3/meteorites/)

-- Task:
--   Import and clean meteorite landing data from meteorites.csv
--   into a database called meteorites.db, producing a clean
--   meteorites table with properly formatted and filtered data.

-- Final Table Requirements:
--   meteorites table must contain:
--     id        → unique ID, reassigned based on sorted order
--     name      → meteorite name
--     class     → meteorite classification
--     mass      → weight in grams (rounded to 2 decimal places)
--     discovery → "Fell" or "Found"
--     year      → year discovered
--     lat       → latitude (rounded to 2 decimal places)
--     long      → longitude (rounded to 2 decimal places)

-- Data Cleaning Requirements:
--   - Empty values must be stored as NULL.
--   - Decimal values must be rounded to hundredths.
--   - Meteorites with nametype = 'Relict' must be excluded.
--   - Final records must be sorted:
--       1. By year (oldest to newest)
--       2. By name (alphabetically for same year)
--   - IDs must be reassigned starting from 1 in sorted order.

-- Approach:
--   1. Create a temporary table (meteorites_temp) for raw CSV import.
--   2. Create the final cleaned table (meteorites) with proper types.
--   3. Import CSV into meteorites_temp.
--   4. Clean and transform data in import.sql.
--   5. Insert cleaned and sorted data into meteorites.

-- Concepts used:
--   - Table creation and schema design
--   - Data type selection (TEXT, INTEGER, REAL)
--   - Staging tables for data cleaning
--   - UPDATE statements for cleaning data
--   - ROUND() for numeric formatting
--   - INSERT INTO ... SELECT for transformation
--   - ORDER BY for deterministic ID assignment

-- How to run:

-- Step 1: Open database
--   sqlite3 meteorites.db

-- Step 2: Create tables
--   .read schema.sql

-- Step 3: Import CSV into staging table
--   .mode csv
--   .import --skip 1 meteorites.csv meteorites_temp

-- Step 4: Clean and insert final data
--   .read import.sql

-- Step 5: Verify
--   SELECT * FROM meteorites LIMIT 10;

CREATE TABLE "meteorites_temp" (
    "name" TEXT,
    "id" INTEGER,
    "nametype" TEXT,
    "class" TEXT,
    "mass" REAL,
    "discovery" TEXT,
    "year" INTEGER,
    "lat" REAL,
    "long" REAL
);

CREATE TABLE "meteorites" (
    "id" INTEGER,
    "name" TEXT,
    "class" TEXT,
    "mass" REAL,
    "discovery" TEXT,
    "year" INTEGER,
    "lat" REAL,
    "long" REAL,
    PRIMARY KEY("id")
);