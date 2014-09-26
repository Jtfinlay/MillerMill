
require 'test/unit'
require 'matrix'
require './sparse_matrix_factory'
require './sparse_matrix'
require './tridiag_matrix'


class TestSparse < Test::Unit::TestCase

  def test_createMatrix
    # Pre
    # Input is a matrix
    m_sparse = Matrix[ [0, 0, 5], [1, 0, 5], [6, 0, 0] ]
    m_diag = Matrix[ [25, 93, 0], [1, 13, 5], [0, 7, 3] ]
    s = SparseMatrixFactory.create_matrix(m_sparse)
    t = SparseMatrixFactory.create_matrix(m_diag)

    # Post
    # Returns sparse matrix that is equivalent to matrix
    # Returns tridiagonal matrix if input matrix is tridiagonal
    assert_equal m_sparse, s.to_matrix
    assert_equal m_diag, t.to_matrix
    assert_equal SparseMatrix, s.class
    assert_equal TriDiagMatrix, t.class
  end

  def test_is_tridiagonal
    # Pre
    # Input is a matrix
    m_diag = Matrix[ [25, 93, 0], [1, 13, 5], [0, 7, 3] ]
    m_not_diag = Matrix[ [0, 0, 5], [1, 0, 5], [6, 0, 0] ]

    # Post
    # Returns true if tridiagonal, false if not
    assert(SparseMatrixFactory.is_tridiagonal?(m_diag))
    assert(!SparseMatrixFactory.is_tridiagonal?(m_not_diag))
  end

end
