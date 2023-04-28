-- EXAMPLE
-- (file: spec/seeds_posts.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content, views, user_account_id) VALUES ('ruby', 'ruby is fun', 5, 1);
INSERT INTO posts (title, content, views, user_account_id) VALUES ('posgresql', 'pg is confusing at first', 10, 2);