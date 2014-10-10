# encoding: utf-8
#
# = contract_shell.rb
#
# Contracts for shell.rb
#
# Authors: Evan Degraff, James Finlay
##

require 'test/unit'
require './shell.rb'

class ContractShell < Test::Unit::TestCase

  def class_invariant
  end

  def pre_execute(cmd)
  end

  def post_execute(cmd)
  end

  def pre_execute_single_command(cmd)
  end

  def post_execute_single_command(cmd)
  end

  def pre_valid(cmd)
  end

  def post_valid(cmd)
  end

end
