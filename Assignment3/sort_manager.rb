# encoding: utf-8
#
# = driver.rb
#
# Manages all the running sorts
#
# Authors: Evan Degraff, James Finlay
##

require './contract_sort_manager'

class SortManager
  include ContractSortManager

  @sorters

  def initialize()
    @sorters = []
  end

  def sort(max_time, file_names)
    # TODO make each sort concurrent
    file_names.each { |file_name|
      @sorters << MergeSort.new(max_time, file_name)
    }
  end

end
