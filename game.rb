require 'json'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(id, hash, author, source, label, publish_date, multiplayer, last_played_at)
    super(id, hash, author, source, label, publish_date)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  def can_be_archived?
    super && last_played_at < (Date.today - 2 * 365)
  end

  def self.load_games(filename)
    JSON.parse(File.read(filename), symbolize_names: true).map do |game_data|
      Game.new(game_data[:multiplayer], Date.parse(game_data[:last_played_at]))
    end
  end

  def self.save_games(games, filename)
    games_data = games.map do |game|
      { multiplayer: game.multiplayer, last_played_at: game.last_played_at.to_s }
    end
    File.write(filename, JSON.dump(games_data))
  end
end
