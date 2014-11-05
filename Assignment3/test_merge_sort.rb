

require 'test/unit'
require './merge_sort.rb'

class TestMergeSort < Test::Unit::TestCase

  def test_merge()
    a = [-2,5,6,9,20]
    b = [1,2,9,44,69]
    c = Array.new(a.size+b.size)

    m = MergeSort.new
    m.merge(a,b,c,0)

    assert [-2,1,2,5,6,9,9,20,44,69], c.to_s
  end

  def test_merge_sort()
    a = [-4,3,5,7,43,2,67,4,4,56,6,7,8,53,43,34,54,56]

    m = MergeSort.new

    assert a.sort, m.start(100,a).to_s
  end

  def test_merge_sort_large()
    a = Array.new(100){500-rand(1000)}

    m = MergeSort.new

    assert a.sort, m.start(100, a).to_s
  end

end
