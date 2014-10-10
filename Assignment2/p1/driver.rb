# encoding: utf-8
#
# = driver.rb
#
# Driver that takes inputs and passes it through to the shell.
#
# Authors: Evan Degraff, James Finlay
##

require './shell.rb'

exits = ["exit", "quit", "q", "close", "fuckoff"]
shell = Shell.new

while true
  print shell.prompt
  cmd = gets.chomp

  exit! if exits.include? cmd

  shell.execute cmd

end
