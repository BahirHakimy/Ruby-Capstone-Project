# frozen_string_literal: true
require 'json'
require_relative './classes/music_album'
require_relative './storage/catalog_storage'
require_relative './classes/book'

class App
  attr_reader :games, :authors, :books, :labels

  def initialize
    @storage = CatalogStorage.new
    @genres = @storage.load_genres
    @music_albums = @storage.load_albums(@genres)
    @books = @storage.load_books
    @labels = @storage.load_labels
    @games = Game.load_games('storage/game.json') # Load game data from JSON file
    @authors = Author.load_authors('storage/author.json') # Load author data from JSON file
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

  def list_books
    puts "\nBooks"
    puts '+++++++++++++++++++++++++++++++++++++++++++++++++++++++'
    puts 'No Books Yet' if @books.empty?
    @books.each do |book|
      puts "ID: #{book.id} Publish Date: #{book.publish_date} Publisher: #{book.publisher}"
    end
    puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++\n"
  end

  def list_labels
    puts "\nLabels"
    puts '+++++++++++++++++++++++++++++++++++++++++++++++++++++++'
    puts 'No Labels Yet' if @labels.empty?
    @labels.each do |label|
      puts "ID: #{label.id} Title: #{label.title} Color: #{label.color}"
    end
    puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++\n"
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
    Game.save_games(@games, 'storage/game.json') # Save game data to JSON file
    Author.save_authors(@authors, 'storage/author.json') # Save author data to JSON file
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
    @authors << author
    authors_data = @authors.map do |author|
      {id:author.id, first_name: author.first_name, last_name: author.last_name }
    end
    File.write("storage/author.json", JSON.pretty_generate(authors_data))
    author
  end

  def create_game(games, author, multiplayer, last_played_at)
    game = Game.new(generate_id('game'), 'Game', author, multiplayer, last_played_at)
    @games << game
    games_data = @games.map do |game|
      { id: game.id, genre: game.genre, multiplayer: game.multiplayer, last_played_at: game.last_played_at.to_s }
    end
    File.write("storage/game.json", JSON.pretty_generate(games_data))
    game
  end

  def generate_id(prefix)
    "#{prefix}_#{SecureRandom.hex(4)}"
  end
end
