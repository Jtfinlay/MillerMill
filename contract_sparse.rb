require './band_matrix_factory'
require './band_matrix'


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
      assert(args[0]is_a? Matrix || (args[0]is_a? Array and args[0].first))
    elsif args.size == 3
      assert(args[0]is_a? Hash)
      assert args[1].is_a? Numeric
      assert args[2].is_a? Numeric
      assert 0 <= args[1]
      assert 0 <= args[2]
    end
  end

  def post_initialize(self, *args)
    assert(!self.data.nil?)
    assert(!self.row_size.nil?)
    assert(!self.column_size.nil?)
  end

  def pre_square_brackets(self, x, y)
    assert(0 <= x <= self.row_size)
    assert(0 <= x <= self.column_size)
  end

  def post_square_brackets(self, x, y, result)
    assert_equal self.data["#{x},#{y}"], result
  end

  def pre_square_brackets_equals(self, x, y, v)
    assert(0 <= x <= self.row_size)
    assert(0 <= x <= self.column_size)
    assert(v.is_a? Numeric)
  end

  def post_square_brackets_equals(self, x, y, v, result)
    assert_equal v, self.data["#{x},#{y}"]
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

  def pre_to_matrix(self)

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

  def pre_plus(self, m)
    assert_equal self.row_size, m.row_size
    assert_equal self.column_size, m.row_size
  end

  def post_plus(self, m, result)
    assert_equal self.row_size, result.row_size
    assert_equal self.column_size, result.row_size
    assert_equal(self.to_matrix + m.to_matrix, result.to_matrix)
    assert result.is_a? SparseMatrix
  end

  def pre_subtract(self, m)
    assert_equal self.row_size, m.row_size
    assert_equal self.column_size, m.row_size
  end

  def post_subtract(self, m, result)
    assert_equal self.row_size, result.row_size
    assert_equal self.column_size, result.row_size
    assert_equal(self.to_matrix - m.to_matrix, result.to_matrix)
    assert result.is_a? SparseMatrix
  end

  def pre_merge(self, m, action)
    assert_equal self.row_size, m.row_size
    assert_equal self.column_size, m.row_size
  end

  def post_merge(self, m, action, result)
    assert_equal self.row_size, result.row_size
    assert_equal self.column_size, result.row_size
    assert result.is_a? SparseMatrix
  end
end
