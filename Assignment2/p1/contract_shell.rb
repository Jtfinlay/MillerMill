# encoding: utf-8
#
# = contract_shell.rb
#
# Contracts for shell.rb
#
# Authors: Evan Degraff, James Finlay
##

require 'test/unit/assertions'

module ContractShell
  include Test::Unit::Assertions

  def class_invariant
    assert @whitelist.is_a?(Hash), "Whitelist must be a Hash"
    assert !@whitelist.empty?, "Whitelist cannot be empty"
  end

  def post_initialize(default)
    default.each{
      |c| assert valid?(c), "All defaults must be in whitelist."
    }
  end

  def pre_register(name, &method)
    assert name.is_a?(String), "Method name must be String"
    assert method.is_a?(Proc), "Method must be a Proc"
  end

  def post_register()
    assert !@whitelist.empty?, "Whitelist should not be empty"
  end

  def pre_execute(cmd)
    assert cmd.is_a?(String), "Command must be String"
  end

  def post_execute()
    # No post conditions
  end

  def pre_execute_single_command(cmd, args, pipe_in, pipe_out)
    assert valid?(cmd), "Must be a registered command"
    assert pipe_in.is_a?(IO), "Pipe_in must be an IO pipe"
    assert pipe_out.is_a?(IO), "Pipe_out must be an IO pipe"
    assert !pipe_in.closed?, "Pipe_in must be open"
    assert !pipe_out.closed?, "Pipe_out must be open"
    args.each{|arg| assert (arg.is_a?(Float) or arg.is_a?(Fixnum) \
      or arg.is_a?(String))}
  end

  def post_execute_single_command()
    # No post conditions
  end

  def pre_valid(cmd)
    assert cmd.is_a?(String), "Command must be a String."
  end

  def post_valid()
    # No post conditions
  end

end
