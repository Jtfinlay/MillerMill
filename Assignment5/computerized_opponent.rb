# encoding: utf-8
#
# = computerized_opponent.rb
#
# AI for computerized opponent
#
# Authors: Evan Degraff, James Finlay
##
require './game_board'
require './contracts/contract_computerized_opponent'
require 'securerandom'


class ComputerizedOpponent
  include ContractComputerizedOpponent

  attr_accessor :gid, :pid, :board, :server

  def initialize(gid, server)
    @server = server
    @pid = SecureRandom.uuid
    @gid = gid
    w, h, turn, data = @server.current_state(@gid)
    @board = GameBoard.new(w,h)
  end

  def message(msg)
    # ignore
    return 0
  end

  def update_value(x, y, v)
    @board[y,x] = v
  end

  def turn_change
    if @server.whos_turn(@gid) == @pid
      @server.column_press(@gid, @pid, rand_move, 2)
    end
  end

  def game_over(msg)
    return 0
  end

  def rand_move
    r = rand(0..@board.row(0).size - 1)
    result = @board.col_full?(r) ? rand_move(@board) : r
    return result
  end
end
