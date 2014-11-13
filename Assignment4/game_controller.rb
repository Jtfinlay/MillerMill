# encoding: utf-8
#
# = game_controller.rb
#
# Central game controller
#
# Authors: Evan Degraff, James Finlay
##

class GameController

  @model
  def initialize(model)
    @model = model
  end

  def start_game(type, human_players)

  end

  def end_game

  end

  def quit

  end

  def column_press(column)
    @model.add_to_column(column)
    @model.make_computer_move if @model.computerized_opponent != nil
  end

end
