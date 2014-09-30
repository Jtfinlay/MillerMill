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
  @factories = [TriDiagMatrixFactory, BandMatrixFactory]
  
  def initialize

  end

  def SparseMatrixFactory.create_matrix(matrix)
    SparseMatrix.new if @factories.take_while{|c| c.create_matrix(matrix)}.size == 0
  end

end
