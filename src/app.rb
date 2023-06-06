require_relative './classes/music_album'
require_relative './storage/catalog_storage'

class App
  def initialize
    @storage = CatalogStorage.new
    @genres = @storage.load_genres
    @music_albums = @storage.load_albums(@genres)
  end

  def list_music_albums
    puts 'Music Albums'
    puts '+++++++++++++++++++++++++++++++++++++++++++++++++++++++'
    @music_albums.each do |album|
      puts "ID: #{album.id} Publish Date: #{album.published_date}"
    end
    puts '+++++++++++++++++++++++++++++++++++++++++++++++++++++++'
  end

  def list_genres
    puts 'Genres'
    puts '+++++++++++++++++++++++++++++++++++++++'
    @genres.each do |hash|
      puts "ID: #{hash.id} Name: #{genre.name}"
    end
    puts '+++++++++++++++++++++++++++++++++++++++'
  end

  def add_music_album
    puts 'Please enter the following info'
    print 'Published Date (DD-MM-YYYY): '
    published_date = gets.chomp
    print 'On Spotify (Y/N): '
    on_spotify = gets.chomp
    MusicAlbum.new(published_date, on_spotify)
    puts 'Music Album created successfully'
  end

  def add_genre
    puts 'Please enter the following info'
    print 'Name: '
    name = gets.chomp
    Genre.new(name)
    puts 'Genre created successfully'
  end

  def before_exit
    @storage.save_genres
    @storage.save_music_albums
  end
end
