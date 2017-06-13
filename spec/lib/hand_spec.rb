require 'spec_helper'

RSpec.describe Hand do
  def hand(string)
    holder = CardHolder.new
    holder.receive( Card.array_from_string(string) )
    Hand.new( holder )
  end

  def combination_name(string)
    hand(string).send(:combination)[0]
  end

  def combination_highest(string)
    hand(string).send(:combination)[1]
  end

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

  describe 'combination name' do
    specify { expect( combination_name('2S 3S 4S 5S 6S AD 5C') ).to eq('sf') }
    specify { expect( combination_name('TS TC TH TD 9S AS JC') ).to eq('4') }
    specify { expect( combination_name('TS TC TH 9S 9H AS JC') ).to eq('fh') }
    specify { expect( combination_name('TS 2S 3S 6S 9S AS JC') ).to eq('f') }
    specify { expect( combination_name('5S 6D 7S 4H 3S 5C 3D') ).to eq('s') }
    specify { expect( combination_name('5S 6D 5D 4H 5C AD QS') ).to eq('3') }
    specify { expect( combination_name('5S 5D 7H 3H 3S AD QS') ).to eq('22') }
    specify { expect( combination_name('5S 5D 7H 3H 3S 6D JH') ).to eq('22') }

    specify { expect( combination_name('2S 6D 7S 4H 2S JS 3D') ).to eq('2') }
    specify { expect( combination_name('5S 6D 7S QH 3S 5C AD') ).to eq('2') }
    specify { expect( combination_name('2S 6D 7S 4H AS 9D QS') ).to eq('1') }
  end

  describe 'combination highest card' do
    specify { expect( combination_highest('2S 3S 4S 5S 6S AD 5C') ).to eq(4) }
    specify { expect( combination_highest('TS TC TH TD 9S AS JC') ).to eq(8) }
    specify { expect( combination_highest('TS TC TH JS JH AS JC') ).to eq(9) }
    specify { expect( combination_highest('TS 2S 3S 6S 9S AS JC') ).to eq(12) } # flush, Ace highest

    specify { expect( combination_highest('5S 6D 7S 4H 3S 5C 3D') ).to eq(5) }
    specify { expect( combination_highest('5S 6D 5D 4H 5C AD QS') ).to eq(3) }
    specify { expect( combination_highest('5S 5D 7H 3H 3S AD QS') ).to eq(3) } # 2 pairs, 5 highest
    specify { expect( combination_highest('5S 5D 7H 3H 3S JD JH') ).to eq(9) } # 2 pairs, Jack highest

    specify { expect( combination_highest('2S 6D 7S 4H 2S JS 3D') ).to eq(0) } # pair, 2 highest
    specify { expect( combination_highest('5S 6D 7S QH 3S 5C AD') ).to eq(3) } # pair, 5 highest
    specify { expect( combination_highest('2S 6D 7S 4H AS 9D QS') ).to eq(12) }# top card, Ace highest
  end


  describe 'comparison' do
    specify{
      full_house = hand('TS TC TH 9S 9H 2S 3D') #fh
      straight = hand('5S 6D 7S 4H 3S 2S 3D') #s
      expect( full_house ).to be > straight
    }

    specify{
      pair = hand('2S 6D 7S 4H 2S JS 3D') #2
      straight = hand('5S 6D 7S 4H 3S 5C 3D') #s
      expect( pair ).to be < straight
    }

    specify{
      two_pairs = hand('5S 5D 7H 3H 3S 6D JH')
      pair      = hand('5S 6D 7S QH 3S 5C AD')
      expect( pair ).to be < two_pairs
    }
  end
end
