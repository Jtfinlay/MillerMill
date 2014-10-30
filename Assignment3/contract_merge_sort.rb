# encoding: utf-8
#
# = contract_merge_sort.rb
#
# Contracts for merge_osrt.rb
#
# Authors: Evan Degraff, James Finlay
##

require 'test/unit/assertions'

module ContractMergeSort
  include Test::Unit::Assertions

  def class_invariant()
  end

  def pre_start(max_time, objects)
    assert (max_time.is_a?(Float) or max_time.is_a?(Fixnum)), \
      "Max time must be a Number"
    assert objects.is_a?(Array)
    objects.each_with_index{ |obj,i|
      assert !(obj <=> objects[i-1]).nil?, "All objects must be comparable"
    }
  end

  def post_start
  end

  def pre_merge_sort(a, l, r)
    assert a.is_a?(Array), "a must be an array"
    assert l.is_a?(Fixnum), "l must be an index"
    assert r.is_a?(Fixnum), "r must be an index"
    assert r.between(0, a.size), "r must be within array size"
    assert l.between(0, a.size), "l must be within array size"
  end

  def post_merge_sort(result)
    assert result == result.sort, "Result must be sorted"
  end

  def pre_merge(a, b, c, ci)
    assert a.is_a?(Array), "a must be an array"
    assert b.is_a?(Array), "b must be an array"
    assert c.is_a?(Array), "c must be an array"
    assert ci.is_a?(Fixnum), "ci must be a Fixnum array index"
    assert c.size == a.size+b.size, "c must be sum of a & b sizes"
  end

  def post_merge(c, ci, size)
    assert c[ci,size] = c[ci,size].sort, "Subarray must be sorted"
  end

end
