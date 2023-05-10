module Tako
  class Condition
    attr_reader :field, :operator, :value

    def initialize(condition)
      @field = condition["field"]
      @operator = condition["operator"]
      @value = condition["value"]
    end

    def evaluate(facts)
      actual_value = facts[@field]
      case operator
      when ">"
        actual_value > value
      when ">="
        actual_value >= value
      when "<"
        actual_value < value
      when "<="
        actual_value <= value
      when "=="
        actual_value == value
      when "!="
        actual_value != value
      when "in"
        value.include?(actual_value)
      else
        raise "Unknown operator #{operator}"
      end
    end

    def self.parse_conditions(conditions)
      conditions.map do |condition|
        if condition.key?("all")
          All.new(condition["all"].map { |c| parse_conditions([c])[0] })
        elsif condition.key?("any")
          Any.new(condition["any"].map { |c| parse_conditions([c])[0] })
        elsif condition.key?("not")
          Not.new(parse_conditions([condition["not"]])[0])
        else
          Condition.new(condition)
        end
      end
    end
  end

  class All
    attr_reader :conditions

    def initialize(conditions)
      @conditions = conditions
    end

    def evaluate(facts)
      @conditions.all? { |condition| condition.evaluate(facts) }
    end
  end

  class Any
    attr_reader :conditions

    def initialize(conditions)
      @conditions = conditions
    end

    def evaluate(facts)
      @conditions.any? { |condition| condition.evaluate(facts) }
    end
  end

  class Not
    attr_reader :condition

    def initialize(condition)
      @condition = condition
    end

    def evaluate(facts)
      !@condition.evaluate(facts)
    end
  end
end

