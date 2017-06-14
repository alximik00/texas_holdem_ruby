require 'spec_helper'

RSpec.describe Simulation do
  describe 'decision who wins' do
    subject { Simulation.new(3) }

    specify {
      player_a = CardHolder.new('Player A'); player_a.receive(Card.array_from_string('5H 8H') )
      player_b = CardHolder.new('Player B'); player_b.receive(Card.array_from_string('6S 9H') )
      player_c = CardHolder.new('Player C'); player_c.receive(Card.array_from_string('2S AS') )

      table = CardHolder.new('Table'); table.receive( Card.array_from_string('TH 2D JH TD 5D') )

      allow(subject).to receive(:spawn_players).and_return( [ player_a, player_b, player_c] )
      allow(subject).to receive(:start_table).and_return( table )

      result = subject.run
      expect( result ).to start_with('Player A wins')
      expect( result ).to end_with('(two pairs)')
    }
  end
end