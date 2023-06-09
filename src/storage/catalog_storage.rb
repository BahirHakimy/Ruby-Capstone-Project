# frozen_string_literal: true

require_relative './storage'
require_relative '../classes/genre'
require_relative '../classes/music_album'
require_relative '../classes/book'
require_relative '../classes/label'
require_relative '../classes/game'
require_relative '../classes/author'

# Represents the catalogstorage of the application.
class CatalogStorage
  def initialize
    @genres_key = 'genres'
    @albums_key = 'albums'
    @books_key = 'books'
    @labels_key = 'labels'
    @authors_key = 'authors'
    @games_key = 'games'
  end

  def save_genres(genres)
    Storage.save_data(genres.map { |hash| hash&.to_hash }, @genres_key)
  end

  def save_music_albums(music_albums)
    Storage.save_data(music_albums.map { |hash| hash&.to_hash }, @albums_key)
  end

  def save_books(books)
    Storage.save_data(books.map(&:to_hash), @books_key)
  end

  def save_labels(labels)
    Storage.save_data(labels.map(&:to_hash), @labels_key)
  end

  def load_genres
    data = Storage.load_data(@genres_key)
    return [] unless data

    data.map do |hash|
      Genre.from_hash(hash)
    end
  end

  def load_albums(genres)
    data = Storage.load_data(@albums_key)
    return [] unless data

    data.map do |hash|
      music_album = MusicAlbum.new(hash.values[5], hash.values[7], hash.values[0])
      genre = genres.find do |gen|
        gen.id == hash.values[1]
      end
      genre&.add_item(music_album)
      music_album
    end
  end

  def load_books
    data = Storage.load_data(@books_key)
    return [] unless data

    data.map { |hash| Book.new(hash['publish_date'], hash['publisher'], hash['cover_state'], hash['id']) }
  end

  def load_labels
    data = Storage.load_data(@labels_key)
    return [] unless data

    data.map { |hash| Label.new(hash['id'], hash['title'], hash['color']) }
  end

  def load_authors
    data = Storage.load_data(@authors_key)
    return [] unless data

    data.map do |author_data|
      Author.new(author_data['id'], author_data['first_name'], author_data['last_name'])
    end
  end

  def save_authors(authors)
    authors_data = authors.map do |author|
      { id: author.id, first_name: author.first_name, last_name: author.last_name }
    end
    Storage.save_data(authors_data, @authors_key)
  end

  def load_games
    data = Storage.load_data(@games_key)
    return [] unless data

    data.map do |game_data|
      Game.new(nil, nil, nil, game_data['multiplayer'], Date.parse(game_data['last_played_at']))
    end
  end

  def save_games(games)
    games_data = games.map do |game|
      { multiplayer: game.multiplayer, last_played_at: game.last_played_at.to_s }
    end
    Storage.save_data(games_data, @games_key)
  end
end
