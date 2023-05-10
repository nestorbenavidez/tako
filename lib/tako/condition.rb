module Tako
  class Condition
    def initialize(attribute, operator, value)
      @attribute = attribute
      @operator = operator
      @value = value
    end

    def evaluate(facts)
      fact_value = facts[@attribute]
      case @operator
      when :eq
        fact_value == @value
      when :not_eq
        fact_value != @value
      when :gt
        fact_value > @value
      when :lt
        fact_value < @value
      when :gteq
        fact_value >= @value
      when :lteq
        fact_value <= @value
      else
        raise ArgumentError, "Invalid operator: #{@operator}"
      end
    end
  end
end
