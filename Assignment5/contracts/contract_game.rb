gem 'test-unit'

require 'test/unit/assertions'
require './computerized_opponent'

module ContractGame
  include Test::Unit::Assertions

  def class_invariant
  end

  def pre_initialize(gid, game_type)
    assert gid.is_a?(String)
    assert game_type(Fixnum)
  end

  def post_initialize
  end

  def pre_setup_game(win_condition1, win_conditions2)
    assert win_condition1.is_a?(Array)
    assert win_condition1.is_a?(Array)
  end

  def post_setup_game(win_condition1, win_conditions2)
    assert win_condition1.is_a?(Array)
    assert win_condition1.is_a?(Array)
  end

  def pre_setup_board(width, height)
    assert width > 0
    assert height > 0
  end

  def post_setup_board(board)
    assert board.is_a?(GameBoard)
  end

  def pre_add_to_column(column, value)
    assert column.is_a?(Fixnum)
    assert value.is_a?(Fixnum)
  end

  def post_add_to_column(value)
    # Value is added to board
  end

  def pre_make_move(pid, column, value)
    assert pid.is_a?(String)
    assert column.is_a?(Fixnum)
    assert value.is_a?(Fixnum)
  end

  def post_make_move(result1, result2)
    assert result1.is_a?(TrueClass)
    assert result2.is_a?(String)
  end

  def pre_check_win_conditions
  end

  def post_check_win_conditions
    # Update listening views if game is won
  end

  def pre_check_board_full?
  end

  def post_check_board_full?
    assert(result.is_a?(TrueClass) || result.is_a?(FalseClass))
  end

  def pre_player_inputs(pid)
    assert pid.is_a?(String)
  end

  def post_player_inputs(result1, result2)
    assert result1.is_a?(Array)
    assert result2.is_a?(Array)
  end

  def pre_player_win_conditions(pid)
    assert pid.is_a?(String)
  end

  def post_player_inputs(result)
    assert result.is_a?(Array)
  end

  def pre_add_observer(view)
    # View is a view
  end

  def post_add_observer
    # View is added to list of observers
  end

end
