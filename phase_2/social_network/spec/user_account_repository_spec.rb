require 'user_account_repository'

def reset_user_accounts_table
  seed_sql = File.read('spec/seeds_user_accounts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe UserAccountRepository do
  before(:each) do 
    reset_user_accounts_table
  end

  it 'Gets all user_accounts' do
    repo = UserAccountRepository.new

    user_accounts = repo.all

    expect(user_accounts.length).to eq 2
    expect(user_accounts[0].id).to eq 1
    expect(user_accounts[0].email_address).to eq 'hello123@makers.com'
    expect(user_accounts[0].username).to eq 'cool_user'

    expect(user_accounts[1].id).to eq 2
    expect(user_accounts[1].email_address).to eq 'goodbye789@makers.com'
    expect(user_accounts[1].username).to eq 'employed_user'
  end

  it 'Gets the first user_account by id' do
    repo = UserAccountRepository.new

    user_accounts = repo.find(1)

    expect(user_accounts.id).to eq 1
    expect(user_accounts.email_address).to eq 'hello123@makers.com'
    expect(user_accounts.username).to eq 'cool_user'
  end

  it 'Gets the second user_account by id' do
    repo = UserAccountRepository.new

    user_accounts = repo.find(2)

    expect(user_accounts.id).to eq 2
    expect(user_accounts.email_address).to eq 'goodbye789@makers.com'
    expect(user_accounts.username).to eq 'employed_user'
  end

  it 'Creates a new user_account' do
    repo = UserAccountRepository.new

    new_user_account = UserAccount.new
    new_user_account.email_address = 'imback456@makers.co.uk'
    new_user_account.username = 'returning_user'

    repo.create(new_user_account)
    added_user_account = repo.find(3)

    #expect(all_user_accounts).to include new_user_account
    expect(added_user_account.email_address).to eq 'imback456@makers.co.uk'
    expect(added_user_account.username).to eq 'returning_user'
    expect(repo.all.length).to eq 3
  end

  it 'Deletes an existing user_account' do
    repo = UserAccountRepository.new

    user_account = repo.find(1)
    id_to_delete = 1
    repo.delete(id_to_delete)

    all_user_accounts = repo.all
    expect(all_user_accounts).not_to include user_account
    expect(all_user_accounts).not_to include 'hello123@makers.com'
    expect(all_user_accounts).not_to include 'cool_user'
    expect(repo.all.length).to eq 1
    # all_albums should not contain the deleted album
  end
end