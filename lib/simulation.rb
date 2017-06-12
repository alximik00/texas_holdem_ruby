require_relative 'deck'
require_relative 'card_holder'
require_relative 'hand'

module Simulation
  def self.run
    deck = Deck.new
    players = 3.times.map{|i| CardHolder.new("Player #{i}") }
    table = CardHolder.new

    players.each{|p| p.receive(  deck.shift(2) ) }
    table.receive( deck.shift(3) )
    table.receive( deck.shift )
    table.receive( deck.shift )

    hands = players.map{|p| Hand.new(p, table) }
    hands.sort!

    puts "#{hands[0].player.title } wins"
  end
end