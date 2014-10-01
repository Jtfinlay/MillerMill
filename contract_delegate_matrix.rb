
require 'test/unit'
require './sparse_matrix_factory'
require './delegate_matrix'


class ContractDelgateMatrix < Test::Unit::TestCase

  def class_invariant(s)
    assert(s.row_size >= 0)
    assert(s.column_size >= 0)
  end

  def pre_initialize
    # Abstract method
  end

  def post_initialize
    # Abstract method
    # Inheriting classes should set row_size and class_size
  end

  def pre_to_matrix
    # Abstract method
  end

  def post_to_matrix
    # Abtract method
    # Inheriting classes should return a matrix
  end

  def pre_coerce(m)
  end

  def post_coerce(m, result1, result2)
    assert_equal m, result1
    assert result2.is_a? Matrix
  end

  def pre_method_missing(method, *args)
    assert(!DelegateMatrix.method_defined? :"#{method}")
    assert(Matrix.method_defined? :"#{method}")
  end

  def post_method_missing(method, *args, result)
    assert(!result.is_a? Matrix)
    # Contracts of method called in Matrix must hold
  end

  def pre_static_method_missing(method, *args)
    assert(!DelegateMatrix.method_defined? :"#{method}")
    assert(Matrix.method_defined? :"#{method}")
  end

  def post_static_method_missing(method, *args, result)
    assert(!result.is_a? Matrix)
    # Contracts of method called in Matrix must hold
  end

  def pre_cast(matrix)
    assert(matrix.is_a? Matrix)
  end

  def post_cast(result)
    assert(!result.is_a? Matrix)
  end

  def pre_iterate_matrix(m, action)
    assert(m.is_a? Matrix)
  end

  def post_iterate_matrix
  end
end
