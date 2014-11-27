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

class ModelController
  include ContractGameController

  attr_accessor :width, :height, :game
  
  def initialize(type)
    @width = 7
    @height = 6
    setup(type)
  end

  def column_press(column, value)
    @game.make_human_move(column, value)
  end

  def subscribe(observer)
    @game.add_observer(observer)
  end

  def add_player(player_name)
    @game.players << player_name
  end

  def setup(type)
    @game = Game.new
    @game.setup_board(@width, @height)
    if @type == 1
      @game.setup_game([1,1,1,1], [2,2,2,2])
    else
      @game.setup_game([2,3,3,2], [3,2,2,3])
    end 
  end
end
