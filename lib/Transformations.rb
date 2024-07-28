module Transformations
  def get_all_positions(type, colour, source, state)
    y = source[0]
    x = source[1]
    positions = Array.new

    case [type, colour]
    when ['pawn', 'white']
      i = y
      j = x
      if (i == 1 && colour == 'white')
        positions << [i+2, j] if state[i+2][j] == '_'
      end

      i = i+1
      if state[i][j] == "_" && i <= 7 && j <= 7 && i >= 0 && j >= 0
        positions << [i,j]
      end

      if (j <= 6 && state[i][j+1] != "_" && state[i][j+1].colour != colour)
        positions << [i, j+1]
      elsif (j >= 1 && state[i][j-1] != "_" && state[i][j-1].colour != colour)
        positions << [i, j-1]
      end

    when ['pawn', 'black']
      i = y
      j = x
      if (i == 6 && colour == 'black')
        positions << [i-2, j] if state[i-2][j] == '_'
      end

      i = i-1
      if state[i][j] == "_" && i <= 7 && j <= 7 && i >= 0 && j >= 0
        positions << [i,j]
      end

      if (j <= 6 && state[i][j+1] != "_" && state[i][j+1].colour != colour)
        positions << [i, j+1]
      elsif (j >= 1 && state[i][j-1] != "_" && state[i][j-1].colour != colour)
        positions << [i, j-1]
      end

    when ['king', 'white']
      for i in [y-1, 0].max..[7, y+1].min
        for j in [x-1,0].max..[7,x+1].min
          positions << [i, j] if ((i != y) || (j != x)) && (state[i][j] == "_" || state[i][j].colour != colour)
        end
      end

    when  ['king', 'black']
      for i in [y-1, 0].max..[7, y+1].min
        for j in [x-1,0].max..[7,x+1].min
          positions << [i, j] if ((i != y) || (j != x)) && (state[i][j] == "_" || state[i][j].colour != colour)
        end
      end

    when ['knight', 'white']
      i = y
      j = x
      transformation_matrix = [
        [1, 2],
        [-1, 2],
        [1, -2],
        [-1, -2],
        [2, 1],
        [2, -1],
        [-2, 1],
        [-2, -1]
      ]
      transformation_matrix.each do |transformation|
        temp_y = i + transformation[0]
        temp_x = j + transformation[1]
        new_vertex = [temp_y, temp_x]
        if (0..7).include?(temp_x) && (0..7).include?(temp_y)
          if (state[temp_y][temp_x] == "_" || state[temp_y][temp_x].colour != colour)
            positions << new_vertex
          end
        end
      end

    when ['knight', 'black']
      i = y
      j = x
      transformation_matrix = [
        [1, 2],
        [-1, 2],
        [1, -2],
        [-1, -2],
        [2, 1],
        [2, -1],
        [-2, 1],
        [-2, -1]
      ]
      transformation_matrix.each do |transformation|
        temp_y = i + transformation[0]
        temp_x = j + transformation[1]
        new_vertex = [temp_y, temp_x]
        if (0..7).include?(temp_x) && (0..7).include?(temp_y)
          if (state[temp_y][temp_x] == "_" || state[temp_y][temp_x].colour != colour)
            positions << new_vertex
          end
        end

      end

    when ['rook', 'white']
      positions = []
      positions += get_rook_positions(x, y, state)

    when ['rook', 'black']
      positions = []
      positions += get_rook_positions(x, y, state)

    when ['bishop', 'white']
      positions = []
      positions += get_bishop_positions(x, y, state)

    when ['bishop', 'black']
      positions = []
      positions += get_bishop_positions(x, y, state)

    when ['queen', 'white']
      positions = []
      positions += get_rook_positions(x, y, state)
      positions += get_bishop_positions(x, y, state)

    when ['queen', 'black']
      positions = []
      positions += get_rook_positions(x, y, state)
      positions += get_bishop_positions(x, y, state)

    end
    # p positions
    return positions
  end



  # HELPER METHODS

  def get_rook_positions(x, y, state)
    positions = []
    for i in (y..7)
      j = x
      if i == y
        next
      elsif state[i][j] == "_"
        positions << [i,j]
      elsif state[i][j] != "_" && state[i][j].colour != colour
        positions << [i,j]
        break
      elsif state[i][j].colour == colour
        break
      end
    end

    y.downto(0) do |i|
      j = x
      if i == y
        next
      elsif state[i][j] == "_"
        positions << [i,j]
      elsif state[i][j] != "_" && state[i][j].colour != colour
        positions << [i,j]
        break
      elsif state[i][j].colour == colour
        break
      end
    end

    for j in (x..7)
      i = y
      if j == x
        next
      elsif state[i][j] == "_"
        positions << [i,j]
      elsif state[i][j] != "_" && state[i][j].colour != colour
        positions << [i,j]
        break
      elsif state[i][j].colour == colour
        break
      end
    end

    x.downto(0) do |j|
      i = y
      if j == y
        next
      elsif state[i][j] == "_"
        positions << [i,j]
      elsif state[i][j] != "_" && state[i][j].colour != colour
        positions << [i,j]
        break
      elsif state[i][j].colour == colour
        break
      end
    end

    return positions
  end

  def get_bishop_positions(x, y, state)
    positions = []
    i = y
    j = x

    # p positions

    while i <= 7 && j <= 7
      # p positions
      if i == y && j == x
        i += 1
        j += 1
        next
      elsif state[i][j] == '_'
        positions << [i,j]
      elsif state[i][j] != "_" && state[i][j].colour != colour
        positions << [i,j]
        break
      elsif state[i][j].colour == colour
        break
      end
      i += 1
      j += 1
    end

    i = y
    j = x
    while i >= 0 && j >= 0
      # p positions
      if i == y && j == x
        i -= 1
        j -= 1
        next
      elsif state[i][j] == '_'
        positions << [i,j]
      elsif state[i][j] != "_" && state[i][j].colour != colour
        positions << [i,j]
        break
      elsif state[i][j].colour == colour
        break
      end
      i -= 1
      j -= 1
    end

    i = y
    j = x
    while i <= 7 && j >= 0
      # p positions
      if i == y && j == x
        i += 1
        j -= 1
        next
      elsif state[i][j] == '_'
        positions << [i,j]
      elsif state[i][j] != "_" && state[i][j].colour != colour
        positions << [i,j]
        break
      elsif state[i][j].colour == colour
        break
      end
      i += 1
      j -= 1
    end

    i = y
    j = x
    while i >= 0 && j <= 7
      # p positions
      if i == y && j == x
        i -= 1
        j += 1
        next
      elsif state[i][j] == '_'
        positions << [i,j]
      elsif state[i][j] != "_" && state[i][j].colour != colour
        positions << [i,j]
        break
      elsif state[i][j].colour == colour
        break
      end
      i -= 1
      j += 1
    end

    return positions
  end
end
