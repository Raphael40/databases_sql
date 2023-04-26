-- EXAMPLE
-- (file: spec/seeds_recipies_directory.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE recipies RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO recipes (name, cooking_time, rating) VALUES ('Bangers and Mash', 45, 4);
INSERT INTO recipes (name, cooking_time, rating) VALUES ('Fish and Chips', 30, 5);