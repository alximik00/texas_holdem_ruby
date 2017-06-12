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
end