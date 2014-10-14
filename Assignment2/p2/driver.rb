# encoding: utf-8
#
# = driver.rb
#
# Driver that takes inputs and passes it to cronc.
#
# Authors: Evan Degraff, James Finlay
##

# loop
  # get_command
  # check parameters (time, message)
  # pass parameters to C code
# end_loop
require './cron'

if ARGV.length < 2
  puts "Two arguments required: time and message"
  exit
end

Cron.timed_message(ARGV[0].to_i, ARGV[1])
