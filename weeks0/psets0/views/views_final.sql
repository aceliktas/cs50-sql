-- CS50 SQL – Week0 (Querying)
-- Problem Set 2 – 36 Views (Final Question) (https://cs50.harvard.edu/sql/psets/0/views/)
-- Database: views.db
-- Task:
--   Identify all prints by Hiroshige that are highly visually complex.
--   "Highly visually complex" is defined as prints with entropy greater than 4.
--   Display the artist and the complexity score.
--   Rename the entropy column to "complexity_score" for clarity.
--   Sort the results from most complex to least complex.
-- Concepts used:
--   - Column aliasing using AS to provide meaningful column names
--   - Filtering rows with WHERE and multiple conditions (entropy threshold + artist)
--   - Ordering results with ORDER BY to highlight most complex prints first
SELECT "artist", "entropy" AS "complexity_score"
FROM "views"
WHERE "entropy" > 4
    AND "artist" = 'Hiroshige'
ORDER BY "complexity_score" DESC;
