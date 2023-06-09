require_relative '../src/classes/game'
require_relative '../src/classes/item'

RSpec.describe Game do
  let(:author) { Author.new(1, 'John', 'Doe') }
  let(:game_data) do
    [
      { multiplayer: true, last_played_at: (Date.today - 3).to_s },
      { multiplayer: false, last_played_at: (Date.today - 400).to_s }
    ]
  end
  let(:filename) { 'games.json' }

  describe '.load_games' do
    it 'loads games from a JSON file' do
      File.write(filename, JSON.dump(game_data))

      loaded_games = Game.load_games(filename)

      expect(loaded_games.map(&:multiplayer)).to eq(game_data.map { |data| data[:multiplayer] })
      expect(loaded_games.map(&:last_played_at)).to eq(game_data.map { |data| Date.parse(data[:last_played_at]) })
    end
  end

  describe '.save_games' do
    it 'saves games to a JSON file' do
      games = game_data.map { |data| Game.new(nil, nil, nil, data[:multiplayer], Date.parse(data[:last_played_at])) }

      Game.save_games(games, filename)

      loaded_data = JSON.parse(File.read(filename), symbolize_names: true)

      expect(loaded_data).to eq(game_data)
    end
  end
end