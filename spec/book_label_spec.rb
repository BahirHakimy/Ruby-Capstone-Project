require_relative '../src/classes/book'
require_relative '../src/classes/label'

RSpec.describe Book do
  let(:book) { Book.new('book_1', 'Author', 'Publisher', 'Good') }

  describe '#can_be_archived?' do
    context 'when cover_state is "bad"' do
      it 'returns true' do
        book.cover_state = 'bad'
        expect(book.can_be_archived?).to be true
      end
    end

    context 'when cover_state is not "bad"' do
      it 'returns the result of the parent class method' do
        allow(book).to receive(:parent_can_be_archived?).and_return(false)
        expect(book.can_be_archived?).to be false

        allow(book).to receive(:parent_can_be_archived?).and_return(true)
        expect(book.can_be_archived?).to be true
      end
    end
  end
end

RSpec.describe Label do
  let(:label) { Label.new('label_1', 'New', 'Red') }
  let(:item) { double('Item', id: 'item_1') }

  describe '#add_item' do
    it 'adds the item to the collection' do
      expect {
        label.add_item(item)
      }.to change { label.items.length }.by(1)

      expect(label.items).to include(item)
    end
  end

  describe '#to_hash' do
    it 'returns a hash representation of the label' do
      expected_hash = {
        id: 'label_1',
        title: 'New',
        color: 'Red',
        items: ['item_1']
      }
      label.add_item(item)
      expect(label.to_hash).to eq(expected_hash)
    end
  end
end
