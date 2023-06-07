require_relative './classes/music_album'
require_relative './storage/catalog_storage'

class App
  def initialize
    @storage = CatalogStorage.new
    @genres = @storage.load_genres
    @music_albums = @storage.load_albums(@genres)
  end

  def list_music_albums
    # puts @music_albums[0].publish_date
    puts "\nMusic Albums"
    puts '+++++++++++++++++++++++++++++++++++++++++++++++++++++++'
    puts 'No Albums Yet' if @music_albums.empty?
    @music_albums.each do |album|
      puts "ID: #{album.id} Publish Date: #{album.publish_date}"
    end
    puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++\n"
  end

  def list_genres
    puts "\nGenres"
    puts '+++++++++++++++++++++++++++++++++++++++'
    puts 'No Genres Yet' if @genres.empty?
    @genres.each do |genre|
      puts "ID: #{genre.id} Name: #{genre.name}"
    end
    puts "+++++++++++++++++++++++++++++++++++++++\n"
  end

  def add_music_album
    puts "\nPlease enter the following info"
    print 'Published Date (DD-MM-YYYY): '
    published_date = gets.chomp
    print 'On Spotify (Y/N): '
    on_spotify = gets.chomp.downcase
    @music_albums << MusicAlbum.new(published_date, on_spotify == 'y')
    puts "Music Album created successfully\n"
  end

  def add_genre
    puts "\nPlease enter the following info"
    print 'Name: '
    name = gets.chomp
    @genres << Genre.new(name)
    puts "Genre created successfully\n"
  end

  def before_exit
    @storage.save_genres(@genres)
    @storage.save_music_albums(@music_albums)
  end
end
