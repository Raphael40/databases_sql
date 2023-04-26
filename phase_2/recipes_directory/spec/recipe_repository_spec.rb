require 'recipe_repository'

def reset_recipes_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before(:each) do 
    reset_recipes_table
  end

  it 'Gets all recipes' do
    repo = RecipeRepository.new
    recipes = repo.all
  
    expect(recipes.length).to eq 2
    expect(recipes.first.id).to eq 1
    expect(recipes.first.name).to eq 'Bangers and Mash'
    expect(recipes.first.cooking_time).to eq 45
    expect(recipes.first.rating).to eq 4
  end
  
  it 'gets single recipe (Bangers and Mash)' do
    repo = RecipeRepository.new
    recipes = repo.find(1)
    
    expect(recipes.name).to eq "Bangers and Mash"
    expect(recipes.cooking_time).to eq 45
    expect(recipes.rating).to eq 4
  end
  
  it 'get single album (Fish and Chips)' do
    repo = RecipeRepository.new
    recipes = repo.find(2)
    
    expect(recipes.name).to eq "Fish and Chips"
    expect(recipes.cooking_time).to eq 30
    expect(recipes.rating).to eq 5
  end
  
end
