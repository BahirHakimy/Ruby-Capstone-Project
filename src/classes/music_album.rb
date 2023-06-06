require_relative './item'
class MusicAlbum < Item
  def initialize(published_date, on_spotify)
    super(published_date)
    @on_spotify = on_spotify
  end

  def can_be_archived?
    super.can_be_archived? and @on_spotify
  end
end
