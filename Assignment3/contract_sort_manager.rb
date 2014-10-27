# encoding: utf-8
#
# = driver.rb
#
# Contracts for the managing sorts
#
# Authors: Evan Degraff, James Finlay
##

require 'test/unit/assertions'

module ContractSortManager
  include Test::Unit::Assertions

  def class_invariant()

  end

  def pre_sort(max_time, file_names)
    assert (max_time.is_a?(Float) or max_time.is_a?(Fixnum)), \
      "Max_time must be a number"
    assert file_names.is_a?(Array)
    file_names.each{ |file_name|
      assert file_name.is_a?(String), "File names must be strings"
      assert File.exists?(file_name), "File must exist"
    }
  end

  def post_sort()

  end

end
