module Tako
  class Engine
    attr_reader :rules

    def initialize(rules_file_path)
      @rules = load_rules(rules_file_path)
    end

    def execute(facts)
      facts = Fact.new(facts)
      while apply_rules(facts)
        # Keep applying rules until there are no more matches
      end
      facts.to_h
    end

    def backward_chain(goal, facts)
      # Try to derive the goal from the facts using backward chaining
      rules.each do |rule|
        if rule.consequent == goal
          if rule.applies_to?(facts)
            rule.perform(facts)
            return true
          else
            rule.antecedent.each do |condition|
              if backward_chain(condition, facts)
                rule.perform(facts)
                return true
              end
            end
          end
        end
      end
      false
    end

    private

    def load_rules(rules_file_path)
      # Load rules from YAML file and create Rule objects
    end

    def apply_rules(facts)
      # Iterate over all rules and try to apply them to the facts
      applied = false
      rules.each do |rule|
        if rule.applies_to?(facts)
          rule.perform(facts)
          applied = true
        end
      end
      applied
    end
  end
end


