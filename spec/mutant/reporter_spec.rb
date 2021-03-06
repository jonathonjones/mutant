require 'spec_helper'

describe Mutant::Reporter do
  describe '.pluralize' do
    context 'given "mutant" with a count of 1' do
      it 'returns "mutant"' do
        Mutant::Reporter.pluralize(1, 'mutant').should eq('mutant')
      end
    end

    context 'given "mutant" with a count of 0' do
      it 'returns "mutants"' do
        Mutant::Reporter.pluralize(0, 'mutant').should eq('mutants')
      end
    end
  end
end
