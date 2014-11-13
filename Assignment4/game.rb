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
  @win_condition
  @tokens
  @turn
  @computerized_opponent

  @observers

  def initialize
    @observers = []
  end

  def setup_game(win_condition, \
      computerized_opponent = ComputerizedOpponent.new("easy"), \
      tokens=[1,2])

    @win_condition = win_condition
    @tokens = tokens
    @computerized_opponent = computerized_opponent
  end

  def setup_board(width, height)
    @board = GameBoard.new(width,height)
    @turn = 1
  end

  def add_to_column(column)
    row = @board.col(column).find_index(0)
    @board[row,column] = @tokens[@turn-1]
    @turn = (@turn == 1) ? 2 : 1
    check_win_conditions(row, column) #TODO win condition stuff
    @observers.each{|o| o.update_value(column,row,@board[row,column])}
  end

  def make_human_move(column)
    return if @board.col_full?(column)
    add_to_column(column)
    make_computer_move if @computerized_opponent != nil
  end

  def make_computer_move
    add_to_column(@computerized_opponent.make_move(@board))
  end

  def check_win_conditions(row, column)
    @board.row(0..-1).each{ |r|
      r.each_index{ |i|
        #puts "P#{@turn} wins!" if r[i] != 0 and r[i] == r[i+1] and r[i] == r[i+2] and r[i] == r[i+3]
      }
    }
    (0..@board.row(0).size - 1).each{ |k]
      c = @board.col(k)
      c.each_index{ |i|
        #puts "P#{@turn} wins!" if c[i] != 0 and c[i] == c[i+1] and c[i] == c[i+2] and c[i] == c[i+3]
      }
    }
  end

  #
  # Add a ModelListener
  #
  def add_observer(view)
    @observers << view
  end

end
