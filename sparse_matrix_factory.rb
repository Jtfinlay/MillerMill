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
  @factories = [TriDiagMatrixFactory, BandMatrixFactory, SparseMatrixFactory]
  
  def initialize

  end
  
  def SparseMatrixFactory.[](matrix)
    return @factories.each.find{
      |c| c.is_valid?(matrix)
    }.create_matrix(matrix)
  end

  def SparseMatrixFactory.create_matrix(matrix)
    return SparseMatrix.new(matrix)
  end
  

  #
  # Returns true since all matrices can be represented as sparse,
  # even if they aren't sparse.
  #
  def SparseMatrixFactory.is_valid?(matrix)
    return true
  end

end
