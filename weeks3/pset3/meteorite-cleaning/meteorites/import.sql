-- Please read the "import.sql" file first.

UPDATE "meteorites_temp" SET "mass" = NULL WHERE "mass" = '';
UPDATE "meteorites_temp" SET "year" = NULL WHERE "year" = '';
UPDATE "meteorites_temp" SET "lat" = NULL WHERE "lat" = '';
UPDATE "meteorites_temp" SET "long" = NULL WHERE "long" = '';

UPDATE "meteorites_temp"
SET "mass" = ROUND("mass", 2)
WHERE "mass" != '';

UPDATE "meteorites_temp"
SET "lat" = ROUND("lat", 2)
WHERE "lat" != '';

UPDATE "meteorites_temp"
SET "long" = ROUND("long", 2)
WHERE "long" != '';

INSERT INTO "meteorites" ("name", "class", "mass", "discovery", "year", "lat", "long")
SELECT "name", "class", "mass", "discovery", "year", "lat", "long"
FROM "meteorites_temp"
WHERE "nametype" != 'Relict'
ORDER BY "year" DESC, "name" ASC;