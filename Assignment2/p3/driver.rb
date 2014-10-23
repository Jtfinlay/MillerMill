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

fw.watch(5, ["/cshome/jtfinlay/test1.txt", "/cshome/jtfinlay/test2.txt"], \
  method(:file_modified), Proc.new{$stdout << "Done!"})
