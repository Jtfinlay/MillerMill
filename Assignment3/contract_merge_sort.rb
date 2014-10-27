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

  def pre_sort(max_time, objects)
    assert (max_time.is_a?(Float) or max_time.is_a?(Fixnum)), \
      "Max time must be a Number"
    assert objects.is_a?(Array)
    objects.each_with_index{ |obj,i|
      assert !(obj <=> objects[i-1]).nil?, "All objects must be comparable"
    }
  end

  def post_sort

  end

end
