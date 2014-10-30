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

if ARGV.length < 1
  puts "Argument required: output file"
elsif ARGV.length == 1
  File.open(ARGV[0], 'w'){|file|
    (1..200).each{|thread_count|
       file.puts("#{thread_count},#{thread_task(thread_count)}")
    }
  }
else
  File.open(ARGV[0], 'w'){ |file|
    ARGV[1..-1].each{|thread_count|
      file.puts("#{thread_count},#{thread_task(thread_count.to_i)}")
    }
  }
end
