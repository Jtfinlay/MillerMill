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
  def initialize

  end

  def BandMatrixFactory.create_matrix(matrix)
    BandMatrix.new(matrix)
  end

  def BandMatrixFactory.is_banded?(matrix)
    bandwidth = BandMatrixFactory.calculate_bandwidth(matrix).to_f
    #puts matrix.row_size.to_f
    if matrix.row_size.to_f / bandwidth >= 2.0 \
      and matrix.column_size.to_f / bandwidth >= 2.0
      return true
    else
      return false
    end
  end

  def BandMatrixFactory.calculate_bandwidth(matrix)
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
