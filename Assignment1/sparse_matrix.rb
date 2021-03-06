# encoding: utf-8
#
# = sparse_matrix.rb
#
# An implementation of Spare Matrix
#
# Authors: Evan Degraff, James Finlay
##

require './delegate_matrix'

#
# The +SparseMatrix+ class represents a mathematical sparse matrix. It
# provides enhanced features for creating matrices, operating on them
# arithmetically and algebraically, and determining their mathematical
# properties.
#
# The +SparseMatrix+ class relies on the +Matrix+ class to act as a delegate
# in the event that an optimized method is not implemented.
#
class SparseMatrix < DelegateMatrix
  attr_accessor :data

  #
  # Creates a sparse matrix. Supports as parameters:
  # Matrix
  #
  def initialize(*args)
    if args.size == 1
      from_matrix(args[0]) if args[0].is_a? Matrix
      from_arrays(args[0]) if args[0].is_a? Array and args[0].first
    elsif args.size == 3
			from_hash(args[0], args[1], args[2]) if args[0].is_a? Hash
		end
  end

  #
  # Returns element (+x+,+y+) of the matrix.
  #
  def [](x, y)
    return @data["#{x},#{y}"] || 0
  end

  #
  # Sets element (+x+,+y+) of the matrix to +v+.
  #
  def []=(x, y, v)
    @data["#{x},#{y}"] = v if v != 0
  end

  #
  # Converts a matrix into the hash format, where the values are stored
  # under the form: {"x,y", v}
  #
  def from_matrix(matrix)
    @data = Hash.new
    @row_size = matrix.row_size
    @column_size = matrix.column_size

    DelegateMatrix.iterate_matrix(matrix, Proc.new do |x,y,v|
      self.[]=(x,y,v)
    end)
  end

  #
  # Converts a 2d array into the hash format, where the values are stored
  # under the form: {"x,y", v}
  #
  def from_arrays(arrays)
    @data = Hash.new
    @row_size = arrays.size
    @column_size = arrays.first.size

    DelegateMatrix.iterate_matrix(arrays, Proc.new do |x,y,v|
      self.[]=(x,y,v)
    end)
  end

  #
  # Internal method that fills the hash format from an existing hash.
  #
  def from_hash(hash, row_size, column_size)
    @data = hash.select{|key,value| value != 0}
    @row_size = row_size
		@column_size = column_size
  end

  #
  # Converts stored hash into original matrix
  #
  def to_matrix
    rows = Matrix.zero(@row_size, @column_size).to_a
    @data.to_enum().map{
      |k,v| rows[split_xy(k).last][split_xy(k).first] = v
    }
    Matrix.rows(rows)
  end

  #
  # Splits the key string into x and y values, and returns them as
  # integers.
  #
  def split_xy(key_string)
    return key_string.split(",").map{|v|v.to_i}
  end

  #
  # SparseMatrix addition
  #
  def +(m)
    return method_missing("+", m) if not m.is_a? self.class
    return merge(m, Proc.new do |key, old, new| old + new end)
  end

  #
  # SparseMatrix subtraction
  #
  def -(m)
    return method_missing("-", m) if not m.is_a? self.class
    return merge(m, Proc.new do |key, old, new| old - new end)
  end

  #
  # Merge two sparse matrices
  #
  def merge(m, action)
    return SparseMatrix.new(@data.merge(m.data){
      |key, old, new| action.call(key, old, new)
    }, m.row_size, m.column_size)
  end
end
