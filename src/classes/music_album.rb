require_relative './item'
class MusicAlbum < Item
  def initialize(published_date, on_spotify, id = nil)
    super(published_date, id)
    @on_spotify = on_spotify
  end

  def can_be_archived?
    super.can_be_archived? and @on_spotify
  end

  def to_hash
    { id: @id, genre: @genre&.id, author: @author&.id, source: @source&.id, label: @label&.id,
      publish_date: @published_date, archived: @archived, on_spotify: @on_spotify }
  end
end
