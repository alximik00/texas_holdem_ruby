require 'spec_helper'

RSpec.describe Card do
  describe 'init' do
    specify {  expect( ->{Card.new(1, 'S')} ).to raise_error(ArgumentError) }
    specify {  expect( ->{Card.new(2, 'E')} ).to raise_error(ArgumentError) }
    specify {  expect( ->{Card.new(2, 'S')} ).not_to raise_error }
  end

  describe '<=>' do
    subject { Card.new('T', 'S') }
    specify { is_expected.to be > Card.new(9, 'S') }
    specify { is_expected.to be < Card.new('J', 'S') }

    specify { is_expected.to be > Card.new('T', 'D') }
    specify { is_expected.to be < Card.new('T', 'H') }
  end

  describe 'to_s' do
    specify { expect(Card.new('T', 'S').to_s).to eq 'TS' }
  end

  describe '::array_from_string' do
    it 'creates array from string' do
      res = Card.array_from_string('2C TH QS')
      expect( res.size ).to eq(3)
      expect( res[0] ).to eq( Card.new('2', 'C'))
    end
  end
end