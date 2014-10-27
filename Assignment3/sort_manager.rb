# encoding: utf-8
#
# = driver.rb
#
# Manages all the running sorts
#
# Authors: Evan Degraff, James Finlay
##

require './contract_sort_manager'
require 'java'

# JRuby code inspired from:
# http://www.restlessprogrammer.com/2013/02/multi-threading-in-jruby.html
java_import 'java.util.concurrent.FutureTask'
java_import 'java.util.concurrent.ThreadPoolExecutor'
java_import 'java.util.concurrent.LinkedBlockingQueue'

class SortManager
  include ContractSortManager

  @sorters

  def initialize()
    @sorters = []
  end

  def sort(max_time, file_names)
    executor = ThreadPoolExecutor.new(
      file_names.length,
      file_names.length,
      60,
      TimeUnit::SECONDS,
      LinkedBlockingQueue.new)

    file_names.each { |file_name|
      sorter << FutureTask.new(MergeSort.new(max_time, file_name))
      executor.execute(sorter)
      @sorters << sorter
    }

    # Wait for all tasks to complete
    @sorters.each{|s| s.get}

    executor.shutdown()
  end

end
