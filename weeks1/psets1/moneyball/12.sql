-- CS50 SQL – Week 1 (Relating)
-- Problem Set 3 – Final Question
-- Database: moneyball.db
-- Task:
--   Identify players who rank among:
--     - The 10 least expensive players per hit, and
--     - The 10 least expensive players per RBI
--   during the 2001 season.
-- Output:
--   - first_name
--   - last_name
-- Assumptions:
--   - Each player has exactly one salary and one performance record in 2001.
-- Concepts used:
--   - Subqueries with IN
--   - JOINs across multiple tables
--   - Derived metrics (salary per hit, salary per RBI)
--   - Filtering and ordering
--   - Set intersection logic

SELECT "first_name", "last_name"
FROM "players"
WHERE "id" IN (
    SELECT "players"."id"
    FROM "players"
    JOIN "salaries" ON "salaries"."player_id" = "players"."id"
    JOIN "performances" ON "performances"."player_id" = "players"."id"
    WHERE "salaries"."year" = 2001
      AND "performances"."year" = 2001
      AND "performances"."H" > 0
    ORDER BY "salaries"."salary" / "performances"."H" ASC
    LIMIT 10
)
AND "id" IN (
    SELECT "players"."id"
    FROM "players"
    JOIN "salaries" ON "salaries"."player_id" = "players"."id"
    JOIN "performances" ON "performances"."player_id" = "players"."id"
    WHERE "salaries"."year" = 2001
      AND "performances"."year" = 2001
      AND "performances"."RBI" > 0
    ORDER BY "salaries"."salary" / "performances"."RBI" ASC
    LIMIT 10
)
ORDER BY "id";