require_relative 'lib/database_connection'
require_relative 'lib/user_account_repository'
require_relative 'lib/post_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('social_network')

# Perform a SQL query on the database and get the result set.
result = UserAccountRepository.new
post = PostRepository.new
# Print out each record from the result set .

new_user_account = UserAccount.new
new_user_account.email_address = 'imback456@makers.co.uk'
new_user_account.username = 'returning_user'

result.create(new_user_account)

result.all.each do |record|
  p record.email_address
end

new_post = Post.new
new_post.title = 'databases'
new_post.content = 'databases are convenient'
new_post.views = 6
new_post.user_account_id = 2


post.create(new_post)

post.all.each do |record|
  p record.title
end