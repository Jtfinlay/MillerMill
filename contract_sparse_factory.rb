require './sparse_matrix_factory'

class ContractSparseFactory < Test::Unit::TestCase

  def class_invariant(self)
    assert(f.factories.is_a? Array)
    assert(not f.factories.empty?)
    assert(f.factories.index{|v| !v.is_a? Class}.nil?)
    assert(f.factories.index{|v| !v.method_defined? :create_matrix}.nil?)
    assert(f.factories.index{|v| !v.method_defined? :is_valid?}.nil?)
  end
  
  def pre_square_brackets(self, matrix)
    assert(f.factories.index{|c| c.is_valid? matrix})
  end
  
  def post_square_brackets(self, matrix, result)
    assert(f.factories.index{|c| result.is_a? c})
  end
  
  def pre_create_matrix(matrix)
    assert(matrix.is_a? Matrix or matrix.is_a? Array)
    assert(matrix.first and matrix.first.is_a? Array) if matrix.is_a? Array
    assert(MatrixFactory.is_valid? matrix)
    vectors = matrix.row_vectors if matrix.is_a? Matrix else matrix
    assert(vectors.index{
      |r| (not r.is_a? Array) or (r.index{
        |v| not v.is_a? Numeric
      }
    ).nil?}
  end
  
  def post_create_matrix(matrix, result)
    assert(result.is_a? SparseMatrix)
  end
  
  def pre_is_valid(matrix)
    assert(matrix.is_a? Matrix or matrix.is_a? Array)
    assert(matrix.first and matrix.first.is_a? Array) if matrix.is_a? Array
  end
  
  def post_is_valid(matrix, result)
    assert_equal matrix.is_a? Matrix or matrix.is_a? Array, result
  end
  
  def pre_subscribe(self, factory, index)
    assert(index <= f.factories.size)
    assert(index >= 0)
    assert(factory.is_a? Class)
    assert(factory.method_defined? :create_matrix)
    assert(factory.method_defined? :is_valid)
  end
  
  def post_subscribe(self, factory, index)
    assert(!f.factories.empty?)
    assert(f.factories[index] == factory)
  end
  
end