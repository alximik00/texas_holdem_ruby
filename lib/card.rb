# no usage of Struct to keep read-only
class Card
  include Comparable

  FACES = ('2'..'9').to_a + %w(T J K Q A)
  SUITS = %w(C D S H)

  def self.array_from_string(string, separator = ' ')
    parts = string.split(separator)
    parts.map do |part|
      raise ArgumentError('Should be a string like "2C TH QS"') if part.size !=2
      Card.new(part[0], part[1])
    end
  end

  attr_reader :face_order, :suit_order, :suit
  def initialize(face_or_s, suit=nil)
    if suit.nil?
      face,suit = face_or_s.split('')
    else
      face = face_or_s
    end

    @face = face
    @suit = suit
    @face_order = FACES.index(face.to_s.upcase)
    @suit_order = SUITS.index(suit.to_s.upcase)

    raise ArgumentError.new("Face should be one of #{FACES.join(',')}") unless @face_order
    raise ArgumentError.new("Suit should be in #{SUITS.join(',')}") unless @suit_order
  end

  def <=>(a)
    @face_order <=> a.face_order
  end

  def to_s
    "#{@face}#{@suit}"
  end

  def inspect
    "<Card #{@face}#{@suit}>"
  end
end