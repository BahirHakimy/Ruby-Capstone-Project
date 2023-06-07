# frozen_string_literal: true

require_relative '../src/classes/music_album'
require_relative '../src/classes/item'

describe MusicAlbum do
  let(:album) { described_class.new('22-02-2012', false, 22) }
  it 'should initialize the instance correctly' do
    expect(album).to be_a_kind_of(Item)
    expect(album).to be_an_instance_of(MusicAlbum)
    expect(album.publish_date).to eq '22-02-2012'
    expect(album.id).to eq 22
  end

  context 'Can be archived' do
    it 'should return false when on_spotify is false' do
      expect(album.can_be_archived?).to be false
    end
    it 'should return true when on_spotify is true and parent returns true' do
      instance = described_class.new('22-02-2012', true, 22)
      expect(instance.can_be_archived?).to be true
    end
  end

  it 'should create a valid hash from an instance' do
    expected_hash = { id: 22, genre: nil, author: nil, source: nil, label: nil,
                      publish_date: '22-02-2012', archived: false, on_spotify: false }
    hash = album.to_hash
    expect(hash).to eql expected_hash
  end
end
