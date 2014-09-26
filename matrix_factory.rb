# encoding: utf-8
#
# = matrix_factory.rb
#
# An abstract factory for making matrices.
#
# Authors: Evan Degraff, James Finlay
##
class MatrixFactory
  def initialize
    raise NotImplementedError.new('Abstract Class')
  end

  def create_matrix
    raise NotImplementedError.new('Abstract Class')
  end
end
