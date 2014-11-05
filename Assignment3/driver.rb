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
<<<<<<< HEAD
  sorter.start(ARGV[0].to_f, ARGV[1..-1])
=======
  puts sorter.sort(ARGV[0].to_i, ARGV[1..-1])
>>>>>>> b376c16de701f9feeb015a5da3b6b4ff0d975f23
end
