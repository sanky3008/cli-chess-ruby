require_relative 'Transformations'
require_relative 'Piece'
require_relative 'Player'

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

  def change_board(action)
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

    if self.is_check(destination)
      return true
    else
      return false
    end
  end

  def is_checkmate?(action, active)
    return false if !is_check(action[1])
    all_active_moves, all_inactive_moves = list_all_pieces_moves(active)
    return cal_checkmate(all_active_moves, all_inactive_moves)
  end

  def list_all_pieces_moves(active)
    all_inactive_moves = Hash.new([])
    all_active_moves = Hash.new([])
    active_colour = active.colour
    opponent_king_pos = []

    (0..7).each do |y|
      (0..7).each do |x|
        sq = @state[y][x]
        if sq == "_"
          next
        elsif sq != "_" && sq.colour == active_colour
          all_active_moves[sq.type] += sq.get_all_moves([y,x], @state)
        elsif sq != "_" && sq.colour != active_colour
          all_inactive_moves[sq.type] += sq.get_all_moves([y,x], @state)
          opponent_king_pos = [y,x] if sq.type = 'king'
        end
      end
    end

    all_inactive_moves['king'].each do |move|
      state = self.simulate_change_board([opponent_king_pos, move])
      (0..7).each do |y|
        (0..7).each do |x|
          sq = state[y][x]
          if sq != "_"
            if sq.colour == active_colour && !all_active_moves[sq.type].include?([y,x])
              all_active_moves[sq.type] += sq.get_all_moves([y,x], state)
            end
          end
        end
      end
    end

    return [all_active_moves, all_inactive_moves]
  end

  def simulate_change_board(action)
    source = action[0]
    destination = action[1]
    state = @state.map(&:dup)
    piece = state[source[0]][source[1]]
    eliminated_pieces = @eliminated_pieces.clone

    if piece.get_all_moves(source, state).include?(destination)
      eliminated_pieces << state[destination[0]][destination[1]] if state[destination[0]][destination[1]] != "_"
      state[destination[0]][destination[1]] = piece
      state[source[0]][source[1]] = "_"
    end

    return state
  end

  def is_check(destination)
    piece = @state[destination[0]][destination[1]]
    # puts piece

    piece.get_all_moves(destination, @state).each() do |square|
      target = @state[square[0]][square[1]]
      if target != "_" && target.type == 'king' && target.colour != piece.colour
        return true
      end
    end

    return false
  end

  def cal_checkmate(all_active_moves, all_inactive_moves)
    target_king_moves = all_inactive_moves['king']

    other_inactive_moves = all_inactive_moves.reduce([]) do |acc, key|
      if key[0] != 'king'
        acc += key[1]
      else
        acc += []
      end
    end

    unguarded_moves = []

    target_king_moves.each do |move|
      unguarded_moves << move if !other_inactive_moves.include?(move)
    end

    all_attacking_moves = all_active_moves.reduce([]) do |acc, key|
      acc += key[1]
    end

    return target_king_moves.all? do |move|
      all_attacking_moves.include?(move)
    end
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
