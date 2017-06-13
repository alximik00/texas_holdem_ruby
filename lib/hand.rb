require_relative 'card'

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
    raise ArgumentError.new('Should have maximum 7cards') if @cards.size > 7
  end

  def <=>(other)
    0
  end

  private
  def combination
    face_histogram = histogram( @cards.map(&:face_order) )
    suit_histogram = histogram( @cards.map(&:suit_order) )

    return 'SF' if ordered?(face_histogram.keys.sort) && suit_histogram.values.include?(5)
    return '4'  if face_histogram.values.include?(4)
    return 'FH' if face_histogram.values.include?(3) && face_histogram.values.include?(2)
    return 'F' if suit_histogram.values.include?(5)
    return 'S' if ordered?(face_histogram.keys.sort) && face_histogram.keys.size >= 5
    return '3'  if face_histogram.values.include?(3)
    return '22' if face_histogram.values.select{|s| s == 2}.size == 2
    return '2' if face_histogram.values.include?(2)
    '1'
    # :straight_flush, :four, :full_house, :flush, :straight, :two_pairs, :pair, :highest
  end

  def ordered?(faces)
    faces.each_cons(2).all?{|a,b| b == a+1 }
  end

  def histogram(ar)
    Hash[*ar.group_by{ |v| v }.flat_map{ |k, v| [k, v.size] }]
  end

end