require 'post'

class PostRepository

  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT title, content, views, user_account_id FROM posts;'
    result_set = DatabaseConnection.exec_params(sql, [])

    posts = []

    result_set.each do |record|
      post = Post.new

      # post.id = record['id']
      post.title = record['title']
      post.content = record['content']
      post.views = record['views'].to_i
      post.user_account_id = record['user_account_id'].to_i

      posts << post
    end
    
    return posts
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