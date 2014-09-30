
require 'test/unit'
require './sparse_matrix_factory'


class TestSparseMatrix < Test::Unit::TestCase
  def class_invariant(s)
    assert(s.row_size >= 0)
    assert(s.column_size >= 0)
    # No zero elements are stored
    assert(!s.coords.values.include?(0))
    # No indices are negative
  end

  def test_square_brackets
    # Pre
    # Inputs are positive integers
    # 0 <= x <= row_size
    # 0 <= y <= column_size
    x = 1
    y = 1
    m = SparseMatrix.new([ [1, 0], [2, 3] ])

    # Post
    # Returns the element at the specified indices
    assert_equal 1, m[0,0]
    assert_equal 2, m[0,1]
    assert_equal 0, m[1,0]
    assert_equal 3, m[1,1]
  end

  def test_square_brackets_equals
    # Pre
    # Inputs are positive integers
    # 0 <= x <= row_size
    # 0 <= y <= column_size
    x = 1
    y = 1
    v = 10
    s = SparseMatrix.new([ [2, 4], [6, 8] ])

    # Post
    # Element at specified position is set to specified value
    s[x,y] = v
    assert_equal v, s[x, y]
  end

  def test_fromMatrix
    # Pre
    # Input is a matrix
    m = Matrix[ [25, 93], [0, 13] ]
    expected = Hash["0,0", 25, "1,0", 93, "1,1", 13]

    # Post
    # Returns a sparse matrix
    # Sparse matrix contains all non-zero elements in hash
    assert_equal expected, SparseMatrix.new(m).coords
  end
  
  def test_fromArray
    # Pre
    # Input is a matrix
    a = [ [25, 93], [0, 13] ]
    expected = Hash["0,0", 25, "1,0", 93, "1,1", 13]
    
    # Post
    # Returns a sparse matrix
    # Sparse matrix contains all non-zero elements in hash
    assert_equal expected, SparseMatrix.new(a).coords
  end

  def test_toMatrix
    # Pre
    # None
    m = Matrix[ [25, 93], [0, 13] ]
    s = SparseMatrix.new(m)

    # Post
    # Sparse matrix is converted into normal matrix
    assert_equal m, s.to_matrix
  end

  def test_Addition
    # Pre
    # Sparse matrices are same size
    s = SparseMatrix.new(Matrix[ [2, 4], [6, 8] ])
    m = SparseMatrix.new(Matrix[ [2,2], [2,2] ])
    expected = SparseMatrix.new(Matrix[ [4, 6], [8, 10] ])

    # Post
    # Returns sparse matrix whose elements are an addition of the
    # two input matrices.
    assert_equal expected.coords, (s+m).coords
  end

  def test_Subtraction
    # Pre
    # Sparse matrices are same size
    s = SparseMatrix.new(Matrix[ [2, 4], [6, 8] ])
    m = SparseMatrix.new(Matrix[ [2,2], [2,2] ])
    expected = SparseMatrix.new(Matrix[ [0, 2], [4, 6] ])

    # Post
    # Returns sparse matrix whose elements are equal to the first
    # matrix subtracted by the second matrix
    assert_equal expected.coords, (s-m).coords
  end

  def test_Multiplication
    # Pre
    # Sparse matrices are same size
    s = SparseMatrixFactory.create_matrix(Matrix[ [2, 4], [6, 8] ])
    m = SparseMatrixFactory.create_matrix(Matrix[ [2,2], [2,2] ])
    expected = SparseMatrixFactory.create_matrix(Matrix[ [12, 12], [28, 28] ])

    # Post
    # Returns sparse matrix which is equal to the first matrix multiplied
    # by the second matrix
    assert_equal expected.coords, (s*m).coords
  end

  def test_Division
    # Pre
    # Sparse matrices are same size
    s = SparseMatrixFactory.create_matrix(Matrix[ [2,4], [6,8] ])
    m = SparseMatrixFactory.create_matrix(Matrix[ [2,2], [2,2] ])
    expected = SparseMatrixFactory.create_matrix(Matrix[ [-0.5, 0.5], [-0.5, 0.5] ])

    # Post
    # Returns sparse matrix which is equal to the first matrix divided
    # by the second matrix
    assert_equal expected.coords, (m/s).coords
  end

  def test_split_xy
    # Pre
    # Input is a string in the form of "a,b" where a and b are integers
    key_string = "1,2"
    s = SparseMatrix.new

    # Post
    # Returns the two integers in the string as Integers
    assert_equal 1, s.split_xy(key_string)[0]
    assert_equal 2, s.split_xy(key_string)[1]
  end
  
  def test_diagonal
    # Pre
    # 0 <= x
    # 0 <= y
    x = 1
    y = 1
    
    s = SparseMatrix.diagonal(x,y)
    
    # Post
    # SparseMatrix, containing 1s in diagonal
    assert_equal Hash["0,0", 1, "1,1", 1], s.coords
  end
  
  def test_zero
    # Pre
    # 0 <= x
    # 0 <= y
    x = 3
    y = 2
    
    s = SparseMatrix.zero(x,y)
    
    # Post
    # Empty coords, since all zeroes
    # Row_count == x
    # Column_count == y
    assert_equal ({}), s.coords
    assert_equal x, s.row_size
    assert_equal y, s.column_size
  end
  
  def test_determinant
    # Pre
    # SparseMatrix with pre-evaluted determinant
    m = SparseMatrix.new([ [1,0,3,4,7], [5,7,2,5,77], [6,0,9,3,6], [3,8,1,0,8], [4,98,2,6,3] ])
    expected = 231744
    
    # Post
    # Determinant equals expected
    assert_equal expected, m.determinant
  end
  
end
