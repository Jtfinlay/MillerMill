# encoding: utf-8
#
# = test_game_board.rb
#
# Testing
#
# Authors: Evan Degraff, James Finlay
##

require 'test/unit'
require './game_board'

class TestGameBoard < Test::Unit::TestCase

  def test_board_size

    board = GameBoard.new(10,5)

    assert_equal 10, board.row(0).size
    assert_equal 5, board.col(0).size
  end

  def test_board_value

    board = GameBoard.new(5,5)
    board[1,1] = 1

    assert_equal 1, board[1,1]
    assert_not_same 1, board[1,2]

  end

end
