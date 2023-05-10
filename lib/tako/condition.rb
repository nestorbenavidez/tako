module Tako
  class Condition
    attr_reader :field, :operator, :value, :quantifier

    def initialize(field, operator, value, quantifier = nil)
      @field = field
      @operator = operator
      @value = value
      @quantifier = quantifier
    end

    def evaluate(facts)
      if quantifier == "all"
        values = facts[field]
        return false unless values.is_a?(Array)

        values.all? { |value| operator.evaluate(value, self.value) }
      elsif quantifier == "any"
        values = facts[field]
        return false unless values.is_a?(Array)

        values.any? { |value| operator.evaluate(value, self.value) }
      else
        operator.evaluate(facts[field], value)
      end
    end

    def to_s
      quant_str = quantifier ? "#{quantifier} " : ""
      "#{quant_str}#{field} #{operator} #{value}"
    end
  end
end

