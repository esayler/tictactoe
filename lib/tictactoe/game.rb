require 'pry'
require_relative 'board'
require_relative 'player'

module TicTacToe
  class Game

    attr_reader :board, :current_player
    attr_accessor :player_one, :player_two

    def initialize(args)
      args = defaults.merge(args)
      @board = args[:board]
      @num_moves = args[:num_moves]
      @current_player = args[:current_player]
      @player_one = args[:player_one]
      @player_two = args[:player_two]
    end

    def defaults
      {board: TicTacToe::Board.new,
       current_player: nil,
       player_one: TicTacToe::Player.new(id: 0, :symbol => :x),
       player_two: TicTacToe::Player.new(id: 1, :symbol => :o),
       num_moves: 0}
    end

    def play

      @board.display
      begin
        puts
        @current_player = whoseTurn
        #@board.move_symbol
        chosen_move_valid = false

        until chosen_move_valid
          player_move = {row: nil, col: nil}
          chosen_move = chooseMove
          chosen_move_valid = @board.cellIsBlank?(chosen_move)
          if chosen_move_valid
            player_move = chosen_move
          end
        end

        @board.placeMove(current_player, player_move)
        @num_moves += 1
        @board.display
      end until @board.winStateReached?(@current_player) || @board.boardFilled?
    end

    def whoseTurn
      player_turn = @num_moves % 2
      if player_turn == 0
        puts "Player 1, place your `X`\n"
        @player_one
      elsif player_turn == 1
        puts "Player 2, place your `O`\n"
        @player_two
      else
        puts "error in whoseTurn"
      end
    end

    def getUserInput
      user_input = gets.chomp
      if user_input == "q"
        exit
      else
        user_input
      end
    end

    def chooseMove
      chosen_move = {chosen_row: nil, chosen_col: nil}
      user_row_input_valid, user_col_input_valid = false, false

      chosen_move[:row] = getUserSelection(:row).to_i
      chosen_move[:col] = getUserSelection(:col).to_i

      puts
      chosen_move
    end

    def getUserSelection(axis)
      begin
        case axis
        when :row
          print "choose row (0..2):"
        when :col
          print "choose col (0..2):"
        else
          puts "error in getUserSelection"
        end

        user_selection = getUserInput

      end until userInputIsValid?(user_selection)

      user_selection
    end

    def userInputIsValid?(user_input)
      if user_input =~ /^[0-2]$/
        true
      else
        puts "Invalid input! Please try again!"
        false
      end
    end
  end
end
