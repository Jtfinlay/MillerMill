
require 'test/unit'
require 'matrix'
require './band_matrix'
require './band_matrix_factory'


class TestBandMatrixFactory < Test::Unit::TestCase

  def test_create_matrix
    # Pre
    # Input is a banded matrix
    m_band = Matrix[ [25, 93, 4, 0, 0], [0, 13, 5, 1, 0], [5, 5, 5, 7, 3], \
      [0, 3, 7, 1, 0], [0, 0, 5, 1, 6] ]
    b = BandMatrixFactory.create_matrix(m_band)

    # Post
    # Returns band matrix equivalent to input matrix
    assert_equal m_band, b.to_matrix
    assert_equal BandMatrix, b.class
  end

  def test_is_valid
    # Pre
    # Input is a matrix
    m_band = Matrix[ [25, 93, 0, 0], [0, 13, 5, 0], [0, 0, 7, 3] ]
    m = Matrix[ [25, 93, 1, 4], [7, 13, 5, 0], [0, 4, 7, 3] ]

    # Post
    # Returns true if matrix is banded, false if not
    assert(BandMatrixFactory.is_valid?(m_band))
    assert(!BandMatrixFactory.is_valid?(m))
  end

  def test_calculate_bandwidth
    # Pre
    # Input is a matrix
    m = Matrix[ [25, 93, 0, 0], [0, 13, 5, 0], [0, 0, 7, 3] ]

    # Post
    # Returns the bandwidth of the matrix
    assert_equal 1, BandMatrixFactory.calculate_bandwidth(m)
  end

end
