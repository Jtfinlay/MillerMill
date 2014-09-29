
require 'test/unit'
require 'matrix'
require './tridiag_matrix'
require './tridiag_matrix_factory'


class TestTriDiagMatrixFactory < Test::Unit::TestCase

  def test_createMatrix
    # Pre
    # Input is a tridiagonal matrix
    m_diag = Matrix[ [25, 93, 0], [1, 13, 5], [0, 7, 3] ]
    t = TriDiagMatrixFactory.create_matrix(m_diag)

    # Post
    # Returns tridiagonal matrix equivalent to input matrix
    assert_equal m_diag, t.to_matrix
    assert_equal TriDiagMatrix, t.class
  end

  def test_is_tridiagonal
    # Pre
    # Input is a matrix
    m_diag = Matrix[ [25, 93, 0], [1, 13, 5], [0, 7, 3] ]
    m_not_diag = Matrix[ [0, 0, 5], [1, 0, 5], [6, 0, 0] ]

    # Post
    # Returns true if tridiagonal, false if not
    assert(TriDiagMatrixFactory.is_tridiagonal?(m_diag))
    assert(!TriDiagMatrixFactory.is_tridiagonal?(m_not_diag))
  end

end
