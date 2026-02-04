-- CS50 SQL – Week 1 (Relating)
-- Problem Set 1: Packages (Devious Delivery) (https://cs50.harvard.edu/sql/psets/1/packages/)
-- Database: packages.db
-- Task:
--   Identify the destination address type and contents of the package that was delivered without a sender address.
-- Output:
--   - address_type
--   - contents
-- Concepts used:
--   - JOINs across multiple tables
--   - NULL handling with IS NULL
--   - Filtering with WHERE
SELECT "addresses"."type", "packages"."contents" 
FROM "packages"
JOIN "scans"
    ON "packages"."id" = "scans"."package_id" 
JOIN "addresses"
    ON "addresses"."id" = "packages"."to_address_id"
WHERE "from_address_id" IS NULL OR "from_address_id" LIKE '';
