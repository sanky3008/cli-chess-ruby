require_relative 'Player'
require_relative 'Board'

class Game
  attr_accessor :p1, :p2, :board

  def initialize
    @p1 = Player.new('white', true)
    @p2 = Player.new('black', true)
    @board = Board.new()
  end

  def play_game()
    is_check = false
    active = @p2 #This is opposite as we swap at the start of the play_game method
    inactive = @p1
    while true
      temp = active
      active = inactive
      inactive = temp

      puts "\nHere is the board"
      puts @board

      puts "\n#{active.colour}, request you to take an action"
      begin
        action = self.get_action(active, is_check)
        break if action == 'withdraw'
        is_check = @board.change_board(action, is_check) #The new value of is_check is sent after the action
        puts is_check
      end while is_check == 'invalid'

      # @board.promote?

      if action == 'withdraw'
        puts "\n\nGame Withdrawn! #{inactive.colour} wins :))"
        break
      end

      # if is_check
      #   puts "\n#{inactive.colour}, you are on Check!"
      # end

      # if @board.is_checkmate?
      #   puts "\n\nCheckmate! #{@active.colour} wins :))"
      #   break
      # end
    end
  end

  def get_action(active, is_check)
    action = active.take_action(active)
    return action
  end
end

Game.new.play_game
