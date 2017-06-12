# no usage of Struct to keep read-only
class Card
  include Comparable

  FACES = ('2'..'9').to_a + %w(T J K Q A)
  SUITS = %w(C D S H)

  attr_reader :face_order, :suit_order
  def initialize(face, suit)
    @face = face
    @suit = suit
    @face_order = FACES.index(face.to_s.upcase)
    @suit_order = SUITS.index(suit.to_s.upcase)

    raise ArgumentError.new("Face should be one of #{FACES.join(',')}") unless @face_order
    raise ArgumentError.new("Suit should be in #{SUITS.join(',')}") unless @suit_order
  end

  def <=>(a)
    return self.suit_order <=> a.suit_order if self.face_order == a.face_order
    self.face_order <=> a.face_order
  end

  def to_s
    "#{@face}#{@suit}"
  end
end