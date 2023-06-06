require_relative 'game'
require_relative 'item'
require_relative 'author'
require 'json'

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
  puts "\n Welcome to our app \n\n"
  puts "Please select an operation from the list \n\n"
  exit = false
  until exit
    show_options
    selection = gets.chomp.to_i
    exit = true if selection == OPTIONS.length
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

def add_game(games)
  puts 'Enter game details:'
  print 'Multiplayer (true/false): '
  multiplayer = gets.chomp.downcase == 'true'
  print 'Last Played At (YYYY-MM-DD): '
  last_played_at = Date.parse(gets.chomp)

  game = Game.new(multiplayer, last_played_at)
  games << game

  puts "Game with ID #{game.id} added."
end


main
