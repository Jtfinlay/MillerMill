# encoding: utf-8
#
# = sparse_matrix_factory.rb
#
# A factory for making tridiagonal matrices.
#
# Authors: Evan Degraff, James Finlay
##
require './tridiag_matrix'
require './matrix_factory'

class TriDiagMatrixFactory < MatrixFactory
  def initialize

  end

  def TriDiagMatrixFactory.create_matrix(matrix)
    TriDiagMatrix.new(matrix)
  end
end
