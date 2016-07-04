require_relative 'game'

module TicTacToe
  class Runner
    def initialize
      @user_exit = false
    end

    def run

      puts "Welcome to TicTacToe!"
      until @user_exit
        print "\nPress `ENTER` or `p` to play, `q` to exit: "
        user_input = gets

        if user_input.eql?("\n") || user_input.chomp.eql?("p")
          puts "Let's play!"
          g = TicTacToe::Game.new({})
          g.play

          puts "\nGame ended!"
          puts "\n\nWould you like to play again?"
        else
          @user_exit = true
        end
      end
      puts "Bye!"

    end
  end
end
