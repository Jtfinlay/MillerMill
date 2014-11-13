# encoding: utf-8
#
# = game_controller.rb
#
# Central game controller
#
# Authors: Evan Degraff, James Finlay
##

class GameController

  @game
  def initialize(model)
    @game = model
  end

  def start_game(type, human_players)

  end

  def end_game

  end

  def quit

  end

  def column_press(column)
    @game.make_human_move(column)
  end

  def subscribe(view)
    @game.add_observer(view)
  end

end
