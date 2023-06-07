require 'json'
require_relative './src/classes/game'
require_relative './src/classes/item'
require_relative './src/classes/author'
require_relative './src/app'

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
  'Add an author',
  'Exit'
].freeze

def execute_selection(app, selection)
  operations = {
    2 => app.method(:list_music_albums),
    4 => app.method(:list_genres),
    8 => app.method(:add_music_album),
    9 => app.method(:add_genre)
  }
  operations[selection].call
end

def show_options
  OPTIONS.each_with_index do |option, index|
    puts "#{index + 1}: #{option}"
  end
end

def main
  app = App.new
  puts "\nWelcome to our app \n\n"
  puts "Please select an operation from the list \n\n"
  exit = false

  until exit
    show_options
    print 'Choice: '
    selection = gets.chomp.to_i
    execute_selection(app, selection) if selection < OPTIONS.length
    if selection == OPTIONS.length
      exit = true
      app.before_exit
    end
  end
end

main
