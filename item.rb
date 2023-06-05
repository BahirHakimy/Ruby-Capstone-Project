require 'date'

class Item
  attr_reader :genre, :author, :source, :lable, :published_date
  attr_accessor :archive


  def initialize (genre, author, source, lable, publish_date)
    @id = Random.rand(1..500)
    @genre = genre
    @author = author
    @source = source
    @lable = lable
    @publish_date = publish_date
    @archive = false
  end

  def can_be_archived(self)
    publish_date <= Date.today - 10years
  end

  def move_to_archive
    if can_be_archived
      @archive = true
      puts "Item has been archived"
    else
      puts "Item cannot be archived"
    end
  end