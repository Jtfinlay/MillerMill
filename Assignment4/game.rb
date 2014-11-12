# encoding: utf-8
#
# = game.rb
#
# Game data model
#
# Authors: Evan Degraff, James Finlay
##

require './game_board.rb'
require observer

class Game
  include Observable
  @board
  @win_condition
  @tokens
  @turn

  def initialize

  end

  def start_game(win_condition, computerized_opponent, tokens)
    @board = new GameBoard()
    @win_condition = win_condition
    @tokens = tokens 
    @turn = 0 
  end

  def add_to_column(column)
    @board[@board.col(column).find_index{|v| v == nil}, column] = @tokens[@turn]
    @turn = @turn ? 0 : 1
    check_win_conditions
  end

  def check_win_conditions
    # TODO: Cool logic
  end
end
