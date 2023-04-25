require 'book_repository'

def reset_books_table
  seed_sql = File.read('spec/book_store_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store' })
  connection.exec(seed_sql)
end

RSpec.describe BookRepository do

  before(:each) do 
    reset_books_table
  end

  it 'returns the first book' do

    repo = BookRepository.new
    books = repo.all

    books.length # =>  2
    books.first.id # =>  1
    books.first.title # =>  'my book'
    books.first.author_name # =>  'Julian'
  end
end