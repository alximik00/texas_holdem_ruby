require 'spec_helper'

RSpec.describe CombinationDetector do
  def combination_name(string)
    CombinationDetector.new(Card.array_from_string(string)).combination[:key]
  end

  def combination_highest(string)
    CombinationDetector.new(Card.array_from_string(string)).combination[:cards][0]
  end

  describe 'combination name' do
    specify { expect( combination_name('2S 3S 4S 5S 6S AD 5C') ).to eq(:straight_flush) }
    specify { expect( combination_name('2d 3d 4d 5d 6c 7d 8d') ).to eq(:flush) }

    specify { expect( combination_name('TS TC TH TD 9S AS JC') ).to eq(:four) }
    specify { expect( combination_name('TS TC TH 9S 9H AS JC') ).to eq(:full_house) }
    specify { expect( combination_name('TS 2S 3S 6S 9S AS JC') ).to eq(:flush) }
    specify { expect( combination_name('5S 6D 7S 4H 3S 5C 3D') ).to eq(:straight) }
    specify { expect( combination_name('5S 6D 5D 4H 5C AD QS') ).to eq(:three) }
    specify { expect( combination_name('5S 5D 7H 3H 3S AD QS') ).to eq(:two_pairs) }
    specify { expect( combination_name('5S 5D 7H 3H 3S 6D JH') ).to eq(:two_pairs) }

    specify { expect( combination_name('2S 6D 7S 4H 2S JS 3D') ).to eq(:pair) }
    specify { expect( combination_name('5S 6D 7S QH 3S 5C AD') ).to eq(:pair) }
    specify { expect( combination_name('2S 6D 7S 4H AS 9D QS') ).to eq(:highest) }

    specify { expect( combination_name('AD KC 9D 8D 6D 5S 4D') ).to eq(:flush) }
  end

  describe 'combination highest card' do
    specify { expect( combination_highest('2S 3S 4S 5S 6S AD 5C') ).to eq( Card.new('6S')) }
    specify { expect( combination_highest('TS TC TH TD 9S AS JC') ).to eq( Card.new('TH')) }
    specify { expect( combination_highest('TS TC TH JS JH AS JC') ).to eq( Card.new('JS')) }
    specify { expect( combination_highest('TS 2S 3S 6S 9S AS JC') ).to eq( Card.new('AS')) } # flush, Ace highest

    specify { expect( combination_highest('5S 6D 7S 4H 3S 5C 3D') ).to eq( Card.new('7S')) } # straight, 7 highest
    specify { expect( combination_highest('5S 6D 5D 4H 5C AD QS') ).to eq( Card.new('5D')) } # triple
    specify { expect( combination_highest('5S 5D 7H 3H 3S AD QS') ).to eq( Card.new('5S')) } # 2 pairs, 5 highest
    specify { expect( combination_highest('5S 5D 7H 3H 3S JD JH') ).to eq( Card.new('JD')) } # 2 pairs, Jack highest

    specify { expect( combination_highest('2S 6D 7S 4H 2D JS 3D') ).to eq( Card.new('2D')) } # pair, 2 highest
    specify { expect( combination_highest('5S 6D 7S QH 3S 5C AD') ).to eq( Card.new('5S')) } # pair, 5 highest
    specify { expect( combination_highest('2S 6D 7S 4H AS 9D QS') ).to eq( Card.new('AS')) } # top card, Ace highest
  end
end