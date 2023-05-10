module Tako
  class Engine
    def initialize(rules)
      @rules = rules.map { |rule| Rule.new(rule[:name], rule[:priority]) { instance_eval(&rule[:block]) } }
    end

    def execute(facts)
      fired_rules = []
      loop do
        rule_fired = false
        @rules.sort_by!(&:priority)
        @rules.each do |rule|
          next if fired_rules.include?(rule)

          if rule.fire(facts)
            fired_rules << rule
            rule_fired = true
          end
        end
        break unless rule_fired
      end
    end
  end
end
