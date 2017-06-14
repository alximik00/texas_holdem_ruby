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

    compare_highest_in_rank = self_comb[:cards][0] <=> ( other_comb[:cards][0] )
    return compare_highest_in_rank if compare_highest_in_rank != 0

    @resulting = {cards: [highest_card], key: :highest}
    highest_card <=> other.highest_card
  end

  def print
    "#{@resulting[:cards].sort_by(&:face_order).map(&:to_s).join(' ')} (#{ @resulting[:key].to_s.gsub('_', ' ') })"
  end

  protected
  # Returns combination name and it's cards
  def combination
    @combination ||= CombinationDetector.new(@cards).combination
  end

  def highest_card
    @player.cards.sort_by(&:face_order).last
  end

end