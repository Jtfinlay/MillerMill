# encoding: utf-8
#
# = file_watcher.rb
#
# Watches given files for the provided alterations
#
# Authors: Evan Degraff, James Finlay
##

require './contract_file_watcher'

class FileWatcher
  include ContractFileWatcher

  @children

  def initialize()
    @children = []
  end

  def watch(duration, file_names, alteration, action)
    file_names.each{|file_name|
      @children << fork {

        begin
          alteration.call(file_name)
        rescue SystemCallError => e
          $stdout << e.message
          $stdout << e.backtrace.inspect
          return
        end

        sleep(duration)
        action.call()
      }
    }
  end

end
