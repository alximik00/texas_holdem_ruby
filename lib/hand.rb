require_relative 'card'
require_relative 'combination_detector'

class Hand
  include Comparable
  attr_reader :player, :cards

  def initialize(player, table=nil)
    @player = player
    if table
      @cards = player.cards + table.cards
    else
      @cards = player.cards
    end
    raise ArgumentError.new('Should have maximum 7 cards') if @cards.size > 7
  end

  def <=>(other)
    self_comb = self.combination
    other_comb = other.combination

    # rank is descending
    self_rank =  -CombinationDetector::RANKS.index( self_comb[:key] )
    other_rank = -CombinationDetector::RANKS.index( other_comb[:key] )

    @resulting = self_comb
    compare_rank = (self_rank <=> other_rank)
    return compare_rank if compare_rank != 0

    compare_highest_in_rank = self_comb[:cards].map(&:face_order) <=> ( other_comb[:cards].map(&:face_order) )
    return compare_highest_in_rank if compare_highest_in_rank != 0

    @resulting = {cards: [first_non_equal_card(other)], key: :highest}
    cmp_player_cards(other)
  end

  def print
    "#{@resulting[:cards].sort_by(&:face_order).map(&:to_s).join(' ')} (#{ @resulting[:key].to_s.gsub('_', ' ') })"
  end

  def inspect
    "<Hand #{combination.inspect}>"
  end
  protected

  def cmp_player_cards(other)
    @player.cards.sort_by{|c| -c.face_order } <=> other.player.cards.sort_by{|c| -c.face_order }
  end

  def first_non_equal_card(other)
    a = @player.cards.sort_by{|c| -c.face_order }
    b = other.player.cards.sort_by{|c| -c.face_order }
    a.zip(b).detect{|i,j| i.face_order != j.face_order}[0]
  end

  # Returns combination name and it's cards
  def combination
    @combination ||= CombinationDetector.new(@cards).combination
  end

end