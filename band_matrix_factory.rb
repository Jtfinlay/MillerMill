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
    if is_banded?(matrix)
      BandMatrix.new(matrix)
    else
      return nil
    end
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

  #
  # Calculates bandwidth of a band matrix.
  # Expects 2D array or Matrix as input
  #
  def BandMatrixFactory.calculate_bandwidth(array2d)
    bandwidth = 0
    DelegateMatrix.iterate_matrix(array2d, Proc.new do |x,y,v|
      bandwidth = (x-y).abs if v != 0 and (x-y).abs > bandwidth
    end)
    return bandwidth
  end

end
