# encoding: utf-8
#
# = game_board.rb
#
# Board data model
#
# Authors: Evan Degraff, James Finlay
##

require './contracts/contract_game_board'

class GameBoard
  include ContractGameBoard

  attr_accessor :data

  def initialize(width, height)
    pre_initialize(width, height)
    @data = Array.new(height){Array.new(width, 0)}
    post_initialize(@data, width, height)
    class_invariant(@data)
  end

  def row(row)
    pre_row(@data, row)
    result = @data[row]
    post_row
    class_invariant(@data)
    return result
  end

  def col(col)
    pre_col(@data, col)
    result = @data.flatten.select.with_index{|v,i| i % @data[0].size == col}
    post_col
    class_invariant(@data)
    return result
  end

  def diagonals
    pre_diagonals
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
    post_diagonals(diags)
    class_invariant(@data)
    return diags
  end

  def [](row, col)
    pre_square_brackets(@data, row, col)
    result = @data[row][col]
    post_square_brackets
    class_invariant(@data)
    return result
  end

  def []=(row, col, v)
    pre_square_brackets_equals(@data, row, col, v)
    result = @data[row][col] = v
    post_square_brackets_equals
    class_invariant(@data)
    return result
  end

  def col_full?(column)
    pre_col_full_question(@data, column)
    result = self[col(column).size - 1, column] != 0
    post_col_full_question
    class_invariant(@data)
    return result
  end

end
