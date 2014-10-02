require 'test/unit'

class ContractMatrixFactory < Test::Unit::TestCase

  def class_invariant()
    # Abstract interface
  end

  def pre_create_matrix()
    # Abstract method
  end

  def post_create_matrix()
    # Abstract method
  end

  def pre_is_valid()
    # Abstract method
  end

  def post_is_valid()
    # Abstract method
  end

end
