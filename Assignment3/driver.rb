# encoding: utf-8
#
# = driver.rb
#
# Driver that takes inputs for multi-threaded sort
#
# Authors: Evan Degraff, James Finlay
##

require './sort_manager'

if ARGV.length < 2
  puts "Two arguments required: time and file name."
else
  manager = SortManager.new
  manager.sort(ARGV[0].to_i, ARGV[1..-1])
end
