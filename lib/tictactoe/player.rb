module TicTacToe

  class Player

    attr_reader :id
    def initialize(args)
      args = defaults.merge(args)
      @id = args[:id]
    end

    def defaults
      {id: 0}
    end
  end
end

