require 'spec_helper'
require 'tako/rule'

RSpec.describe Tako::Rule do
  describe '#execute' do
    let(:rule) do
      conditions = {
        'age' => Tako::Condition.new(:>, 18),
        'country' => Tako::Condition.new(:==, 'US')
      }
      actions = [
        Tako::Action.new(proc { |facts| facts['adult'] = true }),
        Tako::Action.new(proc { |facts| facts['country_us'] = true })
      ]
      Tako::Rule.new(conditions, actions)
    end

    it 'executes the appropriate actions based on the facts' do
      facts = { 'age' => 25, 'country' => 'US' }
      rule.execute(facts)
      expect(facts['adult']).to eq(true)
      expect(facts['country_us']).to eq(true)
    end

    it 'returns true if all conditions are satisfied' do
      facts = { 'age' => 25, 'country' => 'US' }
      result = rule.execute(facts)
      expect(result).to eq(true)
    end

    it 'returns false if any condition is not satisfied' do
      facts = { 'age' => 17, 'country' => 'US' }
      result = rule.execute(facts)
      expect(result).to eq(false)
    end
  end
end
