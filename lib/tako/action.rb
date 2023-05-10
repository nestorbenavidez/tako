module Tako
  class Action
    def initialize(&block)
      @block = block
    end

    def execute
      @block.call
    end
  end
end
