# encoding: utf-8
#
# = contract_custom_commands.rb
#
# Contracts for custom_commands.rb
#
# Authors: Evan Degraff, James Finlay
##

require 'test/unit'

module ContractCustomCommands
  include Test::Unit::Assertions

  def class_invariant
    # No invariants
  end

  def pre_change_directory(dir)
    assert dir.is_a? String, "Target must be a string"
  end

  def post_change_directory(dir)
    # No post conditions
  end

  def pre_present_working_directory(shell)
    assert shell.is_a? Shell, "Must be a Shell"
  end

  def post_present_working_directory
    # No post conditions
  end

end
