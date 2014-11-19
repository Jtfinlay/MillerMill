# encoding: utf-8
#
# = computerized_opponent.rb
#
# AI for computerized opponent
#
# Authors: Evan Degraff, James Finlay
##

require './contract_computerized_opponent'


class ComputerizedOpponent
  include ContractComputerizedOpponent

  def initialize
    pre_initialize
    post_initialize
    class_invariant
  end

  def make_move(game_board)
    pre_make_move(game_board)
    result = rand_move(game_board)
    post_make_move(result)
    class_invariant
    return result
  end

  def rand_move(game_board)
    pre_rand_move(game_board)
    r = rand(0..game_board.row(0).size - 1)
    result = game_board.col_full?(r) ? rand_move(game_board) : r
    post_rand_move(result)
    class_invariant
    return r
  end
end
