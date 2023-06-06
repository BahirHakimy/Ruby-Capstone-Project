class Item
  attr_reader :id, :genre, :author, :source, :lable, :published_date
  attr_accessor :archive


  def initialize(id, genre, author, source, lable, publish_date)
    @id = id
    @genre = genre
    @author = author
    @source = source
    @lable = lable
    @publish_date = publish_date
    @archive = false
  end

  def can_be_archived
    publish_date <= Date.today - 10 * 365
  end

  def move_to_archive
    if can_be_archived
      @archive = true
      puts 'Item has been archived'
    else
      puts 'Item cannot be archived'
    end
  end
end
