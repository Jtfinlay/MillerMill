# encoding: utf-8
#
# = main.rb
#
# Driver that takes inputs and passes it through to the shell.
#
# Authors: Evan Degraff, James Finlay
##

require './shell.rb'

# loop
  # get_command
  # create child/worker process
  # Parent: Wait for worker (child) to finish
  # Child: change job
  # Parent: report results
# end_loop
