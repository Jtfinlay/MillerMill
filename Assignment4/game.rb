# encoding: utf-8
#
# = game.rb
#
# Game data model
#
# Authors: Evan Degraff, James Finlay
##

require "./computerized_opponent.rb"
require './game_board.rb'
#require observer

class Game
#  include Observable
  attr_accessor :board, :turn, :computerized_opponent
  @board
  @win_condition
  @tokens
  @turn
  @computerized_opponent

  def initialize

  end

  def start_game(win_condition, computerized_opponent, tokens)
    @board = GameBoard.new(7,6)
    @win_condition = win_condition
    @tokens = tokens 
    @turn = 0
    @computerized_opponent = ComputerizedOpponent.new("easy") if computerized_opponent
  end

  def add_to_column(column)
    @board[@board.col(column).find_index(0), column] = @tokens[@turn]
    @turn = @turn ? 0 : 1
    check_win_conditions
#    notify_observers(Time.now)
  end

  def make_computer_move
    add_to_column(@computerized_opponent.make_move(@board))
  end

  def check_win_conditions

  end
end
