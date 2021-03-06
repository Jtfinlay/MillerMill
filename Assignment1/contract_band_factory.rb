require './band_matrix_factory'
require 'matrix'
require 'test/unit'

class ContractBandFactory < Test::Unit::TestCase

  def class_invariant()

  end

  def pre_create_matrix(matrix)
    assert((matrix.is_a?(Matrix) or matrix.is_a?(Array)))
    assert(matrix.first && matrix.first.is_a?(Array)) if matrix.is_a?(Array)
    assert(BandMatrixFactory.is_valid? matrix)
    if matrix.is_a? Matrix
      vectors = matrix.row_vectors
    else
      vectors = matrix
    end
    assert(vectors.index{
      |r| (not r.is_a?(Array)) or (r.index{
        |v| not v.is_a?(Numeric)
      }
    ).nil?})
  end

  def post_create_matrix(matrix, result)
    assert(result.is_a?(BandMatrix))
  end

  def pre_is_valid(matrix)
    assert((matrix.is_a?(Matrix) or matrix.is_a?(Array)))
    assert(matrix.first && matrix.first.is_a?(Array)) if matrix.is_a?(Array)
  end

  def post_is_valid(matrix, bandwidth, result)
    assert_equal result, matrix.row_size.to_f > 2.0 * bandwidth and \
      matrix.column_size.to_f > 2.0 * bandwidth
  end

  def pre_calculate_bandwidth(array2d)
    assert((matrix.is_a?(Matrix) or matrix.is_a?(Array)))
    assert(matrix.first && matrix.first.is_a?(Array)) if matrix.is_a?(Array)
  end

  def post_calculate_bandwidth(array2d, result)
    assert(bandwidth >= 0)
    if matrix.is_a? Matrix
      vectors = matrix.row_vectors
    else
      vectors = matrix
    end
    assert(vectors.index{
      |r| (not r.is_a?(Array)) or (r.index{
        |v| not v.is_a?(Numeric)
      }
    ).nil?})
  end

end
