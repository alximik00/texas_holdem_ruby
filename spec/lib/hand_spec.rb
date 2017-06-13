require 'spec_helper'

RSpec.describe Hand do
  describe 'initialize' do
    it 'creates hand from player and table' do
      player = CardHolder.new
      table = CardHolder.new

      player.receive( [Card.new('A', 'H'), Card.new('T', 'S')])
      table.receive( [Card.new('2', 'H'), Card.new('3', 'S'), Card.new('4', 'C') ])
      expect( Hand.new( player, table).cards.size ).to eq(5)
    end

    it 'creates hand from one card holder only' do
      holder = CardHolder.new
      holder.receive( [Card.new('A', 'H'), Card.new('T', 'S')])
      expect( Hand.new( holder).cards.size ).to eq(2)
    end
  end

  describe '.combination' do
    def combination(string)
      holder = CardHolder.new
      holder.receive( Card.array_from_string(string) )
      Hand.new( holder ) .send(:combination)
    end

    specify { expect( combination('2S 3S 4S 5S 6S') ).to eq('SF') }
    specify { expect( combination('TS TC TH TD 9S') ).to eq('4') }
    specify { expect( combination('TS TC TH 9S 9H') ).to eq('FH') }
    specify { expect( combination('TS 2S 3S 6S 9S') ).to eq('F') }
    specify { expect( combination('5S 6D 7S 4H 3S') ).to eq('S') }
    specify { expect( combination('5S 6D 5D 4H 5C') ).to eq('3') }
    specify { expect( combination('5S 5D 7H 3H 3S') ).to eq('22') }
    specify { expect( combination('2S 6D 7S 4H 2S') ).to eq('2') }
    specify { expect( combination('2S 6D 7S 4H AS') ).to eq('1') }
  end

end
