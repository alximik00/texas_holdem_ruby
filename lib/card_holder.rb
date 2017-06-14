class CardHolder

  attr_reader :cards, :title

  def initialize(title=nil)
    @title = title
    @cards = []
  end

  def receive(cards)
    @cards += Array(cards)
  end

  def print(suffix=nil)
    hint = [title, suffix].compact.join(' ')
    "#{hint}: #{@cards.map(&:to_s).join(' ')}"
  end
end