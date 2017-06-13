require_relative 'card'

class Hand
  include Comparable
  RANKS = Hash[* %w(1 2 22 3 s f fh 4 sf).each_with_index.flat_map{|s,i| [s, i] } ] #map of ranks: {sf: 0, 4: 1, ...etc}

  attr_reader :player, :cards

  def initialize(player, table=nil)
    @player = player
    if table
      @cards = player.cards + table.cards
    else
      @cards = player.cards
    end
    raise ArgumentError.new('Should have maximum 7 cards') if @cards.size > 7

    @cards = @cards.sort_by {|c| c.face_order }
  end

  def <=>(other)
    self_rank = self.combination
    other_rank = other.combination

    self_rank = RANKS[ self_rank[0] ]
    other_rank = RANKS[ other_rank[0] ]

    return self_rank <=> other_rank if self_rank != other_rank
    self.highest_face_order <=> other.highest_face_order
  end

  def highest_face_order
    @cards.last.face_order
  end

  protected
  # Returns combination name and it's highest card that can be used to compare same rank hands
  def combination
    face_histogram = histogram( @cards.map(&:face_order) )
    suit_histogram = histogram( @cards.map(&:suit) )
    ordered = self.longest_ordered
    rank_face = face_histogram.sort_by {|f,s| s }.last[0]

    return ['sf', ordered.last]   if ordered.size >= 5 && suit_histogram.values.detect{|s| s >= 5 }
    return ['4',  rank_face]      if face_histogram.values.include?(4)
    return ['fh', ordered.last]   if face_histogram.values.include?(3) && face_histogram.values.include?(2)
    return ['f',  flush_highest(suit_histogram)]   if suit_histogram.values.detect{|s| s >= 5 }

    return ['s', ordered.last]    if ordered.size >= 5
    return ['3',  highest_tuple(face_histogram,3)] if face_histogram.values.include?(3)
    return ['22', highest_tuple(face_histogram)]   if face_histogram.values.select{|s| s == 2}.size >= 2
    return ['2',  highest_tuple(face_histogram)]   if face_histogram.values.include?(2)
    ['1', @cards.last.face_order]
  end

  def longest_ordered
    @cards.map(&:face_order).uniq.slice_when { |i, j| i + 1 != j }.sort_by{|a| a.size}.last
  end

  def flush_highest(suit_histogram)
    suit = suit_histogram.detect{|v, s| s >= 5 }[0]
    @cards.select{|c| c.suit == suit}.sort_by{|c| -c.face_order }.first.face_order
  end

  def highest_tuple(face_histogram, order=2) #highest pair or highest triple
    face_histogram.select{|f,s| s >= order }.map{|f,s| f}.max
  end

  def ordered?(faces)
    faces.each_cons(2).all?{|a,b| b == a+1 }
  end

  def histogram(ar)
    Hash[*ar.group_by{ |v| v }.flat_map{ |k, v| [k, v.size] }]
  end

end