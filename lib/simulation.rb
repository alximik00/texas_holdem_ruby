require_relative 'all'

class Simulation

  def initialize(players_count)
    @players_count = players_count
    raise ArgumentError.new('Should be more than 2 players') if players_count < 2
    raise ArgumentError.new("It's not a football") if players_count > 9

    @deck = Deck.new
  end

  def run
    @players = spawn_players
    @table = start_table
    decide_winner.tap do |res|
      puts res
    end
  end

  private
  def spawn_players
    index = ('A'..'Z').to_a
    players = @players_count.times.map{|i| CardHolder.new("Player #{index[i]}") }
    players.each do |p|
      p.receive(  @deck.shift(2) )
      puts  p.print('hand')
    end
  end

  def start_table
    CardHolder.new('Table').tap do |table|
      table.receive( @deck.shift(3) )  && puts( table.print('on flop') )
      table.receive( @deck.shift )     && puts( table.print('on turn') )
      table.receive( @deck.shift )     && puts( table.print('on river') )
    end
  end

  def decide_winner
    hands = @players.map{|p| Hand.new(p, @table) }
    hands.sort!.reverse!
    return 'draw' if hands[0] == hands[1]
    "#{hands[0].player.title } wins: #{hands[0].print }"
  end
end