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
require './contract_game_controller'

class GameController
  include ContractGameController

  @@width = 7
  @@height = 6

  @game
  @view

  def initialize
    pre_initialize

    @game = Game.new
    @game.setup_board(@@width, @@height)
    @game.setup_game([2,3,3,2], [3,2,2,3])

    @view = View.new(self)
    @view.setup(@@width, @@height)
    @view.setup_OTTO(@@width, @@height)

    post_initialize(@game, @view)
    class_invariant
  end

  def start_game
    pre_start_game(@view)

    @view.start_game

    post_start_game
    class_invariant
  end

  def quit
    pre_quit(@view)

    @view.kill

    post_quit
    class_invariant

    post_quit
    class_invariant
  end

  def restart
    pre_restart(@view, @game)

    @view.kill
    @view.setup(@@width, @@height)
    @game.setup_board(@@width, @@height)
    start_game

    post_restart
    class_invariant
  end

  def column_press(column, value)
    pre_column_press(column, value)

    @game.make_human_move(column, value)

    post_column_press
    class_invariant
  end

  def subscribe(observer)
    pre_subscribe(@game, observer)

    @game.add_observer(observer)

    post_subscribe
    class_invariant
  end

end
