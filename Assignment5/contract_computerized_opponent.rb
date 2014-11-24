gem 'test-unit'

require 'test/unit/assertions'

module ContractComputerizedOpponent
  include Test::Unit::Assertions

  def class_invariant
  end

  def pre_initialize()
  end

  def post_initialize
  end

  def pre_make_move(game_board)
    assert game_board.is_a?(GameBoard), "Board must be proper object"
  end

  def post_make_move(result)
    assert result.is_a?(Fixnum), "Result must be fixnum"
  end

  def pre_rand_move(game_board)
    assert game_board.is_a?(GameBoard), "Board must be proper object"
  end

  def post_rand_move(result)
    assert result.is_a?(Fixnum), "Result must be Fixnum"
  end

end
