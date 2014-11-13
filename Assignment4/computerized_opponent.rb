# encoding: utf-8
#
# = computerized_opponent.rb
#
# AI for computerized opponent
#
# Authors: Evan Degraff, James Finlay
##


class ComputerizedOpponent
  @difficulty
  def initialize(difficulty)
    @difficulty = difficulty
  end
  
  def make_move(game_board)
    return easy_difficulty(game_board) 
  end

  def easy_difficulty(game_board)
    r = rand(0..game_board.row(0).size - 1)
    return r
  end
end
