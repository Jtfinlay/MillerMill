# encoding: utf-8
#
# = driver.rb
#
# Driver that takes inputs for multi-threaded sort
#
# Authors: Evan Degraff, James Finlay
##

require './merge_sort'

if ARGV.length < 2
  puts "Two arguments required: time and objects."
else
  sorter = MergeSort.new
  sorter.sort(ARGV[0].to_i, ARGV[1..-1])
end
