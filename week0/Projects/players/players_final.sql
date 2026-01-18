-- CS50 SQL – Week 0 (Querying)
-- Problem Set 3 – Final Question
-- Database: players.db
-- Task:
--   List the first and last names of all players whose height is above average.
--   Sort first by height (tallest to shortest), then by first and last name.
-- Concepts used:
--   - Aggregate functions (AVG)
--   - Filtering with WHERE
--   - Ordering results with ORDER BY
SELECT "first_name", "last_name"
FROM "players"
WHERE "height" > (
    SELECT AVG("height") FROM "players"
)
ORDER BY "height" DESC, "first_name" ASC, "last_name" ASC;