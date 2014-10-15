# encoding: utf-8
#
# = driver.rb
#
# Driver that takes inputs and passes it to cron
#
# Authors: Evan Degraff, James Finlay
##

require './timed_message'

if ARGV.length < 2
  puts "Two arguments required: time and message"
else
  TimedMessage.schedule_message(ARGV[0].to_i, ARGV[1])
end
