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
  
  #
  # Checks data type and returns a sparse matrix type.
  #
  def SparseMatrixFactory.[](matrix)
    return @factories.each.find{
      |c| c.is_valid?(matrix)
    }.create_matrix(matrix)
  end

  def SparseMatrixFactory.create_matrix(matrix)
    return SparseMatrix.new(matrix)
  end
  
  #
  # Insert a MatrixFactory-type class into the factories list at the
  # specified index.
  #
  def SparseMatrixFactory.subscribe(factory, index)
    @factories.insert(index, factory)
  end

  #
  # Returns true since all matrices can be represented as sparse,
  # even if they aren't sparse.
  #
  def SparseMatrixFactory.is_valid?(matrix)
    return true
  end

end
