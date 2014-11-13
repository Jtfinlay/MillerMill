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
  def initialize

  end

  def start_game(type, human_players)

  end
  
  def end_game

  end
 
  def quit

  end

  def column_press(column)
    @game.add_to_column(column)
    @game.make_computer_move if @game.computerized_opponent != nil
  end

end
