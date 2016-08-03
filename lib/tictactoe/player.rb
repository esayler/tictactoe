module TicTacToe

  class Player

    attr_reader :id, :symbol
    attr_accessor :ai

    def initialize(args)
      args = defaults.merge(args)
      @id = args[:id]
      @symbol =  args[:symbol]
      @ai = args[:ai]
    end

    def defaults
      {id: 0,
       ai: false,
       :symbol => :x
      }

    end
  end
end

