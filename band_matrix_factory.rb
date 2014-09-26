# encoding: utf-8
#
# = sparse_matrix_factory.rb
#
# A factory for making band matrices.
#
# Authors: Evan Degraff, James Finlay
##
require './band_matrix'
require './matrix_factory'

class BandMatrixFactory < MatrixFactory
  def initialize:

  end

  def create_matrix(matrix)
    BandMatrix.new(matrix)
  end
end
