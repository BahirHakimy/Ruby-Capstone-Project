require 'date'

# Represents an item in the library.
class Item
  attr_reader :archive, :id
  attr_accessor :genre, :author, :source, :lable, :publish_date

  def initialize(publish_date, id = nil)
    @id = id || Random.rand(1..500)
    @genre = nil
    @author = nil
    @source = nil
    @lable = nil
    @publish_date = publish_date
    @archived = false
  end

  def can_be_archived?
    Date.parse(@publish_date) <= Date.today - 10 * 365
  end

  def move_to_archive
    if can_be_archived
      @archived = true
      puts 'Item has been archived'
    else
      puts 'Item cannot be archived'
    end
  end
end
