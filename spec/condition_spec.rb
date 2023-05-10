require 'spec_helper'
require 'tako/condition'

RSpec.describe Tako::Condition do
  describe '#evaluate' do
    context 'when the operator is "=="' do
      it 'returns true if the fact matches the value' do
        condition = Tako::Condition.new('age', '==', 25)
        expect(condition.evaluate('age' => 25)).to be_truthy
      end

      it 'returns false if the fact does not match the value' do
        condition = Tako::Condition.new('age', '==', 25)
        expect(condition.evaluate('age' => 30)).to be_falsey
      end
    end

    context 'when the operator is ">="' do
      it 'returns true if the fact is greater than or equal to the value' do
        condition = Tako::Condition.new('age', '>=', 25)
        expect(condition.evaluate('age' => 30)).to be_truthy
        expect(condition.evaluate('age' => 25)).to be_truthy
      end

      it 'returns false if the fact is less than the value' do
        condition = Tako::Condition.new('age', '>=', 25)
        expect(condition.evaluate('age' => 20)).to be_falsey
      end
    end

    context 'when the operator is "<="' do
      it 'returns true if the fact is less than or equal to the value' do
        condition = Tako::Condition.new('age', '<=', 25)
        expect(condition.evaluate('age' => 20)).to be_truthy
        expect(condition.evaluate('age' => 25)).to be_truthy
      end

      it 'returns false if the fact is greater than the value' do
        condition = Tako::Condition.new('age', '<=', 25)
        expect(condition.evaluate('age' => 30)).to be_falsey
      end
    end

    context 'when the operator is "!="' do
      it 'returns true if the fact does not match the value' do
        condition = Tako::Condition.new('age', '!=', 25)
        expect(condition.evaluate('age' => 30)).to be_truthy
      end

      it 'returns false if the fact matches the value' do
        condition = Tako::Condition.new('age', '!=', 25)
        expect(condition.evaluate('age' => 25)).to be_falsey
      end
    end

    context 'when the operator is "include?"' do
      it 'returns true if the fact includes the value' do
        condition = Tako::Condition.new('pets', 'include?', 'dog')
        expect(condition.evaluate('pets' => ['dog', 'cat'])).to be_truthy
      end

      it 'returns false if the fact does not include the value' do
        condition = Tako::Condition.new('pets', 'include?', 'dog')
        expect(condition.evaluate('pets' => ['cat', 'bird'])).to be_falsey
      end
    end
  end
end
