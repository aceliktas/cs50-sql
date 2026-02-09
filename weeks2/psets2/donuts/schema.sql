-- ERD / Design:
-- An Entity-Relationship Diagram (ERD) was used to plan the database schema.
-- Interactive ERD link: https://dbdiagram.io/d/donuts-schema-69825f3dbd82f5fce289db48

-- CS50 SQL – Week 2 (Designing)
-- Problem Set 3 – Union Square Donuts (https://cs50.harvard.edu/sql/psets/2/donuts/)
-- Database: schema.db

-- Task:
--   Design a relational database for a donut shop to track ingredients, donuts, customers, and orders.

-- Output / Representation:
--   - ingredients (name, price per unit)
--   - donuts (name, price, gluten-free status, ingredients)
--   - customers (first and last name)
--   - orders (which customer placed the order, which donuts and quantities)

-- Concepts used:
--   - Primary and foreign keys
--   - Many-to-many relationships via join tables
--   - CHECK constraints for data integrity (positive prices, quantities, boolean values)
--   - Default values for columns (e.g., gluten-free, quantity, order date)
--   - Normalization to reduce redundancy

CREATE TABLE "ingredients" (
  "id" INTEGER PRIMARY KEY,
  "name" TEXT UNIQUE NOT NULL,
  "price_per_unit" NUMERIC NOT NULL CHECK("price_per_unit" > 0)
);

CREATE TABLE "donuts" (
  "id" INTEGER PRIMARY KEY,
  "name" TEXT UNIQUE NOT NULL,
  "price" NUMERIC NOT NULL CHECK("price" > 0),
  "gluten_free" BOOLEAN DEFAULT 0 CHECK("gluten_free" IN (0,1))
);

CREATE TABLE "donut_ingredients" (
  "ingredient_id" INTEGER,
  "donut_id" INTEGER,
  "quantity" INTEGER DEFAULT 1 CHECK("quantity" > 0),
  PRIMARY KEY ("donut_id", "ingredient_id"),
  FOREIGN KEY ("ingredient_id") REFERENCES "ingredients" ("id"),
  FOREIGN KEY ("donut_id") REFERENCES "donuts" ("id")
);

CREATE TABLE "customers" (
  "id" INTEGER PRIMARY KEY,
  "first_name" TEXT NOT NULL,
  "last_name" TEXT NOT NULL
);

CREATE TABLE "orders" (
  "id" INTEGER PRIMARY KEY,
  "customer_id" INTEGER NOT NULL,
  "shipping_address" TEXT NOT NULL,
  "order_date" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  FOREIGN KEY ("customer_id") REFERENCES "customers" ("id")
);

CREATE TABLE "order_donuts" (
  "order_id" INTEGER,
  "donut_id" INTEGER,
  "quantity" INTEGER NOT NULL, CHECK("quantity" > 0),
  PRIMARY KEY ("order_id", "donut_id"),
  FOREIGN KEY ("donut_id") REFERENCES "donuts" ("id"),
  FOREIGN KEY ("order_id") REFERENCES "orders" ("id")
);