
require 'test/unit'
require './band_matrix_factory'


class TestBand < Test::Unit::TestCase
	
	def test_fromMatrix
		matrix = Matrix[[1,1,1,0,0,0],[0,2,2,2,0,0],[0,0,3,3,3,0],[0,0,0,4,4,4],[0,0,0,5,5,5]]
		expected = [[0,0,1,1,1],[0,0,2,2,2],[0,0,3,3,3],[0,0,4,4,4],[0,5,5,5,0]]
		b = BandMatrixFactory.create_matrix(matrix)
		
		assert_equal expected, b.data
	end
	
	def test_fromArrays
		arrays = [[1,1,1,0,0,0],[0,2,2,2,0,0],[0,0,3,3,3,0],[0,0,0,4,4,4],[0,0,0,5,5,5]]
		expected = [[0,0,1,1,1],[0,0,2,2,2],[0,0,3,3,3],[0,0,4,4,4],[0,5,5,5,0]]
		b = BandMatrixFactory.create_matrix(arrays)
		
		assert_equal expected, b.data
	end
end