
require 'test/unit'
require './sparse_matrix'
require 'matrix'

class TestSparse < Test::Unit::TestCase

	def test_fromMatrix
		m = Matrix[ [25, 93], [0, 13] ]
		expected = Hash["0,0", 25, "1,0", 93, "1,1", 13]
		
		assert_equal expected, SparseMatrix.new(m).coords
	end
	
	def test_toMatrix
		m = Matrix[ [25, 93], [0, 13] ]
		s = SparseMatrix.new(m)
		
		assert_equal m, s.to_matrix
	end
	
	def test_Addition
		s = SparseMatrix.new(Matrix[ [2, 4], [6, 8] ])
		m = Matrix[ [2,2], [2,2] ]
		expected = SparseMatrix.new(Matrix[ [4, 6], [8, 10] ])
		
		assert_equal (s+m).coords, expected.coords
	end

	def test_Subtraction
		s = SparseMatrix.new(Matrix[ [2, 4], [6, 8] ])
		m = Matrix[ [2,2], [2,2] ]
		expected = SparseMatrix.new(Matrix[ [0, 2], [4, 6] ])
		
		assert_equal (s-m).coords, expected.coords
	end
end