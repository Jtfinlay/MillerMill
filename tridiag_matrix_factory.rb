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
    if is_tridiagonal?(matrix)
      TriDiagMatrix.new(matrix)
    else
      return nil
    end
  end

  def TriDiagMatrixFactory.is_tridiagonal?(matrix)
    matrix.row_vectors().each_with_index do |row, y|
      row.each_with_index do |v, x|
        if v != 0 and (x-y).abs >= 2
          return false
        end
      end
    end
    return true
  end
end
