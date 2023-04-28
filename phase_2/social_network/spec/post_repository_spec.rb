require 'post_repository'

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  it 'Gets all posts' do
    repo = PostRepository.new

    posts = repo.all

    expect(posts.length).to eq 2
    # expect(posts[0].id).to eq 1
    expect(posts[0].title).to eq 'ruby'
    expect(posts[0].content).to eq 'ruby is fun'
    expect(posts[0].views).to eq 5
    expect(posts[0].user_account_id).to eq 1

    # expect(posts[1].id).to eq 2
    expect(posts[1].title).to eq 'postgresql'
    expect(posts[1].content).to eq 'pg is confusing at first'
    expect(posts[1].views).to eq 10
    expect(posts[1].user_account_id).to eq 2
  end

  it 'gets the first post' do
    repo = PostRepository.new

    posts = repo.find(1)

    expect(posts.title).to eq 'ruby'
    expect(posts.content).to eq 'ruby is fun'
    expect(posts.views).to eq 5
    expect(posts.user_account_id).to eq 1
  end

  it 'gets the second post' do
    repo = PostRepository.new

    posts = repo.find(2)

    expect(posts.title).to eq 'postgresql'
    expect(posts.content).to eq 'pg is confusing at first'
    expect(posts.views).to eq 10
    expect(posts.user_account_id).to eq 2
  end

  it 'Creates a new user_account' do
    repo = PostRepository.new

    post = Post.new
    post.title = 'databases'
    post.content = 'databases are convenient'
    post.views = 6
    post.user_account_id = 2


    repo.create(post)
    added_post = repo.find(3)

    expect(added_post.title).to eq 'databases'
    expect(added_post.content).to eq 'databases are convenient'
    expect(added_post.views).to eq 6
    expect(added_post.user_account_id).to eq 2
    expect(repo.all.length).to eq 3
  end

  it 'Deletes an existing user account' do
    repo = PostRepository.new

    post = repo.find(1)
    id_to_delete = 1
    repo.delete(id_to_delete)

    all_posts = repo.all
    expect(all_posts).not_to include post
    expect(all_posts).not_to include 'hello123@makers.com'
    expect(all_posts).not_to include 'cool_user'
    expect(repo.all.length).to eq 1
  end

  it 'Updates an existing post' do
    repo = PostRepository.new

    outdated_post = repo.find(1)

    outdated_post.title = 'updated databases'
    outdated_post.content = 'updated databases are convenient'
    outdated_post.views = 0
    outdated_post.user_account_id = 2

    repo.update(outdated_post)

    updated_post = repo.find(1)

    expect(updated_post.title).to eq 'updated databases'
    expect(updated_post.content).to eq 'updated databases are convenient'
    expect(updated_post.views).to eq 0
    expect(updated_post.user_account_id).to eq 2
  end
end