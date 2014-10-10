# encoding: utf-8
#
# = matrix_factory.rb
#
# An abstract factory for making matrices.
#
# Authors: Evan Degraff, James Finlay
##
class MatrixFactory

  #
  # Create matrix from given params
  #
  def MatrixFactory.create_matrix
    raise NotImplementedError.new('Abstract Class')
  end

  #
  # Returns true if input is valid for matrix type
  #
  def MatrixFactory.is_valid?(matrix)
    raise NotImplementedError.new('Abstract Class')
  end
end
