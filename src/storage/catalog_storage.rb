require_relative './storage'
require_relative '../classes/genre'
require_relative '../classes/music_album'

class CatalogStorage
  def initialize
    @genres_key = 'genres'
    @albums_key = 'albums'
  end

  def save_genres(genres)
    Storage.save_data(genres.map { |hash| hash&.to_hash }, @genres_key)
  end

  def save_music_albums(music_albums)
    Storage.save_data(music_albums.map { |hash| hash&.to_hash }, @albums_key)
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
      genre.add_item(music_album) if genre
      music_album
    end
  end
end
