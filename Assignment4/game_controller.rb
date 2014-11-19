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

  def initialize
    @game = Game.new
    @game.setup_board(@@width, @@height)
    @game.setup_game([1,1,1,1], [2,2,2,2])

    @view = View.new(self)
    @view.setup(@@width, @@height)
    @view.setup_standard(@@width, @@height)
  end

  def start_game
    @view.start_game
  end

  def quit
    @view.kill
  end

  def restart
    @view.kill
    @view.setup(@@width, @@height)
    @game.setup_board(@@width, @@height)
    start_game
  end

  def column_press(column, value)
    # TODO - use value with OTTO/TOOT
    @game.make_human_move(column)
  end

  def subscribe(observer)
    @game.add_observer(observer)
  end

end
