class Piece
  attr_accessor :name, :type,  :unicode_value, :movement_block, :colour

  include Transformations

  def initialize(name)
    type_to_unicode_hash = {
      "black_king" => "\u2654",
      "black_queen" => "\u2655",
      "black_rook" => "\u2656",
      "black_bishop" => "\u2657",
      "black_knight" => "\u2658",
      "black_pawn" => "\u2659",
      "white_king" => "\u265A",
      "white_queen" => "\u265B",
      "white_rook" => "\u265C",
      "white_bishop" => "\u265D",
      "white_knight" => "\u265E",
      "white_pawn" => "\u265F"
    }

    @name = name
    @type = name.split('_')[1]
    @unicode_value = type_to_unicode_hash[name]
    @colour = name.split('_')[0]

    # puts "Debug: Initialized with type: #{type}, unicode: #{@unicode_value.encode('UTF-8')}"
  end

  def to_s
    # puts "to_s method called"
    @unicode_value.encode('UTF-8')
  end

  def get_all_moves(source, state)
    # puts "#{type}, #{colour}"
    get_all_positions(@type, @colour, source, state)
    # return [[2,0]] #For Mocking
  end
end
