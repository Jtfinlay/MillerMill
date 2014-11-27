# encoding: utf-8
#
# = model_controller.rb
#
# Central game controller
#
# Authors: Evan Degraff, James Finlay
##

require './game'
require './contract_game_controller'

class ModelController
  include ContractGameController

  attr_accessor :width, :height, :game
  
  def initialize(gid, type)
    @width = 7
    @height = 6
    setup(gid, type)
  end

  def column_press(pid, column, value)
    return @game.make_move(pid, column, value)
  end

  def subscribe(observer)
    @game.add_observer(observer)
  end

  def add_player(player_name)
    @game.players << player_name
  end

  def setup(gid, type)
    @game = Game.new(gid, type)
    @game.setup_board(@width, @height)
    if type == 1
      @game.setup_game([1,1,1,1], [2,2,2,2])
    else
      @game.setup_game([2,3,3,2], [3,2,2,3])
    end 
  end

  def get_state
    return [@width, @height, @game.turn, @game.board.data]
  end

  def get_player_info(pid)
    return [@game.player_inputs(pid), @game.player_win_conditions(pid)]
  end

end
