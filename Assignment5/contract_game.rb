gem 'test-unit'

require 'test/unit/assertions'
require './computerized_opponent'

module ContractGame
  include Test::Unit::Assertions

  def class_invariant
  end

  def pre_initialize
  end

  def post_initialize(observers)
    assert observers.is_a?(Array), "Observers must be array"
  end

  def pre_setup_game(win_condition1, win_conditions2, computer_opponent)
    assert win_condition1.is_a?(Array)
    assert win_condition1.is_a?(Array)
    assert computer_opponent.is_a?(ComputerizedOpponent)
  end

  def post_setup_game(win_condition1, win_conditions2, computer_opponent)
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

  def pre_add_to_column(column)
#    assert column > 0
  end

  def post_add_to_column(value)
    # Value is added to board
    value != 0
  end

  def pre_make_human_move(column)
#    assert column > 1
  end

  def post_make_human_move
    # add_to_column is called
    # make_computer_move is called
  end

  def pre_make_computer_move
  end

  def post_make_computer_move
     # add_to_column is called with result from ComputerizedOpponent
  end

  def pre_check_win_conditions
#     assert row > 0
#     assert column > 0
  end

  def post_check_win_conditions
    # Update listening views if game is won
  end

  def pre_add_observer(view)
    # View is a view
  end

  def post_add_observer
    # View is added to list of observers
  end

end
