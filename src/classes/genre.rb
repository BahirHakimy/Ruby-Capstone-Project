# Represents a genre of items.
class Genre
  attr_accessor :name
  attr_reader :id, :items

  def initialize(name, id = nil)
    @id = id || Random.rand(1..500)
    @name = name
    @items = []
  end

  def add_item(item)
    @items << item
    item.genre = self
  end

  def to_hash
    { id: @id, name: @name }
  end

  def self.from_hash(hash)
    new(hash.values[1], hash.values[0])
  end
end
