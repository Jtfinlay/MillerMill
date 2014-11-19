gem 'test-unit'

require 'test/unit/assertions'

module ContractGameBoard
  include Test::Unit::Assertions

  def class_invariant(data)
    assert data.is_a?(Array), "@data must be an array"
    assert data.size > 0, "@data cannot be empty"
    data.each{|v|
      assert v.is_a?(Array), "@data rows must be arrays"
      assert v.size > 0, "@data rows cannot be empty"
    }
  end

  def pre_initialize(width, height)
    assert width.is_a?(Fixnum), "Width must be a Fixnum"
    assert width > 0, "Width must be greater than 0"
    assert height.is_a?(Fixnum), "Height must be a Fixnum"
    assert height > 0, "Height must be greater than 0"
  end

  def post_initialize(data, width, height)
    assert data.size == height, "Data size should be == height"
    data.each{|v|
      assert v.size == width, "Data row size should be == width"
      v.each{|i|
        assert i.is_a?(Fixnum), "Data values should be Fixnum"
        assert i==0, "Data vlues should initialize to 0"
      }
    }
  end

  def pre_row(data, row)
    assert row.is_a?(Fixnum), "Row index must be Fixnum"
    assert row >= 0, "Row index cannot be negative"
    assert row < data.size, "Row index cannot be larger than array"
  end

  def post_row
  end

  def pre_col(col)
    assert col.is_a?(Fixnum), "Col index must be Fixnum"
    assert col >= 0, "Col index cannot be negative"
    assert col < data.size, "Col index cannot be larger than array"
  end

  def post_col
  end

  def pre_diagonals
  end

  def post_diagonals(result)
    assert result.is_a?(Array), "Result should be array"
  end

  def pre_square_brackets(data, row, col)
    assert row.is_a?(Fixnum), "Row index must be Fixnum"
    assert col.is_a?(Fixnum), "Col index must be Fixnum"
    assert row >= 0, "Row index cannot be negative"
    assert row < data.size, "Row index cannot be larger than array"
    assert col >= 0, "Col index cannot be negative"
    assert col < data.size, "Col index cannot be larger than array"
  end

  def post_square_backets()
  end

  def pre_square_brackets_equals(row, col, v)
    assert row.is_a?(Fixnum), "Row index must be Fixnum"
    assert col.is_a?(Fixnum), "Col index must be Fixnum"
    assert row >= 0, "Row index cannot be negative"
    assert row < data.size, "Row index cannot be larger than array"
    assert col >= 0, "Col index cannot be negative"
    assert col < data.size, "Col index cannot be larger than array"
  end

  def post_square_brackets_equals
  end

  def pre_col_full_question(column)
    assert col.is_a?(Fixnum), "Col index must be Fixnum"
    assert col >= 0, "Col index cannot be negative"
    assert col < data.size, "Col index cannot be larger than array"
  end

  def post_col_full_question
  end

end
