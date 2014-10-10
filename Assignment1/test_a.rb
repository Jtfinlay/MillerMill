  
  
  
require 'test/unit'
require './sparse_matrix_factory'


class TestA < Test::Unit::TestCase


  def test_addSparseMatrix
    
    # SparseMatrix object are optimized to handle faster addition and 
    # subtraction than their Matrix counterparts.
    
    # Ensure not banded matrix, but is sparse.
    size = 5000
    m = Matrix.build(size,size){|row,col| (col == size-1 or col == 0) ? 1 : 
0}
    s = SparseMatrixFactory[m]
    
    ti = Time.now
    m_result = m+m
    tf = Time.now
    puts "Matrix: #{tf-ti}"
    
    ti = Time.now
    s_result = s+s
    tf = Time.now
    puts "SparseMatrix: #{tf-ti}"
    
    assert(true)
    
  end
end