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
      elsif (j >= 1 && state[i][j-1] != "_" && state[i][j+1].colour != colour)
        positions << [i, j+1]
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
      elsif (j >= 1 && state[i][j-1] != "_" && state[i][j+1].colour != colour)
        positions << [i, j+1]
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
        positions << new_vertex if (state[temp_y][temp_x] == "_" || state[temp_y][temp_x].colour != colour) && (0..7).include?(temp_x) && (0..7).include?(temp_y)
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
        positions << new_vertex if (0..7).include?(temp_x) && (0..7).include?(temp_y) && (state[temp_y][temp_x] == "_" || state[temp_y][temp_x].colour != colour)

      end

    end
    p positions
    return positions
  end
end
