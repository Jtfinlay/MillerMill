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

  def diagonals
    a = @data # Readability
    diags = []
    (0..a[0].size - 1).each { |k|
      diags << (0..a.size - 1).collect{|i| a[i][i+k]}.compact
    }
    (0..a[0].size - 1).each { |k|
      diags << (0..a.size - 1).collect{|i| a[i][k-i] if k-i > -1}.compact
    }
    (0..a[0].size - 1).reverse_each { |k|
      diags << (0..a.size - 1).to_a.reverse.collect{|i| a[i][i-k] if i-k > -1}.compact
    }
    (0..a[0].size - 1).reverse_each { |k|
     diags << (0..a.size - 1).to_a.reverse.collect{|i| a[i][k-(i-(a.size-1))]}.compact
    }
    return diags
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
