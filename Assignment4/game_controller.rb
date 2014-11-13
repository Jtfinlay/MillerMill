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

  @game
  @view

  def initialize
    width = 7
    height = 6

    @game = Game.new
    @game.setup_board(width, height)
    @game.setup_game(nil)

    @view = View.new(self)
    @view.setup(width, height)
  end

  def start_game
    @view.start_game
  end

  def end_game

  end

  def quit

  end

  def restart

  end

  def column_press(column)
    @game.make_human_move(column)
  end

  def subscribe(view)
    @game.add_observer(view)
  end

end
