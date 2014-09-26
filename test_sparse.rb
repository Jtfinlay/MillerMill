
require 'test/unit'
require './sparse_matrix_factory'


class TestSparse < Test::Unit::TestCase

	def test_createMatrix
		m = Matrix[ [25, 93], [0, 13] ]
		s = SparseMatrixFactory.create_matrix(m)
		
		assert_equal m, s.to_matrix
	end
	
	def test_createDiagonal
		m = SparseMatrixFactory.create_matrix(Matrix[ [1, 0], [0, 1]])
		s = SparseMatrix.diagonal(1,1)
		
		assert_equal m.coords, s.coords
	end
	
	def test_zero
		m = SparseMatrixFactory.create_matrix(Matrix[ [0,0],[0,0]])
		s = SparseMatrix.zero(2)
		
		assert_equal m.coords, s.coords
	end
	
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
		m = SparseMatrix.new(Matrix[ [2,2], [2,2] ])
		expected = SparseMatrix.new(Matrix[ [4, 6], [8, 10] ])
		
		assert_equal expected.coords, (s+m).coords
	end

	def test_Subtraction
		s = SparseMatrix.new(Matrix[ [2, 4], [6, 8] ])
		m = SparseMatrix.new(Matrix[ [2,2], [2,2] ])
		expected = SparseMatrix.new(Matrix[ [0, 2], [4, 6] ])
		
		assert_equal expected.coords, (s-m).coords
	end
	
	def test_Multiplication
		s = SparseMatrixFactory.create_matrix(Matrix[ [2, 4], [6, 8] ])
		m = SparseMatrixFactory.create_matrix(Matrix[ [2,2], [2,2] ])
		expected = SparseMatrixFactory.create_matrix(Matrix[ [12, 12], [28, 28] ])
		
		
		assert_equal expected.coords, (s*m).coords
	end
	
	def test_Division
		s = SparseMatrixFactory.create_matrix(Matrix[ [2,4], [6,8] ])
		m = SparseMatrixFactory.create_matrix(Matrix[ [2,2], [2,2] ])
		expected = SparseMatrixFactory.create_matrix(Matrix[ [-0.5, 0.5], [-0.5, 0.5] ])
		
		assert_equal expected.coords, (m/s).coords
	end
end