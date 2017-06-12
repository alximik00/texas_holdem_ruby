require 'spec_helper'

RSpec.describe Deck do
  describe 'init' do
    specify { expect(subject.size).to eq(52) }

    it 'is shuffled' do
      asc  = subject.cards.each_cons(2).all?{|a,b| a<b}
      desc = subject.cards.each_cons(2).all?{|a,b| a>b}
      expect(asc || desc).to be_falsey
    end
  end

  describe '.shift' do
    it ' by defaulttakes 1 card from end' do
      last_card = subject.cards.last
      expect(subject.shift).to be last_card
      expect(subject.size).to eq 51
    end

    it 'takes n card from end' do
      last_cards = subject.cards[-2..-1].reverse
      expect(subject.shift(2)).to eq(last_cards)
      expect(subject.size).to eq 50
    end
  end
end