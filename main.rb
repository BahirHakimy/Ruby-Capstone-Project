# frozen_string_literal: true

require_relative 'game'
require_relative 'item'
require_relative 'author'
require 'date'
require 'json'
require 'securerandom'

OPTIONS = [
  'List all books',
  'List all music albums',
  'List all movies',
  'List of games',
  'List all genres',
  'List all labels',
  'List all authors',
  'List all sources',
  'Add a book',
  'Add a music album',
  'Add a movie',
  'Add a game',
  'Exit'
].freeze

def show_options
  OPTIONS.each_with_index do |option, index|
    puts "#{index + 1}: #{option}"
  end
end

def main
  puts "\nWelcome to our app\n\n"
  exit = false
  games = []
  authors = []

  until exit
    show_options
    selection = gets.chomp.to_i

    case selection
    when 1
      puts 'Listing all books...'
      # Add the code to list all books
    when 2
      puts 'Listing all music albums...'
      # Add the code to list all music albums
    when 3
      puts 'Listing all movies...'
      # Add the code to list all movies
    when 4
      puts 'Listing all games...'
      list_games(games)
    when 5
      puts 'Listing all genres...'
      # Add the code to list all genres
    when 6
      puts 'Listing all labels...'
      # Add the code to list all labels
    when 7
      puts 'Listing all authors...'
      list_authors(authors)
    when 8
      puts 'Listing all sources...'
      # Add the code to list all sources
    when 9
      puts 'Adding a book...'
      # Add the code to add a book
    when 10
      puts 'Adding a music album...'
      # Add the code to add a music album
    when 11
      puts 'Adding a movie...'
      # Add the code to add a movie
    when 12
      puts 'Adding a game...'
      add_game(games, authors)
    when 13
      puts 'Thank you for using this app'
      exit = true
    else
      puts 'Invalid selection. Please try again.'
    end

    puts
  end
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
  print 'Multiplayer (true/false): '
  gets.chomp.downcase == 'true'
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

main
