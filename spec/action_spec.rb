require 'spec_helper'
require 'tako/action'

RSpec.describe Tako::Action do
  describe '#execute' do
    context 'when the action is a Proc' do
      it 'calls the Proc with the facts' do
        action = Tako::Action.new(proc { |facts| facts['message'] = 'Hello, world!' })
        facts = {}
        action.execute(facts)
        expect(facts['message']).to eq('Hello, world!')
      end
    end

    context 'when the action is a symbol' do
      it 'calls the method with the facts' do
        class TestClass
          def test_method(facts)
            facts['message'] = 'Hello, world!'
          end
        end

        test_instance = TestClass.new
        action = Tako::Action.new(:test_method)
        facts = {}
        action.execute(facts, test_instance)
        expect(facts['message']).to eq('Hello, world!')
      end
    end
  end
end
