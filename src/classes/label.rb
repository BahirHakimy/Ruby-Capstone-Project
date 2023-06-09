# class to represent a label
class Label
  attr_accessor :id, :title, :color, :items

  def initialize(id, title, color)
    @id = id
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    items << item
  end

  def to_hash
    {
      id: id,
      title: title,
      color: color,
      items: items.map(&:id)
    }
  end
end
