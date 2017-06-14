# encapsulate all that metaprogramming in single class
class CombinationDetector
  RANKS = [:straight_flush, :four, :full_house, :flush, :straight, :three, :two_pairs, :pair, :highest]

  def initialize(cards)
    @cards = cards
    @cards = @cards.sort_by {|c| -c.face_order }

    @face_histogram = histogram( @cards.map(&:face_order) )
    @suit_histogram = histogram( @cards.map(&:suit) )
  end

  def combination
    RANKS.each do |key|
      cards = self.send(key)

      return {key: key, cards: cards.sort_by{|c| -c.face_order} } if cards
    end
  end

  private
  def four
    tuple(4)
  end

  def three
    tuple(3)
  end

  def pair
    tuple(2)
  end

  def straight_flush
    s = flush
    return nil unless s
    s = s.slice_when {|c1, c2| c1.face_order != c2.face_order+1} .sort_by{|a| a.size }.last
    s.size >= 5 ? s.sort_by{|a| -a.face_order} : nil
  end

  def straight
    s = @cards.slice_when do |c1, c2|
      c1.face_order != c2.face_order && c1.face_order != c2.face_order+1
    end.sort_by{|a| -a.size }.first

    return nil if s.map(&:face_order).uniq.size < 5
    s.sort_by{|a| -a.face_order}.uniq{|c| c.face_order}
  end

  def full_house
    sorted = @face_histogram.sort_by{|a| a.reverse }.reverse

    return nil unless sorted[0][1] >=3 && sorted[1][1] >=2 #checking counts for 2 most repeated faces
    faces = sorted.take(2).map{|a| a[0] }
    @cards.select{|c| c.face_order == faces[0]}.take(3) + @cards.select{|c| c.face_order == faces[1]}.take(2)
  end

  def tuple(order=2)
    face = hand_highest_tuple_face( order)
    return nil unless face

    @cards.select{|c| c.face_order == face }.take(order)
  end

  def two_pairs
    faces = @face_histogram.select{|f,s| s == 2 }.map{|f,s| f }.sort.slice(-2, 2)
    return nil unless faces && faces.size == 2

    @cards.select{|c| faces.include?(c.face_order) }.take(4)
  end

  def flush
    suit = @suit_histogram.detect{|f, s| s >= 5 }
    return nil unless suit
    @cards.select{|c| c.suit == suit[0] }.take(5)
  end

  def highest
    @cards.take(1)
  end

  def hand_highest_tuple_face( order=2) #highest pair or highest triple
    @face_histogram.select{|f,s| s >= order }.map{|f,s| f}.max
  end

  def histogram(ar)
    Hash[*ar.group_by{ |v| v }.flat_map{ |k, v| [k, v.size] }]
  end

end