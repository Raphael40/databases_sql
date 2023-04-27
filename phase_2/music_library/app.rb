require_relative 'lib/database_connection'
require_relative 'lib/artist_repository'
require_relative 'lib/album_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

# Perform a SQL query on the database and get the result set.

artist_repository = ArtistRepository.new
album_repository = AlbumRepository.new

# artist_repository.all.each do |artist|
#   p artist
# end

# album_repository.all.each do |album|
#   p album
# end

# artist = artist_repository.find(4)
# puts artist.name

new_album = Album.new
new_album.title = 'Trompe le Monde'
new_album.release_year = '1991'
new_album.artist_id = '1'

print_album = album_repository.create(new_album)
p print_album

p album_repository.all