require './merge_sort.rb'

# Demonstrate usage of MergeSort

a = [-4,3,5,7,43,2,67,4,4,56,6,7,8,53,43,34,54,56]

puts "Before sorting: #{a}"

m = MergeSort.new
# Pass timeout in seconds and array to sort
m.start(100,a)

puts "After sorting: #{a}"
