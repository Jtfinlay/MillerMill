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

    left = Thread.new { merge_sort(a, l, (r-l)/2)}
    right = Thread.new { merge_sort(a, 1+(r-l)/2, r)}

    left.join
    right.join

    result = Array.new(a.size, 0)
    merge(a[0..a.size/2], a[1+a.size/2..-1], result)

    return result
  end

  def merge(a, b, c)
#    if (b.size > a.size)
#      merge(b, a, c)
#      return
#    end
    threads = []

    puts "#-----------------------#"
    puts "merge: #{a.size}, #{b.size}, #{c.size}"
    tmp = "A: "
    a.each{|v| tmp << " #{v},"}
    puts tmp
    tmp = "B: "
    b.each{|v| tmp << " #{v},"}
    puts tmp

    if (b.size > a.size)
      merge(b, a, c)
      return
    end


    if (c.size == 1)
      c[0] = a[0]
    elsif (a.size == 1)
      c[0,2] = a[0] < b[0] ? [a[0],b[0]] : [b[0],a[0]]
    else
      am = (a.size-1)/2
      bm = (b.find_index{|v| (v <=> a[am]) > -1} || b.size)-1
      bm = 0 if bm < 0
      puts "#{am}, #{bm}, #{bm.class}"
#      gets
      #threads << Thread.new{merge(a[0..am], b[0..bm], c[0..am+bm+1])}
      #threads << Thread.new{merge(a[am+1..-1], b[bm+1..-1], c[am+bm+2..c.size])}
      merge(a[0..am], b[0..bm], c[0..am+bm+1])
      merge(a[am+1..-1], b[bm+1..-1], c[am+bm+2..c.size])
    end

    threads.each{|t| t.join}
  end


end
