# encoding: utf-8
#
# = sparse_matrix_factory.rb
#
# A factory for making sparse matrices.
#
# Authors: Evan Degraff, James Finlay
##
require 'matrix'
require './sparse_matrix'
require './matrix_factory'
require './tridiag_matrix_factory'

class SparseMatrixFactory < MatrixFactory
  def initialize

  end

  def create_matrix(matrix)
    if is_tridiagonal?(matrix)
      tridiag_factory = TriDiagMatrixFactory.new
      tridiag_factory.create_matrix(matrix)
    else
      SparseMatrix.new(matrix)
    end
  end

  def is_tridiagonal?(matrix)
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
