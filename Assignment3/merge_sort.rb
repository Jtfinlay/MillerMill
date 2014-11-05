# encoding: utf-8
#
# = merge_sort.rb
#
# Executes concurrent merge sort
#
# Authors: Evan Degraff, James Finlay
##

require './contract_merge_sort'

class MergeSort
  include ContractMergeSort

  def initialize
  end

  def start(max_time, objects)
     # TODO max_time trigger
     result = merge_sort(objects, 0, objects.size)

  end

  def merge_sort(a, l, r)
    return 0 if (r-l) <= 1

    left = Thread.new { merge_sort(a, l, l+(r-l)/2)}
    right = Thread.new { merge_sort(a, l+1+(r-l)/2, r)}

    left.join
    right.join

    result = Array.new(a.size, 0)
    merge(a[0..a.size/2], a[1+a.size/2..-1], result, 0)

    return result
  end

  def merge(a, b, c, ci)
    threads = []
    b ||= Array.new

    if (b.size > a.size)
      merge(b, a, c, ci)
      return
    end


    if (a.size+b.size == 1)
      c[ci] = a[0]
    elsif (a.size == 1)
      c[ci,2] = a[0] < b[0] ? [a[0],b[0]] : [b[0],a[0]]
    else
      am = (a.size-1)/2
      bm = (b.find_index{|v| (v <=> a[am]) > -1} || b.size)-1
      bm = 0 if bm < 0
      threads << Thread.new{merge(a[0..am], b[0..bm], c, ci)}
      threads << Thread.new{merge(a[am+1..-1], b[bm+1..-1], c, ci+am+bm+2)}
    end

    threads.each{|t| t.join}
  end


end
