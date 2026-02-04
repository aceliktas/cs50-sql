-- CS50 SQL – Week 0 (Querying)
-- Problem Set 1 – Cyberchase (Final Question) (https://cs50.harvard.edu/sql/psets/0/cyberchase/)
-- Database: cyberchase.db
-- Task:
--   Identify episodes that aired during the U.S. holiday season (December).
-- Output:
--   Single column: episode title
-- Concepts used:
--   - WHERE conditions
--   - Pattern matching using LIKE
SELECT "title"
FROM "episodes"
WHERE "air_date"
LIKE '____-12-__';
