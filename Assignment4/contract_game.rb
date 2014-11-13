gem 'test-unit'

require 'test/unit/assertions'

module ContractGame
  include Test::Unit::Assertions

  def class_invariant(board, win_condition, tokens, turn, computerized_opponent)
    assert board.is_a?(GameBoard)
    assert win_condition.is_a?(String)
    assert tokens.size == 2
    assert turn == 1 or turn == 2
    assert computerized_opponent.is_a?(ComputerizedOpponent)
  end

  def pre_setup_game(win_condition, computerized_opponent, tokens)
    assert win_condition.is_a?(String)
    assert tokens.size == 2
    assert computerized_opponent.is_a?(ComputerizedOpponent)
  end

  def post_setup_game
  end

  def pre_setup_board(width, height)
    assert width > 0
    assert height > 0
  end

  def post_setup_board(board, turn)
    assert board.is_a?(GameBoard)
    assert turn == 1
  end

  def pre_add_to_column(column)
    assert column > 0
  end

  def post_add_to_column(value)
    # Value is added to board
    value != 0
  end

  def pre_make_human_move(column)
    assert column > 1
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
     assert row > 0
     assert column > 0
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
