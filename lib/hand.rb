require_relative 'card'

class Hand
  include Comparable

  attr_reader :player
  def initialize(player, table)
    @player = player
    @cards = player.cards + table.cards
  end

  def <=>(other)
    0
  end

end