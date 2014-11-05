# encoding: utf-8
#
# = merge_sort.rb
#
# Executes concurrent merge sort
#
# Authors: Evan Degraff, James Finlay
##

require './contract_merge_sort'
require 'timeout'

class MergeSort
  include ContractMergeSort

  attr_accessor :compare
  @@CMP_DEFAULT = lambda {|v1, v2| v1 <=> v2}


  def initialize(comparator=@@CMP_DEFAULT)
    pre_initialize(comparator)

    @compare = comparator

    post_initialize
    class_invariant
  end

  def start(max_time, objects)
     pre_start(max_time, objects)
     begin
       result = Timeout::timeout(max_time.to_f) {
         merge_sort(objects, 0, objects.size)
       }
     rescue Timeout::Error
       puts "Sorting timed out"
     end
     post_start
     class_invariant
     return result  
  end

  def merge_sort(a, l, r)
    pre_merge_sort(a, l, r)

    return 0 if (r-l) <= 1

    left = Thread.new { merge_sort(a, l, l+(r-l)/2)}
    right = Thread.new { merge_sort(a, l+1+(r-l)/2, r)}

    left.join
    right.join

    result = Array.new(a.size, 0)
    merge(a[0..a.size/2], a[1+a.size/2..-1], result, 0)

    post_merge_sort(result)
    class_invariant
    return result
  end

  def merge(a, b, c, ci)
    pre_merge(a, b, c, ci)

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
      bm = (b.find_index{|v| @compare.call(v, a[am]) > -1} || b.size)-1
      bm = 0 if bm < 0
      threads << Thread.new{merge(a[0..am], b[0..bm], c, ci)}
      threads << Thread.new{merge(a[am+1..-1], b[bm+1..-1], c, ci+am+bm+2)}
    end

    threads.each{|t| t.join}

    post_merge(c, ci, a.size+b.size)
    class_invariant
  end


end
