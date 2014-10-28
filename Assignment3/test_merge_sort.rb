

require 'test/unit'
require './merge_sort.rb'

class TestMergeSort < Test::Unit::TestCase

  def test_merge()
    a = [-2,5,6,9,20]
    b = [1,2,9,44,69]
    c = Array.new(a.size+b.size)

    m = MergeSort.new
    m.merge(a,b,c)

    tmp = "C: " 
    c.each{|v| tmp << " #{v},"}
    puts tmp
  end

end
