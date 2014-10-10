require './band_matrix_factory'
require './band_matrix'
require "test/unit"
require 'matrix'


class ContractBand < Test::Unit::TestCase

  def class_invariant(b)
    assert(b.row_size >= 0)
    assert(b.column_size >= 0)
    # All elements stored are within bandwidth
    assert(b.data.size == row_size)
    assert(b.data.first.size <= b.column_size) if not b.data.first.nil?
    assert(b.bandwidth*2+1 <= b.column_size)
    # All Numeric values
    assert(b.data.index{
      |r| (not r.is_a? Array) or (r.index{
        |v| not v.is_a? Numeric
      }
    ).nil?})
  end

  def pre_initialize(*args)
    assert_equal args.size 1
    assert(args[0].is_a? Matrix || (args[0].is_a? Array and args[0].first.is_a? Array))
  end

  def post_initialize(selF, *args)
    assert !selF.bandwidth.nil?
  end

  def pre_square_brackets(selF, x, y)
    assert(0 <= x <= selF.row_size)
    assert(0 <= y <= selF.column_size)
  end

  def post_square_brackets(selF, x, y, result)
    if (x-y).between?(-selF.bandwidth,selF.bandwidth)
      assert_equal selF.data[y][selF.bandwidth+x-y], result
    else
      assert_equal 0, result
    end
  end

  def pre_square_brackets_equals(selF, x, y, v)
    assert(0 <= x <= selF.row_size)
    assert(0 <= x <= selF.column_size)
    assert((x-y).between?(-selF.bandwidth,selF.bandwidth))
    assert(v.is_a? Numeric)
  end

  def post_square_brackets_equals(selF, x, y, v, result)
    assert_equal v, selF.data[y][selF.bandwidth+x-y]
  end

  def pre_fromMatrix(matrix)
    assert matrix.is_a? Matrix
    assert BandMatrixFactory.is_valid?(matrix)
  end

  def post_fromMatrix(matrix, result)
    assert result.is_a? BandMatrix
    assert_equal matrix, result.to_matrix
  end

  def pre_from_arrays(array)
    assert array.is_a? Array
    assert assert BandMatrixFactory.is_valid?(array)
  end

  def post_from_arrays(array, result)
    assert result.is_a? BandMatrix
    assert_equal array, result.data
  end

  def pre_to_matrix(selF)

  end

  def post_to_matrix(band, result)
    assert result.is_a? Matrix
    assert_equal band, BandMatrixFactory.create_matrix(result)
  end

end
