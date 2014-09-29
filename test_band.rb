
require 'test/unit'
require './sparse_matrix_factory'


class TestBand < Test::Unit::TestCase
	
	def test_fromMatrix
		matrix = Matrix[[1,1,1,0,0,0],[0,2,2,2,0,0],[0,0,3,3,3,0],[0,0,0,4,4,4],[0,0,0,5,5,5]]
		expected = [[0,0,1,1,1],[0,0,2,2,2],[0,0,3,3,3],[0,0,4,4,4],[0,5,5,5,0]]
		b = BandMatrixFactory.create_matrix(matrix)
		
		assert_equal expected, b.data
	end
	
	def test_fromArrays
		array = [[1,1,1,0,0,0],[0,2,2,2,0,0],[0,0,3,3,3,0],[0,0,0,4,4,4],[0,0,0,5,5,5]]
		expected = [[0,0,1,1,1],[0,0,2,2,2],[0,0,3,3,3],[0,0,4,4,4],[0,5,5,5,0]]
		b = BandMatrixFactory.create_matrix(array)
		
		assert_equal expected, b.data
	end
	
	def test_toMatrix
		matrix = Matrix[[1,1,1,0,0,0],[0,2,2,2,0,0],[0,0,3,3,3,0],[0,0,0,4,4,4],[0,0,0,5,5,5]]
		b = BandMatrixFactory.create_matrix(matrix)
		
		assert_equal matrix, b.to_matrix
	end
	
	def test_Addition
		array = BandMatrixFactory.create_matrix([[1,1,1,0,0,0],[0,2,2,2,0,0],[0,0,3,3,3,0],[0,0,0,4,4,4],[0,0,0,5,5,5]])
		expected = BandMatrixFactory.create_matrix([[2,2,2,0,0,0],[0,4,4,4,0,0],[0,0,6,6,6,0],[0,0,0,8,8,8],[0,0,0,10,10,10]])
		
		assert_equal expected.data, (array+array).data
	end
	
	def test_Subtraction
		array1 = BandMatrixFactory.create_matrix([[1,1,1,0,0,0],[0,2,2,2,0,0],[0,0,3,3,3,0],[0,0,0,4,4,4],[0,0,0,5,5,5]])
		array2 = BandMatrixFactory.create_matrix([[1,1,1,0,0,0],[0,1,1,1,0,0],[0,0,1,1,1,0],[0,0,0,1,1,1],[0,0,0,1,1,1]])
		expected = BandMatrixFactory.create_matrix([[0,0,0,0,0,0],[0,1,1,1,0,0],[0,0,2,2,2,0],[0,0,0,3,3,3],[0,0,0,4,4,4]])
		
		assert_equal expected.data, (array1-array2).data
	end
	
end