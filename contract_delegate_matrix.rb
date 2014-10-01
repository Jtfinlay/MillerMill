
require 'test/unit'
require './sparse_matrix_factory'
require './delegate_matrix'


class ContractDelgateMatrix < Test::Unit::TestCase

  def class_invariant(s)
    assert(s.row_size >= 0)
    assert(s.column_size >= 0)
  end

  def pre_coerce
    # Pre
    # Input is a banded Matrix

    # Post
    # Returns band matrix equivalent to input matrix
  end

  def pre_method_missing
    # Pre
    # Method does not exist in current class, but does exist in Matrix


    # Post
    # Calls the method in class Matrix, and returns the result
    # Converts back to appropriate matrix type(Sparse, Band)
  end

  def pre_static_method_missing
    # Pre
    # Method does not exist in current class, but does exist in Matrix

    # Post
    # Calls the method in class Matrix, and returns the result
    # Converts back to appropriate matrix type(Sparse, Band)
  end

  def pre_cast
    # Pre
    # Input is a matrix

    # Post
    # If not Matrix class, return with no change
    # If Matrix class, return as appropriate type, (Sparse, Band)

  end

  def pre_iterate_matrix
    # Pre
    # Input is 2D array or matrix

    # Post

  end

end
