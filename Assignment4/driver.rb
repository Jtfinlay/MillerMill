# Note - Need Ruby 1.9.3

require 'gtk2'
require './view'

width = 10
height = 10

m = Model.new(width,height)
c = GameController.new(m)
v = View.new(c,width,height)
