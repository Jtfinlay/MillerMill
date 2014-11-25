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

class GameController
  include ContractGameController

  attr_accessor :type

  @@width = 7
  @@height = 6
  @game

  def initialize
    @type = false
    @game = Game.new
  end

  def players
    return @game.players
  end

  def add_player
    @game.players += 1
  end

  def column_press(column, value)
    @game.make_human_move(column, value)
  end

  def subscribe(observer)
    @game.add_observer(observer)
  end

  def setup(type)
    @type = type
    @game.setup_board(@@width, @@height)
    if @type == 1
      @game.setup_game([1,1,1,1], [2,2,2,2])
    else
      @game.setup_game([2,3,3,2], [3,2,2,3])
    end
  end
end
