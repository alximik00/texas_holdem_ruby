require_relative 'card'

class Deck
  attr_accessor :cards

  def initialize
    @cards = Card::FACES.product(Card::SUITS).map{|f, s| Card.new(f, s) }
    @cards.shuffle!
  end

  def size
    @cards.size
  end

  def to_s
    @cards.map(&:to_s).join(' ')
  end

  def shift
    @cards.pop
  end
end