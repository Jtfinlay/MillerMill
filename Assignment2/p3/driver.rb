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

fw.watch(3, ["/cshome/jtfinlay/test1.txt", "/cshome/jtfinlay/test2.txt"], \
  method(:file_modified), Proc.new{$stdout << "Modified!"})

fw.watch(3, ["/cshome/jtfinlay/create.txt"], method(:file_creation), \
  Proc.new{$stdout << "Created!"})

fw.watch(3, ["/cshome/jtfinlay/destroy.txt"], method(:file_destroyed), \
  Proc.new{$stdout << "Destroyed!"})
