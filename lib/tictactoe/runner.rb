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

          print "\nWould you like to play the computer? (y/n): "

          input_valid = false
          ai_activated = false

          until input_valid
            user_input = gets.chomp

            case
            when user_input.match(/^y/i)
              input_valid = true
              ai_activated = true
              'AI Mode activated!'
            when user_input.match(/^n/i)
              input_valid = true
              'Human Two-Player Mode activated!'
            end

          end


          puts "Let's play!"

          g = TicTacToe::Game.new({ai: ai_activated})
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
