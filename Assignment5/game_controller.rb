# encoding: utf-8
#
# = game_controller.rb
#
# Central game controller
#
# Authors: Evan Degraff, James Finlay
##

require './game'
require './contract_game_controller'
require './abstract_listener'

class GameController
  include ContractGameController

  attr_accessor :type, :width, :height

  @game

  def initialize
    @type = false
    @game = Game.new
    @width = 7
    @height = 6
  end

  def players
    return @game.players
  end

  def player_turn
    return @game.pturn
  end

  def add_player(pid)
    @game.players << pid
    return @game.players.size
  end

  def column_press(column, pid, value)
    return @game.make_human_move(column, pid, value)
  end

  def turn_count
    return @game.turn_count
  end

  def subscribe(observer)
    @game.add_observer(observer)
  end

  def setup(type)
    @type = type
    @game.setup_board(@width, @height)
    if @type == 1
      @game.setup_game([1,1,1,1], [2,2,2,2])
    else
      @game.setup_game([2,3,3,2], [3,2,2,3])
    end
  end
end
