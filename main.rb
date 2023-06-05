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

main
