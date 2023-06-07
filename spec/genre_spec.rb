# frozen_string_literal: true

require_relative '../src/classes/genre'

describe Genre do
  let(:genre) { Genre.new('Horror', 1) }
  let(:item) { double('Item', genre: nil) }
  it 'should initialize the instance correctly' do
    expect(genre).to be_an_instance_of(Genre)
    expect(genre.name).to eq 'Horror'
    expect(genre.id).to eq 1
  end

  it "should add an item to it's list and set the genre for that item" do
    expect(item).to receive(:genre=)
    genre.add_item(item)
    expect(genre.items.length).to eq 1
  end

  it 'should create a hash from instance' do
    expected_hash = { id: genre.id, name: genre.name }
    hash = genre.to_hash
    expect(hash).to eql expected_hash
  end

  it 'should create a valid instance based on provided hash' do
    hash = { id: 1, name: 'Action' }
    instance = Genre.from_hash(hash)
    expect(instance).to be_an_instance_of Genre
    expect(instance.name).to eq 'Action'
    expect(instance.id).to eq 1
  end
end
