# encoding: utf-8
#
# = abstract_matrix.rb
#
# An implementation of Spare Matrix
#
# Authors: Evan Degraff, James Finlay
##

require 'matrix'

#
# The +DelegateMatrix+ class represents an abstract sparse matrix class. It
# provides enhanced features for creating matrices, operating on them
# arithmetically and algebraically, and determining their mathematical
# properties.
#
# The +DelegateMatrix+ class relies on the +Matrix+ class to act as a delegate
# in the event that an optimized method is not implemented.
#
class DelegateMatrix
  attr_accessor :row_size, :column_size

  def initialize(*args)
		raise NotImplementedError.new('Abstract Class')
  end

  def to_matrix
		raise NotImplementedError.new('Abstract method')
  end

  #
  # This coerce method provides support for Ruby type coercion.
  # This coercison is used to convert to a Matrix object when
  # there is a conflict.
  #
  def coerce(m)
      return m, self.to_matrix if m.is_a? Matrix
  end

  #
  # This method is called if a method DNE. In this case, we use
  # the Matrix library as a delegate and try to call its function.
  #
  # This specific implementation allows delegation of object methods
  #
  def method_missing(method, *args)
    return DelegateMatrix.cast(self.to_matrix.send(method, *args))
  end

  #
  # This method is called if a method DNE. In this case, we use
  # the Matrix library as a delegate and try to call its function.
  #
  # This specific implementation allows delegation of class methods
  #
  def DelegateMatrix.method_missing(method, *args)
    return DelegateMatrix.cast(Matrix.send(method, *args))
  end

  #
  # If Matrix, then cast to SparseMatrix
  #
  def DelegateMatrix.cast(m)
    return SparseMatrixFactory[m] if m.is_a? Matrix
    return m
  end

  #
  # Iterate through 2d array or matrix and applies block
  #
  def DelegateMatrix.iterate_matrix(m, action)
    m = m.row_vectors if m.is_a? Matrix
    m.each_with_index{
      |row,y| row.each_with_index{
        |v,x| action.call(x, y, v)
      }
    }
  end

  #
  # Returns a string representation
  #
  def to_s
    s = super + "\n"
    self.instance_variables.each do |x|
      s = s + x.to_s + ": " + instance_variable_get(x).to_s + "\n"
    end
    return s
  end
end
