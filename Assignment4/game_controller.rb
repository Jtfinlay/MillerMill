# encoding: utf-8
#
# = game_controller.rb
#
# Central game controller
#
# Authors: Evan Degraff, James Finlay
##

require './view'
require './game'

class GameController

  @@width = 7
  @@height = 6

  @game
  @view
  @type

  def initialize(type)
    @type = type
    setup 
  end

  def start_game
    @view.start_game
  end

  def quit
    @view.kill
  end

  def restart
    @view.kill
    setup
    start_game
  end

  def column_press(column, value)
    @game.make_human_move(column, value)
  end

  def subscribe(observer)
    @game.add_observer(observer)
  end

  def setup
    @game = Game.new
    @game.setup_board(@@width, @@height)
    @view = View.new(self)
    @view.setup(@@width, @@height)
    if @type == 1
      @game.setup_game([1,1,1,1], [2,2,2,2])
      @view.setup_standard(@@width, @@height)
    else
      @game.setup_game([2,3,3,2], [3,2,2,3])
      @view.setup_OTTO(@@width, @@height)
    end 
  end
end
