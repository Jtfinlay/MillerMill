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

  max_time
  file_name

  def initialize(duration, file_name)
    self.max_time = duration
    self.file_name = file_name

    # TODO create executor
  end

  def call
    # TODO implement concurrent merge sort`
  end

end
