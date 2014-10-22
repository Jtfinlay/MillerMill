# encoding: utf-8
#
# = alterations.rb
#
# Contains alteration methods for the FileWatcher
#
# Authors: Evan Degraff, James Finlay
##

require './contract_alterations'

module Alterations
  include ContractAlterations

  def file_creation(file_name)
    pre_file_creation(file_name)

    sleep(0) while !File.exists?(file_name)

    post_file_creation(file_name)
    class_invariant
  end

  def file_modified(file_name)
    pre_file_modified(file_name)

    time_init = File.stat(file_name).mtime
    sleep(0) while File.exists?(file_name) && \
              time_init == File.stat(file_name).mtime

    post_file_modified
    class_invariant
  end

  def file_destroyed(file_name)
    pre_file_destroyed(file_name)

    sleep(0) while File.exists?(file_name)

    post_file_destroyed(file_name)
    class_invariant
  end

end
