

require 'test/unit/assertions'
require './game_board'

module ContractGameBoard
  include Test::Unit::Assertions

  def class_invariant
  end

  def pre_initialize(difficulty)
    assert difficulty.is_a?(String), "Difficulty must be string"
    assert difficulty.size > 0, "String cannot be empty"
  end

  def post_initialize
  end

  def pre_make_move(game_board)
    assert game_board.is_a?(GameBoard), "Param must be object GameBoard"
  end

  def post_make_move(result)
    assert result.is_a?(Fixnum), "Result must be Fixnum"
    assert result >= 0, "Result cannot be negative"
  end

  def pre_easy_difficulty(game_board)
    assert game_board.is_a?(GameBoard), "Param must be object GameBoard"
  end

  def post_easy_difficulty(result)
    assert result.is_a?(Fixnum), "Result must be Fixnum"
    assert result >= 0, "Result cannot be negative"
  end

end
