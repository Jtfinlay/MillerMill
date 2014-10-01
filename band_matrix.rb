# encoding: utf-8
#
# = band_matrix.rb
#
# An implementation of Band Matrix
#
# Authors: Evan Degraff, James Finlay
##

require './delegate_matrix'

#
# The +BandMatrix+ class represents a mathematical band sparse matrix. It
# provides enhanced features for creating band matrices, operating on them
# arithmetically and algebraically, and determining their mathematical
# properties.
#
# The +BandMatrix+ class inherits from the +SparseMatrix+ class.
#
class BandMatrix < DelegateMatrix
  attr_accessor :data
  @bandwidth

  #
  # Creates a band matrix. Supports as parameters:
  # Matrix
  # 2D Array
  #
  def initialize(*args)
    # TODO - This is nearly the same as SparseMatrix' method. Perhaps
    # we should refactor?
    if args.size == 1
      from_matrix(args[0]) if args[0].is_a? Matrix
      from_arrays(args[0]) if args[0].is_a? Array and args[0].first
    end
  end
  
  #
  # Returns element (+x+,+y+) of the matrix.
  #
  def [](x, y)
    return 0 if !(x-y).between?(-@bandwidth,@bandwidth)
    return @data[y][@bandwidth+x-y]
  end
  
  #
  # Sets element (+x+,+y+) of the matrix to +v+.
  # Ignores values that are not in the band.
  #
  def []=(x, y, v)
    @data[y][@bandwidth+x-y] = v if (x-y).between?(-@bandwidth,@bandwidth)
  end
  
  #
  # Converts a matrix into the compressed 2D array format.
  #
  def from_matrix(matrix)
    @bandwidth = BandMatrixFactory.calculate_bandwidth(matrix)
    @row_size = matrix.row_size
    @column_size = matrix.column_size
    
    @data = Array.new(@row_size){Array.new(@bandwidth*2+1,0)}

    DelegateMatrix.iterate_matrix(matrix, Proc.new do |x,y,v|
      self.[]=(x,y,v)
    end)
  end
  
  #
  # Converts a 2D Array into the compressed 2D array format.
  #
  def from_arrays(array2d)
    @bandwidth = BandMatrixFactory.calculate_bandwidth(array2d)
    @row_size = array2d.size
    @column_size = array2d.first.size
    
    @data = Array.new(@row_size){Array.new(@bandwidth*2+1,0)}
    
    DelegateMatrix.iterate_matrix(array2d, Proc.new do |x,y,v|
      self.[]=(x,y,v)
    end)
  end
  
  #
  # Converts compressed 2D Array into original matrix
  #
  def to_matrix
    rows = Matrix.zero(@row_size, @column_size).to_a
    DelegateMatrix.iterate_matrix(rows, Proc.new do |x,y,v|
      rows[y][x] = self[x,y]
    end)
    Matrix.rows(rows)
  end
  
end
