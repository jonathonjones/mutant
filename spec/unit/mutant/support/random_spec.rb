require 'spec_helper'

module Mutant
	describe Random do
		describe '.string' do
			it 'returns a random string' do
				Random.string.should be_a(String)
			end
		end

		describe '.symbol' do
			it 'returns a random symbol' do
				Random.symbol.should be_a(Symbol)
			end
		end

		describe '.range' do
			it 'returns a random range' do
				Random.range.should be_a(Range)
			end
		end
	end
end