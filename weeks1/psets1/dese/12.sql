-- CS50 SQL – Week 1 (Relating)
-- Problem Set 2 – Final Question
-- Database: dese.db
-- Task:
--   Identify public school districts in Massachusetts with:
--     - Above-average per-pupil expenditures
--     - Above-average percentage of teachers rated "exemplary"
-- Output:
--   - district_name
--   - per_pupil_expenditure
--   - exemplary_teacher_percentage
-- Sorting:
--   - exemplary_teacher_percentage (DESC)
--   - per_pupil_expenditure (DESC)
-- Concepts used:
--   - Multi-table JOINs
--   - Subqueries with aggregate functions (AVG)
--   - Filtering with WHERE
--   - Multi-level ORDER BY
SELECT "districts"."name", "expenditures"."per_pupil_expenditure", "staff_evaluations"."exemplary"
FROM "districts"
JOIN "expenditures"
    ON "expenditures"."district_id" = "districts"."id"
JOIN "staff_evaluations"
    ON "staff_evaluations"."district_id" = "expenditures"."district_id"
WHERE "districts"."state" = 'MA'
  AND "districts"."type" = 'Public School District'
  AND "staff_evaluations"."exemplary" > (
    SELECT AVG("exemplary")
    FROM "staff_evaluations"
)
  AND "expenditures"."per_pupil_expenditure" > (
    SELECT AVG("per_pupil_expenditure")
    FROM "expenditures"
)
ORDER BY "staff_evaluations"."exemplary" DESC, "expenditures"."per_pupil_expenditure" DESC;
