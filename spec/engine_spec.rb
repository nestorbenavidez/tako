require 'spec_helper'
require 'tako/engine'

RSpec.describe Tako::Engine do
  describe '#execute' do
    context 'when no rules are defined' do
      it 'returns an empty array' do
        engine = Tako::Engine.new
        facts = {}
        result = engine.execute(facts)
        expect(result).to eq([])
      end
    end

    context 'when rules are defined' do
      before(:all) do
        @rules = [
          { conditions: { 'age' => Tako::Condition.new(:>, 18) }, actions: [Tako::Action.new(proc { |facts| facts['adult'] = true })] },
          { conditions: { 'country' => Tako::Condition.new(:==, 'US') }, actions: [Tako::Action.new(proc { |facts| facts['country_us'] = true })] }
        ]
      end

      it 'executes the appropriate actions based on the facts' do
        engine = Tako::Engine.new(@rules)
        facts = { 'age' => 25, 'country' => 'US' }
        engine.execute(facts)
        expect(facts['adult']).to eq(true)
        expect(facts['country_us']).to eq(true)
      end

      it 'returns an array of executed rule IDs' do
        engine = Tako::Engine.new(@rules)
        facts = { 'age' => 25, 'country' => 'US' }
        result = engine.execute(facts)
        expect(result).to contain_exactly(0, 1)
      end
    end
  end
end
