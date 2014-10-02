require './sparse_matrix'
require 'matrix'
require 'test/unit'


class ContractBand < Test::Unit::TestCase

  def class_invariant(s)
    assert(s.row_size >= 0)
    assert(s.column_size >= 0)
    # No zero elements are stored
    assert(!s.data.values.include?(0))
    # No indices are negative
    # No indices are outside row or column
    assert(!s.data.to_enum.find{
      |key, v| split_xy(key)[0] >= s.row_size or split_xy(key)[1] >= s.column_size
    })
  end

  def pre_initialize(*args)
    assert(args.size == 1 || args.size == 3)
    if args.size == 1
      assert(args[0].is_a?(Matrix) || (args[0].is_a?(Array) && args[0].first))
    elsif args.size == 3
      assert(args[0].is_a?(Hash))
      assert(args[1].is_a?(Numeric))
      assert(args[2].is_a?(Numeric))
      assert(0 <= args[1])
      assert(0 <= args[2])
    end
  end

  def post_initialize(selF, *args)
    assert(!selF.data.nil?)
    assert(!selF.row_size.nil?)
    assert(!selF.column_size.nil?)
  end

  def pre_square_brackets(selF, x, y)
    assert(0 <= x <= selF.row_size)
    assert(0 <= x <= selF.column_size)
  end

  def post_square_brackets(selF, x, y, result)
    assert_equal selF.data["#{x},#{y}"], result
  end

  def pre_square_brackets_equals(selF, x, y, v)
    assert(0 <= x <= selF.row_size)
    assert(0 <= x <= selF.column_size)
    assert(v.is_a? Numeric)
  end

  def post_square_brackets_equals(selF, x, y, v, result)
    assert_equal v, selF.data["#{x},#{y}"]
  end

  def pre_fromMatrix(matrix)
    assert matrix.is_a? Matrix
  end

  def post_fromMatrix(matrix, result)
    assert result.is_a? SparseMatrix
    assert_equal matrix, result.to_matrix
  end

  def pre_from_arrays(array)
    assert array.is_a? Array
  end

  def post_from_array(array, result)
    assert result.is_a? SparseMatrix
    assert_equal array, result.data
  end

  def pre_to_matrix(selF)

  end

  def post_to_matrix(sparse, result)
    assert result.is_a? Matrix
    assert_equal sparse, SparseMatrixFactory.create_matrix(result)
  end

  def pre_split_xy(key_string)
    assert key_string.include? ","
  end

  def post_split_xy(result)
    assert result.size >= 2
    assert result[0].is_a? Numeric
    assert result[1].is_a? Numeric
  end

  def pre_plus(selF, m)
    assert_equal selF.row_size, m.row_size
    assert_equal selF.column_size, m.row_size
  end

  def post_plus(selF, m, result)
    assert_equal selF.row_size, result.row_size
    assert_equal selF.column_size, result.row_size
    assert_equal(selF.to_matrix + m.to_matrix, result.to_matrix)
    assert result.is_a? SparseMatrix
  end

  def pre_subtract(selF, m)
    assert_equal selF.row_size, m.row_size
    assert_equal selF.column_size, m.row_size
  end

  def post_subtract(selF, m, result)
    assert_equal selF.row_size, result.row_size
    assert_equal selF.column_size, result.row_size
    assert_equal(selF.to_matrix - m.to_matrix, result.to_matrix)
    assert result.is_a? SparseMatrix
  end

  def pre_merge(selF, m, action)
    assert_equal selF.row_size, m.row_size
    assert_equal selF.column_size, m.row_size
  end

  def post_merge(selF, m, action, result)
    assert_equal selF.row_size, result.row_size
    assert_equal selF.column_size, result.row_size
    assert result.is_a? SparseMatrix
  end
end
