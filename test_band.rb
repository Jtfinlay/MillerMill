
require 'test/unit'
require './sparse_matrix_factory'


class TestBand < Test::Unit::TestCase

  def class_invariant(s)
    assert(s.row_size >= 0)
    assert(s.column_size >= 0)
    # All elements stored are within bandwidth
    assert(s.data.size == s.bandwidth)
    
  end
  
  def test_fromMatrix
    # Pre
    # Input is a banded Matrix
    matrix = Matrix[[1,1,1,0,0,0],[0,2,2,2,0,0],[0,0,3,3,3,0],[0,0,0,4,4,4],[0,0,0,5,5,5]]
    b = BandMatrixFactory.create_matrix(matrix)

    # Post
    # Returns band matrix equivalent to input matrix
    expected = [[0,0,1,1,1],[0,0,2,2,2],[0,0,3,3,3],[0,0,4,4,4],[0,5,5,5,0]]
    assert_equal expected, b.data
  end
  
  def test_from_arrays
    # Pre
    # Input is a 2d array
    array = [[1,1,1,0,0,0],[0,2,2,2,0,0],[0,0,3,3,3,0],[0,0,0,4,4,4],[0,0,0,5,5,5]]
    b = BandMatrixFactory.create_matrix(array)
    
    # Post
    # Returns band matrix equivalent to input 2d array
    expected = [[0,0,1,1,1],[0,0,2,2,2],[0,0,3,3,3],[0,0,4,4,4],[0,5,5,5,0]]
    assert_equal expected, b.data
  end
  
  def test_to_matrix
    # Pre
    # Input is a banded matrix
    matrix = Matrix[[1,1,1,0,0,0],[0,2,2,2,0,0],[0,0,3,3,3,0],[0,0,0,4,4,4],[0,0,0,5,5,5]]
    b = BandMatrixFactory.create_matrix(matrix)
    
    # Post
    # Returns Matrix object equivalent to input banded matrix
    assert_equal matrix, b.to_matrix
  end
  
  def test_Addition
    # Pre
    # Input is two banded matrices
    array = BandMatrixFactory.create_matrix([[1,1,1,0,0,0],[0,2,2,2,0,0],[0,0,3,3,3,0],[0,0,0,4,4,4],[0,0,0,5,5,5]])
    
    # Post
    # Returns sum of both matrices in banded matrix format
    expected = BandMatrixFactory.create_matrix([[2,2,2,0,0,0],[0,4,4,4,0,0],[0,0,6,6,6,0],[0,0,0,8,8,8],[0,0,0,10,10,10]])
    assert_equal expected.data, (array+array).data
  end
  
  def test_Subtraction
    # Pre
    # Input is two banded matrices
    array1 = BandMatrixFactory.create_matrix([[1,1,1,0,0,0],[0,2,2,2,0,0],[0,0,3,3,3,0],[0,0,0,4,4,4],[0,0,0,5,5,5]])
    array2 = BandMatrixFactory.create_matrix([[1,1,1,0,0,0],[0,1,1,1,0,0],[0,0,1,1,1,0],[0,0,0,1,1,1],[0,0,0,1,1,1]])
  
    # Post
    # Returns difference in banded matrix format
    expected = BandMatrixFactory.create_matrix([[0,0,0,0,0,0],[0,1,1,1,0,0],[0,0,2,2,2,0],[0,0,0,3,3,3],[0,0,0,4,4,4]])
    assert_equal expected.data, (array1-array2).data
  end
  
end