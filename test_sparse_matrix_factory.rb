
require 'test/unit'
require 'matrix'
require './sparse_matrix_factory'
require './sparse_matrix'
require './tridiag_matrix'


class TestSparseMatrixFactory < Test::Unit::TestCase

  def test_createMatrix
    # Pre
    # Input is a matrix
    m_sparse = Matrix[ [0, 0, 5], [1, 0, 5], [6, 0, 0] ]
    m_diag = Matrix[ [25, 93, 0], [1, 13, 5], [0, 7, 3] ]
    m_band = Matrix[ [25, 93, 4, 0, 0], [0, 13, 5, 1, 0], [5, 5, 5, 7, 3], \
      [0, 3, 7, 1, 0], [0, 0, 5, 1, 6] ]
    s = SparseMatrixFactory[m_sparse]
    t = SparseMatrixFactory[m_diag]
    b = SparseMatrixFactory[m_band]

    # Post
    # Returns sparse matrix that is equivalent to matrix
    # Returns tridiagonal matrix if input matrix is tridiagonal
    # Returns band matrix if input matrix is banded but not tridiagonal
    assert_equal m_sparse, s.to_matrix
    assert_equal m_diag, t.to_matrix
    assert_equal m_band, b.to_matrix
    assert_equal SparseMatrix, s.class
    assert_equal TriDiagMatrix, t.class
    assert_equal BandMatrix, b.class
  end

end
