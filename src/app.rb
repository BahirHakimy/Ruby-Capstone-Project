# frozen_string_literal: true

require_relative './classes/music_album'
require_relative './storage/catalog_storage'

# Represents the application.
class App
  attr_reader :games, :authors

  def initialize
    @storage = CatalogStorage.new
    @genres = @storage.load_genres
    @music_albums = @storage.load_albums(@genres)
    @games = []
    @authors = []
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

  def list_games(games)
    games.each do |game|
      puts "Game ID: #{game.id}, Multiplayer: #{game.multiplayer}, Last Played At: #{game.last_played_at}"
    end
  end

  def list_authors(authors)
    authors.each do |author|
      puts "Author ID: #{author.id}, Name: #{author.first_name} #{author.last_name}"
    end
  end

  def add_game(games, authors)
    multiplayer = read_multiplayer
    last_played_at = read_last_played_at
    author = create_author(authors)
    game = create_game(games, author, multiplayer, last_played_at)

    puts "Game with ID #{game.id} added."
  end

  def read_multiplayer
    print 'Multiplayer (Y/N): '
    gets.chomp.downcase == 'y'
  end

  def read_last_played_at
    print 'Last Played At (YYYY-MM-DD): '
    Date.parse(gets.chomp)
  end

  def create_author(authors)
    print 'First Name: '
    first_name = gets.chomp
    print 'Last Name: '
    last_name = gets.chomp
    author = Author.new(generate_id('author'), first_name, last_name)
    authors << author
    author
  end

  def create_game(games, author, multiplayer, last_played_at)
    game = Game.new(generate_id('game'), 'Game', author, multiplayer, last_played_at)
    games << game
    game
  end

  def generate_id(prefix)
    "#{prefix}_#{SecureRandom.hex(4)}"
  end
end
