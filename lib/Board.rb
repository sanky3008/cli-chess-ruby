require_relative 'Transformations'
require_relative 'Piece'
require_relative 'Player'

class Board
  attr_accessor :state, :eliminated_pieces

  def initialize
    @eliminated_pieces = Array.new
    @state = Array.new(8){ Array.new(8, "_") }
    setup_initial_board
  end

  def setup_initial_board
    @state[0] = [
      Piece.new('white_rook'), Piece.new('white_knight'), Piece.new('white_bishop'), Piece.new('white_queen'),
      Piece.new('white_king'), Piece.new('white_bishop'), Piece.new('white_knight'), Piece.new('white_rook')
    ]
    @state[1] = Array.new(8) { Piece.new('white_pawn') }
    @state[6] = Array.new(8) { Piece.new('black_pawn') }
    @state[7] = [
      Piece.new('black_rook'), Piece.new('black_knight'), Piece.new('black_bishop'), Piece.new('black_queen'),
      Piece.new('black_king'), Piece.new('black_bishop'), Piece.new('black_knight'), Piece.new('black_rook')
    ]
  end

  def change_board(action)
    source, destination = action
    piece = @state[source[0]][source[1]]

    if piece.get_all_moves(source, @state).include?(destination)
      @eliminated_pieces << @state[destination[0]][destination[1]] if @state[destination[0]][destination[1]] != "_"
      @state[destination[0]][destination[1]] = piece
      @state[source[0]][source[1]] = "_"

      opponent_color = piece.colour == 'white' ? 'black' : 'white'
      if is_check?(opponent_color)
        return is_checkmate?(opponent_color) ? 'checkmate' : 'check'
      end
      'valid'
    else
      puts "Invalid move! try again"
      'invalid'
    end
  end

  def is_checkmate?(color)
    return false unless is_check?(color)

    @state.each_with_index do |row, y|
      row.each_with_index do |piece, x|
        if piece != "_" && piece.colour == color
          piece.get_all_moves([y, x], @state).each do |move|
            return false if simulate_move([y, x], move, color)
          end
        end
      end
    end
    true
  end

  def simulate_move(from, to, color)
    temp_state = Marshal.load(Marshal.dump(@state))
    temp_state[to[0]][to[1]] = temp_state[from[0]][from[1]]
    temp_state[from[0]][from[1]] = "_"

    king_position = find_king(color, temp_state)
    opponent_color = color == 'white' ? 'black' : 'white'

    temp_state.each_with_index do |row, y|
      row.each_with_index do |piece, x|
        if piece != "_" && piece.colour == opponent_color
          return false if piece.get_all_moves([y, x], temp_state).include?(king_position)
        end
      end
    end
    true
  end

  def is_check?(color)
    king_position = find_king(color)
    opponent_color = color == 'white' ? 'black' : 'white'

    @state.each_with_index do |row, y|
      row.each_with_index do |piece, x|
        if piece != "_" && piece.colour == opponent_color
          return true if piece.get_all_moves([y, x], @state).include?(king_position)
        end
      end
    end
    false
  end

  def find_king(color, board = @state)
    board.each_with_index do |row, y|
      row.each_with_index do |piece, x|
        return [y, x] if piece != "_" && piece.type == 'king' && piece.colour == color
      end
    end
    nil
  end

  def to_s
    7.downto(0) do |row|
      puts @state[row].map { |piece| piece == "_" ? "_" : piece.to_s }.join(" ")
    end
    ""
  end
end

# rook = Piece.new('white_rook')
# puts "Rook symbol: #{rook}"
# puts "Rook type: #{rook.type}"
# puts "Rook unicode value: #{rook.unicode_value.encode('UTF-8')}"
# puts "Rook colour: #{rook.colour}"
#
# board.state[2][1] = Piece.new('white_pawn')
# puts board
# puts board.change_board([[0,4], [1,4]])
# board.is_checkmate?()
# puts board.state[7][4].type
# board.state[7][4].get_all_moves([7,4], board.state)

# p1 = Player.new('white', true)
# p2 = Player.new('black', true)

# board = Board.new()
# puts board
# action = [[0,3],[6,3]]
# board.change_board(action)
# puts board
# puts board.is_checkmate?(action, p1)
