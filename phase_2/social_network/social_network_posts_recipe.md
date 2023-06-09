# posts Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: students

Columns:
id | title | content | views | user_account_id
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
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
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: posts

# Model class
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: posts

# Model class
# (in lib/post.rb)

class Post

  # Replace the attributes by your own columns.
  attr_accessor :title, :content, :views, :user_account_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: posts

# Repository class
# (in lib/post_repository.rb)

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT title, content, views, user_account_id FROM posts;

    # Returns an array of post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT title, content, views, user_account_id FROM posts WHERE id = $1;

    # Returns a single Student object.
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(post)
  # end

  # def update()
  # end

  # def delete(id)
  # end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all students

repo = PostRepository.new

posts = repo.all

posts.length # =>  2

posts[0].id # =>  1
posts[0].title # =>  'ruby'
posts[0].content # =>  'ruby is fun'
posts[0].views # =>  '5'
posts[0].user_account_id # =>  '10'

posts[1].id # =>  2
posts[1].title # =>  'postresql'
posts[1].content # =>  'pg is confusing at first'
posts[1].views # =>  '10'
posts[1].user_account_id # =>  '2'

# 2
# Get a single student

repo = PostRepository.new

posts = repo.find(1)

posts[0].title # =>  'ruby'
posts[0].content # =>  'ruby is fun'
posts[0].views # =>  '5'
posts[0].user_account_id # =>  '10'

# 3 Creates a new user_account

repo = PostRepository.new

post = Post.new
post.title = 'databases'
post.content = 'databases are convenient'
post.views = 6
post.user_account_id = 2


repo.create(post)
all_posts = repo.find(3)

added_user_account.email_address # =>'imback456@makers.co.uk'
added_user_account.username # => 'returning_user'
repo.all.length # => 3

# 4 Updates an existing post

repo = PostRepository.new

outdated_post = repo.find(1)

post = Post.new
post.title = 'updated databases'
post.content = 'updated databases are convenient'
post.views = 0
post.user_account_id = 2

outdated_post.update(post)

updated_post = repo.find(1)

updated_post.title = 'updated databases'
updated_post.content = 'updated databases are convenient'
updated_post.views = 0
updated_post.user_account_id = 2


# 5 Deletes an existing post

repo = PostRepository.new

post = repo.find(1)
id_to_delete = 1
repo.delete(id_to_delete)

all_posts = repo.all
expect(all_posts).not_to include post
expect(all_posts).not_to include 'hello123@makers.com'
expect(all_posts).not_to include 'cool_user'
# all_albums should not contain the deleted album
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->