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
require './contracts/contract_game'
require './stats'

class Game
  include ContractGame

  attr_accessor :board, :turn, :players, :game_type, :gameID
  @win_conditions
  @stats
  @observers

  def initialize(gid, game_type)
    @gameID = gid
    @game_type = game_type
    @observers = []
    @players = []
    @turn = 0
    @stats = Stats.new("mysqlsrv.ece.ualberta.ca", "ece421grp7", "Afbgt7oE", "ece421grp7", 13010)
  end

  def setup_game(win_condition1, win_condition2)
    @win_conditions = [win_condition1, win_condition2]
  end

  def setup_board(width, height)
    @board = GameBoard.new(width,height)
  end

  def add_to_column(column, value)
    row = @board.col(column).find_index(0)
    @board[row,column] = value
    if check_win_conditions(@win_conditions[0])
      @observers.each{|o| o.game_over("#{players[0]} wins!", @gameID)}
      @stats.add_stat(@gameID, players[0], players[1], players[0])
    elsif check_win_conditions(@win_conditions[1])
      @observers.each{|o| o.game_over("#{players[1]} wins!", @gameID)} 
      @stats.add_stat(@gameID, players[0], players[1], players[1])
    end
    @observers.each{|o| o.game_over("Draw!")} if check_board_full?
    @observers.each{|o| o.update_value(column,row,@board[row,column], @gameID)}
  end

  def make_move(pid, column, value)
    return [false, "Not your turn"] if pid != @players[@turn]
    return [false, "Error: column full"] if @board.col_full?(column)

    add_to_column(column, value)
    @turn = (@turn == 0) ? 1 : 0
    return [true, "#{@players[@turn]} goes next!"]
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

  def player_inputs(pid)
    if @game_type == 1
      if @players.find_index(pid) == 0
        return [[1,"X"]]
      elsif @players.find_index(pid) == 1
        return [[2,"O"]]
      else
        return []
      end
    else
      return [[2,"O"], [3,"T"]];
    end
  end

  def player_win_conditions(pid)
    index = @players.find_index(pid)
    return [] if index.nil?
    return @win_conditions[index]
  end

  #
  # Add a ModelListener
  #
  def add_observer(view)
    @observers << view
  end

end
