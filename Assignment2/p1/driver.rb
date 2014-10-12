# encoding: utf-8
#
# = driver.rb
#
# Driver that takes inputs and passes it through to the shell.
#
# Authors: Evan Degraff, James Finlay
##

require './shell.rb'
require './custom_commands.rb'

include CustomCommands

exits = ["exit", "quit", "q", "close"]

shell = Shell.new
shell.register("cd", &:change_directory)
shell.register("pwd", &:present_working_directory)

while true
  print shell.prompt
  cmd = gets.chomp

  exit! if exits.include? cmd

  shell.execute cmd

end
