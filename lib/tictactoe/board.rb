require_relative 'cell'

module TicTacToe
  class Board
    attr_reader :grid

    def initialize
      @grid = createBoard
      @winState = {}
    end

    def createBoard
      Array.new(3) { Array.new(3) {TicTacToe::Cell.new} }
    end

    def cellIsBlank?(chosen_move)
      row_to_check = chosen_move[:row]
      col_to_check = chosen_move[:col]

      if (@grid[row_to_check][col_to_check]).status.nil?
        true
      else
        puts "Sorry that cell is occupied! Please choose an unoccupied cell!"
        false
      end
    end

    def placeMove(player, position)
      if player.id == 0
        move_symbol = :x
      else
        move_symbol = :o
      end
      row_index = position[:row]
      col_index = position[:col]
      cell_to_change = @grid[row_index][col_index]
      cell_to_change.status = move_symbol
    end

    def display
      puts
      puts "   0    1    2"
      @grid.each_with_index do |row, row_index|
        print row_index
        row.map do |cell|
          case cell.status
          when nil
            print "[   ]"
          when :x
            print "[ X ]"
          when :o
            print "[ O ]"
          end
        end
        puts
      end
      puts
    end

    def boardFilled?
      @grid.each { |row| row.each { |cell| return false if cell.status == nil } }
      puts "\nDraw!"
      true
    end

    def winStateReached?

      @winState[:x_row] = checkRows(:x)
      @winState[:x_col] = checkColumns(:x)
      @winState[:x_diag] = checkDiagonals(:x)

      @winState[:o_row] = checkRows(:o)
      @winState[:o_col] = checkColumns(:o)
      @winState[:o_diag] = checkDiagonals(:o)


      if @winState[:x_row] || @winState[:x_col] || @winState[:x_diag]
        puts "Player 1 Wins!"
      elsif @winState[:o_row] || @winState[:o_col] || @winState[:o_diag]
        puts "Player 2 Wins!"
      end

      @winState.any? { |end_state, value| value }
    end

    def checkRows(symbol)

      @grid.any? do |row|
        row.all? do |cell|
          cell.status == symbol
        end
      end
    end

    def checkColumns(symbol)

      @grid.transpose.any? do |col|
        col.all? do |cell|
          cell.status == symbol
        end
      end
    end

    def checkDiagonals(symbol)

      north_east_diag = @grid.flatten.select.with_index do |cell, i|
        i == 2 || i == 4 || i == 6
      end.all? do |cell|
        cell.status == symbol
      end

      south_east_diag = @grid.flatten.select.with_index do |cell, i|
        i % 4 == 0
      end.all? do |cell|
        cell.status == symbol
      end

      north_east_diag || south_east_diag
    end
  end
end
