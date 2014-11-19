# encoding: utf-8
#
# = game.rb
#
# Game data model
#
# Authors: Evan Degraff, James Finlay
##

require "./computerized_opponent"
require './game_board'
require './contract_game'

class Game
  include ContractGame

  attr_accessor :board, :turn, :computerized_opponent
  @board
  @win_condition1
  @win_condition2
  @computerized_opponent

  @observers

  def initialize
    pre_initialize
    @observers = []
    post_initialize(@observers)
  end

  def setup_game(win_condition1, \
      win_condition2, \
      computerized_opponent = ComputerizedOpponent.new("easy"))
    pre_setup_game(win_condition1, computerized_opponent)
    @win_condition1 = win_condition1
    @win_condition2 = win_condition2
    @computerized_opponent = computerized_opponent
    post_setup_game
    class_invariant(@board, @win_condition1, @computerized_opponent)
  end

  def setup_board(width, height)
    pre_setup_board(width, height)
    @board = GameBoard.new(width,height)
    post_setup_board(@board)
    class_invariant(@board, @win_condition1, @computerized_opponent)
  end

  def add_to_column(column, value)
    pree_add_to_clumn(column)
    row = @board.col(column).find_index(0)
    @board[row,column] = value
    puts "P1 wins" if check_win_conditions(@win_condition1)
    puts "P2 wins" if check_win_conditions(@win_condition2)
    @observers.each{|o| o.update_value(column,row,@board[row,column])}
    post_add_to_column(value)
    class_invariant(@board, @win_condition1, @computerized_opponent)
  end

  def make_human_move(column, value)
    pre_make_human_move(column)
    return if @board.col_full?(column)
    add_to_column(column, value)
    make_computer_move if @computerized_opponent != nil
    post_make_human_move
    class_invariant(@board, @win_condition1, @computerized_opponent)
  end

  def make_computer_move
    pre_make_computer_move
    add_to_column(@computerized_opponent.make_move(@board), @win_condition2[rand(0..1)])
    post_make_computer_move
    class_invariant(@board, @win_condition1, @computerized_opponent)
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
    class_invariant(@board, @win_condition1, @computerized_opponent)
    return false
  end

  #
  # Add a ModelListener
  #
  def add_observer(view)
    pre_add_observer(view)
    @observers << view
    post_add_observer
    class_invariant(@board, @win_condition1, @computerized_opponent)
  end

end
