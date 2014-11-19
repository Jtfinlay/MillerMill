# Note - Need Ruby 1.9.3 for GTK2

require './game_controller'

c = GameController.new

Thread.new {
  while true
    print ">"
    cmd = gets.chomp

    # DO SHIT
  end
}


c.start_game
