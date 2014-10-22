# encoding: utf-8
#
# = driver.rb
#
# Driver that takes inputs and passes it through to the FileWatcher.
#
# Authors: Evan Degraff, James Finlay
##

require './alterations'
require './file_watcher'

include Alterations

fw = FileWatcher.new

fw.watch(100, ["C:/Users/James/Documents/test.txt1", "C:/Users/James/Documents/test2.txt"], \
  method(:file_modified), Proc.new{puts "Done!"})
