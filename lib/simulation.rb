require_relative 'all'

module Simulation
  def self.run(players_count)
    return puts('Should be more than 2 players') if players_count < 2
    return puts("It's not a football") if players_count > 9

    deck = Deck.new
    index = ('A'..'Z').to_a
    players = players_count.times.map{|i| CardHolder.new("Player #{index[i]}") }
    players.each do |p|
      p.receive(  deck.shift(2) )
      puts  p.print('hand')
    end

    table = CardHolder.new('Table')
    table.receive( deck.shift(3) )  #&& puts( table.print('on flop') )
    table.receive( deck.shift )     #&& puts( table.print('on turn') )
    table.receive( deck.shift )     && puts( table.print('on river') )

    hands = players.map{|p| Hand.new(p, table) }
    hands.sort!.reverse!

    puts 'draw' if hands[0] == hands[1]

    puts "#{hands[0].player.title } wins: #{hands[0].print }"
  end
end