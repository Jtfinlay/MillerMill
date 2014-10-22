# encoding: utf-8
#
# = contract_file_watcher.rb
#
# Contracts for file_watcher.rb
#
# Authors: Evan Degraff, James Finlay
##

require 'test/unit/assertions'

module ContractFileWatcher
  include Test::Unit::Assertions

  def class_invariant(children)
    assert children.is_a? Array
  end

  def pre_watch(duration, file_names, alteration, action)
    assert (duration.is_a?(Float) or duration.is_a?(Fixnum)), \
      "Duration must be a number."
    assert duration >= 0, "Duration must be positive"
    assert file_names.is_a?(Array), "File_names must be an Array"
    assert !file_names.empty?, "File_names cannot be empty"
    assert file_names.select{|v| !v.is_a? String}.empty?, \
      "File names must all be Strings"
    assert alteration.is_a?(Method), "Alteration must be a Proc"
    assert action.is_a?(Proc), "Action must be a Proc"
  end

  def post_watch(children)
    assert !children.empty?
  end


end
