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
    @computerized_opponent = computerized_oppoent
  end

  def setup_board(width, height)
    @board = GameBoard.new(width,height)
    @turn = 1
  end

  def add_to_column(column)
    row = @board.col(column).find_index(0)
    @board[row,column] = @tokens[@turn-1]
    @turn = (@turn == 1) ? 2 : 1
    check_win_conditions #TODO win condition stuff
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

  def check_win_conditions

  end

  #
  # Add a ModelListener
  #
  def add_observer(view)
    @observers << view
  end

end
