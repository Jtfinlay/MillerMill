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
    if is_tridiagonal?(matrix)
      TriDiagMatrixFactory.create_matrix(matrix)
    elsif is_banded?(matrix)
      BandMatrixFactory.create_matrix(matrix)
    else
      SparseMatrix.new(matrix)
    end
  end

  def SparseMatrixFactory.is_tridiagonal?(matrix)
    matrix.row_vectors().each_with_index do |row, y|
      row.each_with_index do |v, x|
        if v != 0 and (x-y).abs >= 2
          return false
        end
      end
    end
    return true
  end

  def SparseMatrixFactory.is_banded?(matrix)
    bandwidth = SparseMatrixFactory.calculate_bandwidth(matrix).to_f
    #puts matrix.row_size.to_f
    if matrix.row_size.to_f / bandwidth >= 2.0 \
      and matrix.column_size.to_f / bandwidth >= 2.0
      return true
    else
      return false
    end
  end

  def SparseMatrixFactory.calculate_bandwidth(matrix)
    bandwidth = 0
    matrix.row_vectors().each_with_index do |row, y|
      row.each_with_index do |v, x|
        if v != 0 and (x-y).abs > bandwidth
          bandwidth = (x-y).abs
        end
      end
    end
    return bandwidth
  end

end
