require_relative 'Transformations'
require_relative 'Piece'

class Board
  attr_accessor :state, :eliminated_pieces

  def initialize
    @eliminated_pieces = Array.new

    @state = Array.new(8){ Array.new(8, "_") }
    for row in 0..7
      @state[row] = [
        Piece.new('white_rook'), Piece.new('white_knight'), Piece.new('white_bishop'), Piece.new('white_king'),
        Piece.new('white_queen'), Piece.new('white_bishop'), Piece.new('white_knight'), Piece.new('white_rook')
      ] if row == 0

      @state[row] = @state[row].map() { |item| item = Piece.new('white_pawn') } if row == 1

      @state[row] = @state[row].map() { |item| item = Piece.new('black_pawn') } if row == 6

      @state[row] = [
        Piece.new('black_rook'), Piece.new('black_knight'), Piece.new('black_bishop'), Piece.new('black_king'),
        Piece.new('black_queen'), Piece.new('black_bishop'), Piece.new('black_knight'), Piece.new('black_rook')
      ] if row == 7
    end
  end

  def change_board(action, is_check)
    source = action[0]
    destination = action[1]
    piece = @state[source[0]][source[1]]

    if piece.get_all_moves(source, @state).include?(destination)
      @eliminated_pieces << @state[destination[0]][destination[1]] if @state[destination[0]][destination[1]] != "_"
      @state[destination[0]][destination[1]] = piece
      @state[source[0]][source[1]] = "_"
    else
      puts "Invalid move! try again"
      return 'invalid'
    end

    #Add a is_check method call
  end

  def to_s
    7.downto(0) do |row|
      puts @state[row].join(" ")
    end
  end
end

# rook = Piece.new('white_rook')
# puts "Rook symbol: #{rook}"
# puts "Rook type: #{rook.type}"
# puts "Rook unicode value: #{rook.unicode_value.encode('UTF-8')}"
# puts "Rook colour: #{rook.colour}"
board = Board.new()
# board.state[2][1] = Piece.new('white_pawn')
puts board
# board.change_board([[0,4], [1,4]], false)
# puts board
board.state[7][1].get_all_moves([7,1], board.state)
