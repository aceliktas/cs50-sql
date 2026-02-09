-- CS50 SQL – Week 2 (Writing) 
-- Problem Set: Don't Panic! (https://cs50.harvard.edu/sql/psets/3/dont-panic/)

-- Task:
--   Write SQL statements that:
--   1. Change the password of the admin account to "oops!" (stored as an MD5 hash).
--   2. Remove any logs that reveal this real password change.
--   3. Insert misleading log data to make it appear that the admin password 
--      was changed to the same password as user emily33.

-- Output / Effects:
--   - The admin account's password is updated in the users table.
--   - Evidence of this change is removed from the user_logs table.
--   - A fabricated log entry is inserted into user_logs to frame emily33.

-- Concepts used:
--   - UPDATE to modify existing records.
--   - DELETE to remove specific log entries.
--   - INSERT INTO ... VALUES to add fabricated records.
--   - Subqueries to retrieve values dynamically (admin’s previous password and emily33’s password).
--   - ORDER BY and LIMIT to retrieve the most recent log entry.
--   - Understanding of hashed passwords (MD5) and why plaintext passwords are not stored.

-- Notes:
--   - Passwords in the users table are stored as MD5 hashes, so the replacement 
--     password must also be provided as a hash.
--   - The order of operations matters: modify data, remove traces, then insert misleading logs.

-- HOW TO USE
-- 1. Open a terminal in this directory.
-- 2. Start SQLite with the database:
--        sqlite3 dont-panic.db
--
-- 3. Reset the database to its default state:
--        .read reset.sql
--
--    This restores the tables and data so the task can be tested repeatedly.
--
-- 4. Run the solution script:
--        .read hack.sql
--
-- 5. Verify the result manually if needed:
--        SELECT password FROM users WHERE username IN ('admin', 'emily33');
--        SELECT * FROM user_logs ORDER BY id DESC LIMIT 10;


-- Make the real change.
UPDATE "users"
SET "password" = '5d7da1e91c85be2c31acbafa312f7d5f'
WHERE "username" = 'admin';
SELECT * from "user_logs" order by "id" DESC limit 5;

-- Remove evidence.
DELETE FROM "user_logs"
WHERE "old_username" = 'admin'
  AND "type" = 'update';

-- Insert fake evidence.
INSERT INTO "user_logs" ("type", "old_username", "new_username", "old_password", "new_password")
VALUES ('update', 'admin', 'admin', (
    SELECT "new_password"
    FROM "user_logs"
    WHERE "type" = 'insert'
      AND "new_username" = 'admin'
    ORDER BY "id" DESC
    LIMIT 1
    ), (
        SELECT "password"
        FROM "users"
        WHERE "username" = 'emily33'
        )
);