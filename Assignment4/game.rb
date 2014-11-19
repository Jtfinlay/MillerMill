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

class Game
  attr_accessor :board, :turn, :computerized_opponent
  @board
  @win_condition1
  @win_condition2
  @computerized_opponent

  @observers

  def initialize
    @observers = []
  end

  def setup_game(win_condition1, \
      win_condition2, \
      computerized_opponent = ComputerizedOpponent.new("easy"))

    @win_condition1 = win_condition1
    @win_condition2 = win_condition2
    @computerized_opponent = computerized_opponent
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
    make_computer_move if @computerized_opponent != nil
  end

  def make_computer_move
    add_to_column(@computerized_opponent.make_move(@board), @win_condition2[rand(0..1)])
  end

  def check_win_conditions(w)
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
    @observers << view
  end

end
