require_relative 'spec_helper'

describe Game do
  let(:last_played_date) { Date.new(2010, 1, 1) }
  let(:game) { Game.new(true, last_played_date) }

  describe '#can_be_archived?' do
    context 'when last_played_at is older than 2 years' do
      let(:last_played_date) { Date.today - 2 * 365 - 1 }

      it 'returns true' do
        expect(game.can_be_archived?).to be true
      end
    end

    context 'when last_played_at is within 2 years' do
      let(:last_played_date) { Date.today }

      it 'returns false' do
        expect(game.can_be_archived?).to be false
      end
    end
  end
end
