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
require './band_matrix_factory'

class SparseMatrixFactory < MatrixFactory
  def initialize

  end

  def SparseMatrixFactory.create_matrix(matrix)
    if TriDiagMatrixFactory.is_tridiagonal?(matrix)
      TriDiagMatrixFactory.create_matrix(matrix)
    elsif BandMatrixFactory.is_banded?(matrix)
      BandMatrixFactory.create_matrix(matrix)
    else
      SparseMatrix.new(matrix)
    end
  end

end
