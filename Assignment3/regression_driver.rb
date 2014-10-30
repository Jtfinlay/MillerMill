# encoding: utf-8
#
# = regression_driver.rb
#
# Driver that gathers thread data for regression model
#
# Authors: Evan Degraff, James Finlay
##

require './regression.rb'

include Regression

if ARGV.length < 2
  puts "Two arguments required: output file and series of threads"
else
  File.open(ARGV[0], 'w'){ |file|
    ARGV[1..-1].each{|thread_count|
      file.puts("#{thread_count},#{thread_task(thread_count)}")
    }
  }
end
