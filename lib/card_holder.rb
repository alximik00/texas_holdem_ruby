class CardHolder

  attr_reader :cards, :title

  def initialize(title=nil)
    @title = title
    @cards = []
  end

  def receive(cards)
    @cards += Array(cards)
  end
end