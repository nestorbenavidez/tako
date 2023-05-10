module Tako
  class Rule
    attr_reader :name, :priority, :conditions, :consequents

    def initialize(rule)
      @name = rule["name"]
      @priority = rule["priority"]
      @conditions = Condition.parse_conditions(rule["conditions"])
      @consequents = rule["consequents"].map { |consequent| Action.new(consequent) }
    end

    def evaluate(facts)
      if @conditions.all? { |condition| condition.evaluate(facts) }
        @consequents.each { |consequent| consequent.execute(facts) }
        true
      else
        false
      end
    end
  end
end
