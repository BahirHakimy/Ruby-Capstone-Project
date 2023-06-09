require_relative './item'

# Represents a music album.
class MusicAlbum < Item
  def initialize(publish_date, on_spotify, id = nil)
    super(publish_date, id)
    @on_spotify = on_spotify
  end

  def can_be_archived?
    super && @on_spotify
  end

  def to_hash
    { id: @id, genre: @genre&.id, author: @author&.id, source: @source&.id, label: @label&.id,
      publish_date: @publish_date, archived: @archived, on_spotify: @on_spotify }
  end
end