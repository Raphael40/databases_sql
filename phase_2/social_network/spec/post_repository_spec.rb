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

  xit 'gets the first post' do
    repo = PostRepository.new

    posts = repo.find(1)

    posts[0].title # =>  'ruby'
    posts[0].content # =>  'ruby is fun'
    posts[0].views # =>  '5'
    posts[0].user_account_id # =>  '10'
  end
end