# encoding: utf-8
#
# = game_board.rb
#
# Board data model
#
# Authors: Evan Degraff, James Finlay
##

class GameBoard
  @data

  def initialize(width, height)
    @data = Array.new(height){Array.new(width, 0)}
  end

  def row(row)
    return @data[row]
  end

  def col(col)
    return @data.flatten.select.with_index{|v,i| i % @data[0].size == col}
  end

  def [](row, col)
    return @data[row][col]
  end

  def []=(row, col, v)
    return @data[row][col] = v
  end

  def col_full?(column)
    return self[col(column).size - 1, column] != 0
  end

end
