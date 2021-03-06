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
  @type

  def initialize(type)
    pre_initialize

    @type = type
    setup

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
    setup
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
