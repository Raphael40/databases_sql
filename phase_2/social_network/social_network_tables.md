# Two Tables Design Recipe Template

_Copy this recipe template to design and create two related database tables from a specification._

## 1. Extract nouns from the user stories or specification

```

I'd like to have a user account with my email address.

I'd like to have a user account with my username.

I'd like to create posts associated with my user account.

I'd like each of my posts to have a title and a content.

I'd like each of my posts to have a number of views.
```

```
Nouns:

user_account, post, email_address, username, content, views, title
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| user_account          | email_address, username
| post                  | title, content, views, user_id

1. Name of the first table (always plural): `user_accounts` 

    Column names: `email_address`, `username`

2. Name of the second table (always plural): `posts` 

    Column names: `title`, `content`, `views`, `user_id`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: user_accounts
id: SERIAL
email_address: text
username: text

Table: posts
id: SERIAL
title: text
content: text
views: int
user_id: int
```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one [user_account] have many [posts]? (Yes)
2. Can one [post] have many [user_accounts]? (No)

-> Therefore, the foreign key is on the posts table.
```

*If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).*

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: user_accounts_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE user_accounts (
  id SERIAL PRIMARY KEY,
  email_address: text,
  username: text
);

-- Then the table with the foreign key second.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title: text
  content: text
  views: int
  user_id: int
  user_account_id int,
  constraint fk_user_account foreign key(user_account_id)
    references user_accounts(id)
    on delete cascade
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 social_network < user_accounts_table.sql
```

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Ftwo_table_design_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Ftwo_table_design_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Ftwo_table_design_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Ftwo_table_design_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Ftwo_table_design_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->