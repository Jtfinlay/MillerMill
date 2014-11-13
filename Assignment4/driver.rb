# Note - Need Ruby 1.9.3

require 'gtk2'
require './view'
require './game'
require './game_controller'

width = 10
height = 10

g = Game.new
c = GameController.new(g)
v = View.new(c)

# TODO streamline this
g.start_game(nil, true, [1,2])
v.setup(7,6)
v.start_game
