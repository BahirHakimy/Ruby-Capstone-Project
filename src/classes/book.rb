require_relative 'item'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(publish_date, publisher, cover_state, id = nil)
    super(publish_date, id)
    @publisher = publisher
    @cover_state = cover_state
  end

  def to_hash
    {
      id: @id,
      label: @label,
      publish_date: @publish_date,
      archived: @archived,
      publisher: @publisher,
      cover_state: @cover_state
    }
  end

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end