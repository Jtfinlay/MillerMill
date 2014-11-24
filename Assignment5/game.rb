# encoding: utf-8
#
# = game.rb
#
# Game data model
#
# Authors: Evan Degraff, James Finlay
##

require './game_board'
require './contract_game'

class Game
  include ContractGame

  attr_accessor :board, :turn, :players
  @board
  @win_condition1
  @win_condition2

  @observers

  def initialize
    @observers = []
  end

  def setup_game(win_condition1, win_condition2)
    @win_condition1 = win_condition1
    @win_condition2 = win_condition2
  end

  def setup_board(width, height)
    @board = GameBoard.new(width,height)
  end

  def add_to_column(column, value)
    row = @board.col(column).find_index(0)
    @board[row,column] = value
    @observers.each{|o| o.game_over("P1 wins!")} if check_win_conditions(@win_condition1)
    @observers.each{|o| o.game_over("P2 wins!")} if check_win_conditions(@win_condition2)
    @observers.each{|o| o.game_over("Draw!")} if check_board_full?
    @observers.each{|o| o.update_value(column,row,@board[row,column])}
  end

  def make_human_move(column, value)
    return if @board.col_full?(column)
    add_to_column(column, value)
  end

  def check_win_conditions(w)
    pre_check_win_conditions
    @board.row(0..-1).each{ |r|
      r.each_index{ |i|
        return true if r[i] == w[0] and r[i+1] == w[1] and r[i+2] == w[2] and r[i+3] == w[3]
      }
    }
    (0..@board.row(0).size - 1).each{ |k|
      c = @board.col(k)
      c.each_index{ |i|
        return true if c[i] == w[0] and c[i+1] == w[1] and c[i+2] == w[2] and c[i+3] == w[3]
      }
    }
    @board.diagonals.each{ |d|
      d.each_index{ |i|
        return true if d[i] == w[0] and d[i+1] == w[1] and d[i+2] == w[2] and d[i+3] == w[3]
      }
    }
    post_check_win_conditions
    class_invariant
    return false
  end

  def check_board_full?
    (0..@board.row(0).size - 1).each{ |k|
      return false if !@board.col_full?(k)
    }
    return true
  end

  #
  # Add a ModelListener
  #
  def add_observer(view)
    pre_add_observer(view)
    @observers << view
    post_add_observer
    class_invariant
  end

end
