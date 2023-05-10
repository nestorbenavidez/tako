module Tako
  class Rule
    attr_reader :name, :conditions, :actions, :priority

    def initialize(name, priority = 0, &block)
      @name = name
      @priority = priority
      @conditions = []
      @actions = []
      instance_eval(&block)
    end

    def condition(attribute, operator, value)
      @conditions << Condition.new(attribute, operator, value)
    end

    def action(&block)
      @actions << Action.new(&block)
    end

    def fire(facts)
      if @conditions.all? { |condition| condition.evaluate(facts) }
        @actions.each(&:execute)
        true
      else
        false
      end
    end
  end
end
