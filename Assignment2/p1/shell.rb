# encoding: utf-8
#
# = shell.rb
#
# Shell class, which tries to run given commands.
#
# Authors: Evan Degraff, James Finlay
##

class Shell
  #TODO Remove 'dir'
  @@default = ["dir", "cat", "cp", "echo", "grep", "ln", "ls", \
                "mkdir", "rm", "rmdir"]
  attr_accessor :whitelist

  # Store all commands in Hash as {"name",&method}
  def initialize()
    @whitelist = {}
    @@default.each{
      |c| @whitelist[c] = Proc.new {
        |args| exec(c, *args)
      }
    }
  end

  #
  # Add a custom command to the shell commands
  #
  def register(name, &method)
    @whitelist[name] = method
  end

  #
  # Manage input and execute given commands
  #
  def execute(cmd)
    cmd = cmd.split('|').map{|v| v.split}

    cmd.reverse.each{
      |c| execute_single_command(c)
    }
  end

  #
  # Execute single command
  #
  def execute_single_command(cmd)
    raise NotImplementedError, cmd[0] if !valid? cmd

    # TODO Threading shit.
    @whitelist[cmd[0]].call(cmd[1..-1])
  end

  #
  # Prompt to display
  #
  def prompt
    return "8==>"
  end

  #
  # Return whether given command is valid
  #
  def valid?(cmd)
    return @whitelist.include? cmd[0]
  end

end
