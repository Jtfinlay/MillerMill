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
       result = Array.new(objects.size, 0)
       Timeout::timeout(max_time.to_f) {
         merge_sort(objects, 0, objects.size, result)
       }
     rescue Timeout::Error
       puts "Sorting timed out"
     end
     post_start
     class_invariant
     return result  
  end

  def merge_sort(a, l, r, result)
    pre_merge_sort(a, l, r)

    if (r-l) <= 1
      puts "Returning, because r-l <=1"
      return 0
    end

#    left = Thread.new { merge_sort(a, l, l+(r-l)/2, result)}
#    right = Thread.new { merge_sort(a, l+1+(r-l)/2, r, result)}
    left =  merge_sort(a, l, l+(r-l)/2, result)
    right = merge_sort(a, l+1+(r-l)/2, r, result)

    #left.join
    #right.join

    puts " -------------- "
    tmp = "Left: "
    a[l..l+(r-l)/2].each{|v| tmp += "#{v}, "}
    puts tmp

    tmp = "Right: "
    a[1+l+(r-l)/2..r].each{|v| tmp += "#{v}, "}
    puts tmp

    merge(a[l..l+(r-l)/2], a[1+l+(r-l)/2..r], result, l)

    tmp = "Merged: "
    result.each{|v| tmp += "#{v}, "}
    puts tmp

    gets


#    post_merge_sort(result)
#    class_invariant
    return result
  end

  def merge(a, b, c, ci)
    
    puts "--"
    tmp = "MA: "
    a.each{|v| tmp += "#{v}, "}
    puts tmp

    tmp = "MB: "
    b.each{|v| tmp += "#{v}, "}
    puts tmp

    b ||= Array.new
#    pre_merge(a, b, c, ci)

    threads = []

    if (b.size > a.size)
      merge(b, a, c, ci)
      return
    end

    if (a.size+b.size == 1)
      puts "c[#{ci}] << #{a[0]}"
      c[ci] = a[0]
    elsif (a.size == 1)
      puts "c[#{ci},2] << #{a[0]}, #{b[0]}" if a[0] < b[0]
      puts "c[#{ci},2] << #{b[0]}, #{a[0]}" if a[0] >= b[0]
      c[ci,2] = a[0] < b[0] ? [a[0],b[0]] : [b[0],a[0]]
    else
      am = (a.size-1)/2
      #bm = (b.find_index{|v| @compare.call(v, a[am]) > -1} || b.size)-1
      bm = (b.find_index{|v| (v <=> a[am]) > -1} || b.size)-1
      threads << Thread.new{merge(a[0..am], b[0..bm], c, ci)} if bm >= 0
      threads << Thread.new{merge(a[am+1..-1], b[bm+1..-1], c, ci+am+bm+2)} if bm >= 0
      threads << Thread.new{merge(a[0..am], [], c, ci)} if bm == -1
      threads << Thread.new{merge(a[am+1..-1], b[0..-1], c, ci+am+1)} if bm == -1
    end

    threads.each{|t| t.join}

    post_merge(c, ci, a.size+b.size)
    class_invariant
  end


end
