# encoding: utf-8
#
# = merge_sort.rb
#
# Executes concurrent merge sort
#
# Authors: Evan Degraff, James Finlay
##

require 'java'

java_import 'java.util.concurrent.Callable'

class MergeSort
  include Callable

  def initialize(duration, file_name)
    # TODO create executor
  end

  def call
    # TODO implement concurrent merge sort`
  end

end
