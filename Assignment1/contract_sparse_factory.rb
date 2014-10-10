require './matrix_factory'
require './sparse_matrix_factory'
require './sparse_matrix'
require 'matrix'
require 'test/unit'

class ContractSparseFactory < Test::Unit::TestCase

  def class_invariant(selF)
    assert(selF.factories.is_a?(Array))
    assert(!selF.factories.empty?)
    assert(selF.factories.index{|v| !v.is_a?(Class)}.nil?)
    assert(selF.factories.index{|v| !v.method_defined?(:create_matrix)}.nil?)
    assert(selF.factories.index{|v| !v.method_defined?(:is_valid?)}.nil?)
  end

  def pre_square_brackets(selF, matrix)
    assert(selF.factories.index{|c| c.is_valid?(matrix)})
  end

  def post_square_brackets(selF, matrix, result)
    assert(selF.factories.index{|c| result.is_a?(c)})
  end

  def pre_create_matrix(matrix)
    assert((matrix.is_a?(Matrix) or matrix.is_a?(Array)))
    assert(matrix.first && matrix.first.is_a?(Array)) if matrix.is_a?(Array)
    assert(MatrixFactory.is_valid?(matrix))
    if matrix.is_a? Matrix
      vectors = matrix.row_vectors
    else
      vectors = matrix
    end
    assert(vectors.index{
      |r| (not r.is_a?(Array)) or (r.index{
        |v| not v.is_a?(Numeric)
      }
    ).nil?})
  end

  def post_create_matrix(matrix, result)
    assert(result.is_a? SparseMatrix)
  end

  def pre_is_valid(matrix)
    assert((matrix.is_a?(Matrix) or matrix.is_a?(Array)))
    assert(matrix.first && matrix.first.is_a?(Array)) if matrix.is_a?(Array)
  end

  def post_is_valid(matrix, result)
    assert_equal (matrix.is_a?(Matrix) or matrix.is_a?(Array)), result
  end

  def pre_subscribe(selF, factory, index)
    assert(index <= selF.factories.size)
    assert(index >= 0)
    assert(factory.is_a? Class)
    assert(factory.method_defined? :create_matrix)
    assert(factory.method_defined? :is_valid)
  end

  def post_subscribe(selF, factory, index)
    assert(!selF.factories.empty?)
    assert(selF.factories[index] == factory)
  end

end
