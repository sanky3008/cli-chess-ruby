require_relative 'Player'
require_relative 'Board'

class Game
  attr_accessor :p1, :p2, :board, :active, :inactive

  def initialize
    @p1 = Player.new('white', true)
    @p2 = Player.new('black', true)
    @board = Board.new()
    @active = @p2  # This is opposite as we swap at the start of the play_game method
    @inactive = @p1
  end

  def play_game()
    is_check = false
    while true
      @active, @inactive = @inactive, @active

      puts "\nHere is the board"
      puts @board

      puts "\n#{@active.colour}, request you to take an action"
      begin
        action = self.get_action(@active)
        break if action == 'withdraw'
        move_result = @board.change_board(action)
      end while move_result == 'invalid'

      if action == 'withdraw'
        puts "\n\nGame Withdrawn! #{@inactive.colour} wins :))"
        break
      elsif move_result == 'checkmate'
        puts "\n\nCheckmate! #{@active.colour} wins :))"
        break
      elsif move_result == 'check'
        puts "\n#{@inactive.colour}, you are on Check!"
      elsif @board.eliminated_pieces.any? { |piece| piece.type == 'king' }
        puts "\n\n#{@inactive.colour}'s king is dead! #{@active.colour} wins!"
        break
      end
    end
  end

  def get_action(active)
    active.take_action(active)
  end
end
