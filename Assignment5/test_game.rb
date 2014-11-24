

require 'test/unit'
require './game.rb'
class TestGame < Test::Unit::TestCase

  def test_basic_functionality
    g = Game.new
    g.start_game("1111", true, [1,2])

    g.add_to_column(1)
    g.make_computer_move

    assert_equal(1, g.board[0, 1])
  end

end
