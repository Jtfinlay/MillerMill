
require 'test/unit'
require './sparse_matrix_factory'


class TestSparse < Test::Unit::TestCase

	def test_createMatrix
		expected = {
			"0,0" => 25,
			"1,0" => 93,
			"1,1" => 13 }
		s = SparseMatrixFactory.create_matrix(Matrix[ [25, 93], [0, 13] ])
		
		assert_equal expected, s.coords
	end
	
	def test_createDiagonal
		expected = {
			"0,0" => 1,
			"1,1" => 1 }
		s = SparseMatrix.diagonal(1,1)
		
		assert_equal expected, s.coords
	end
	
	def test_zero
		expected = {}
		s = SparseMatrix.zero(2)
		
		assert_equal expected, s.coords
	end
	
	def test_fromMatrix
		expected = {
			"0,0" => 25,
			"1,0" => 93,
			"1,1" => 13 }
		m = Matrix[ [25, 93], [0, 13] ]
		
		assert_equal expected, SparseMatrix.new(m).coords
	end
	
	def test_toMatrix
		expected = Matrix[ [25, 93], [0, 13] ]
		s = SparseMatrix.new(expected)
		
		assert_equal expected, s.to_matrix
	end
	
	def test_Addition
		a = SparseMatrix.new(Matrix[ [2, 4], [6, 8] ])
		b = SparseMatrix.new(Matrix[ [2,2], [2,2] ])
		expected = SparseMatrix.new(Matrix[ [4, 6], [8, 10] ])
		
		assert_equal expected.coords, (a+b).coords
	end

	def test_Subtraction
		a = SparseMatrix.new(Matrix[ [2, 4], [6, 8] ])
		b = SparseMatrix.new(Matrix[ [2,2], [2,2] ])
		expected = SparseMatrix.new(Matrix[ [0, 2], [4, 6] ])
		
		assert_equal expected.coords, (a-b).coords
	end
	
	def test_Multiplication
		s = SparseMatrixFactory.create_matrix(Matrix[ [2, 4], [6, 8] ])
		m = SparseMatrixFactory.create_matrix(Matrix[ [2,2], [2,2] ])
		expected = SparseMatrixFactory.create_matrix(Matrix[ [12, 12], [28, 28] ])
		
		
		assert_equal expected.coords, (s*m).coords
	end
	
	def test_Division
		a = SparseMatrixFactory.create_matrix(Matrix[ [2,4], [6,8] ])
		b = SparseMatrixFactory.create_matrix(Matrix[ [2,2], [2,2] ])
		expected = SparseMatrixFactory.create_matrix(Matrix[ [-0.5, 0.5], [-0.5, 0.5] ])
		
		assert_equal expected.coords, (b/a).coords
	end
end