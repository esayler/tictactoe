require_relative 'cell'

module TicTacToe
  class Board
    attr_reader :grid
    attr_accessor :move_symbol

    def initialize
      @grid = createBoard
      @winState = {}
      @players = {}
      @move_symbol = nil
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
      row_index = position[:row]
      col_index = position[:col]
      cell_to_change = @grid[row_index][col_index]
      cell_to_change.status = player.symbol
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

    def winStateReached?(current_player)

      @winState[:row] = checkRows(current_player.symbol)
      @winState[:col] = checkColumns(current_player.symbol)
      @winState[:diag] = checkDiagonals(current_player.symbol)

      if @winState[:row] || @winState[:col] || @winState[:diag]
        if current_player.id == 0
          puts "Player 1 Wins!"
        else
          puts "Player 2 Wins!"
        end
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
