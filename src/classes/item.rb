class Item
  attr_reader :genre, :author, :source, :lable, :published_date
  attr_accessor :archive

  def initialize(publish_date, id = nil)
    @id = id or Random.rand(1..500)
    @genre = nil
    @author = nil
    @source = nil
    @lable = nil
    @publish_date = publish_date
    @archived = false
  end

  def can_be_archived?
    publish_date <= Date.today - 10 * 365
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
