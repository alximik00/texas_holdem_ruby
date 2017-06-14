require 'spec_helper'

RSpec.describe Hand do
  def hand(string)
    holder = CardHolder.new
    holder.receive( Card.array_from_string(string) )
    Hand.new( holder )
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

    specify{
      player_a = hand('8S 8C 5H 3D 2H QH 6S')
      player_b = hand('5D TD 5H 3D 2H QH 6S')
      expect( player_a ).to be > player_b
    }

    specify{
      player_a = hand('5H 7D 6H 6S KS 7C 4C')
      player_b = hand('JH AC 6H 6S KS 7C 4C')
      #2 pairs wins 1 pair
      expect( player_a ).to be > player_b
    }

    specify{
      player_a = hand('5H 8H TH 2D JH TD 5D')
      player_b = hand('6S 9H TH 2D JH TD 5D')
      expect( player_a ).to be > player_b
    }

    specify  {
      player_a = hand('5H 8H TH 2D JH TD 5D') #2 pairs TD TH 5D 5H
      player_b = hand('2S AS TH 2D JH TD 5D') #2 pairs TD TH 2D 2S
      expect( player_a ).to be > player_b
    }

    specify {
      player_a = hand('7S KH')
      player_b = hand('2D KS')
      expect( player_a ).to be > player_b
    }

  end
end
