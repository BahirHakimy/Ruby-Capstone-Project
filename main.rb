# frozen_string_literal: true

require 'json'
require_relative './src/classes/game'
require_relative './src/classes/item'
require_relative './src/classes/author'
require_relative './src/app'
require 'date'
require 'securerandom'

OPTIONS = [
  'List all books',
  'List all music albums',
  'List of games',
  'List all genres',
  'List all labels',
  'List all authors',
  'Add a book',
  'Add a music album',
  'Add a genre',
  'Add a game',
  'Add a label',
  'Exit'
].freeze

def listings(app)
  {
    1 => app.method(:list_books),
    2 => app.method(:list_music_albums),
    3 => proc { app.list_games(app.games) },
    4 => app.method(:list_genres),
    5 => app.method(:list_labels),
    6 => proc { app.list_authors(app.authors) }
  }
end

def execute_selection(app, selection)
  operations = {
    7 => app.method(:add_book),
    8 => app.method(:add_music_album), 9 => app.method(:add_genre),
    10 => proc { app.add_game(app.games, app.authors) }, 11 => app.method(:add_label)
  }
  if selection < 7
    listings(app)[selection].call
  else
    operations[selection].call
  end
end

def show_options
  OPTIONS.each_with_index do |option, index|
    puts "#{index + 1}: #{option}"
  end
end

def welcome
  puts "\nWelcome to our app"
  puts "Please select an operation from the list \n\n"
  App.new
end

def main
  app = welcome
  loop do
    show_options
    print 'Choice: '
    selection = gets.chomp.to_i
    execute_selection(app, selection) if selection < OPTIONS.length
    break if selection == OPTIONS.length && app.before_exit
  end
end

main
