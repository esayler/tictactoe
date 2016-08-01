module TicTacToe

  class Player

    attr_reader :id, :symbol
    def initialize(args)
      args = defaults.merge(args)
      @id = args[:id]
      @symbol =  args[:symbol]
    end

    def defaults
      {id: 0, :symbol => :x}

    end
  end
end

