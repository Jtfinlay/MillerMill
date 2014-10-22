# encoding: utf-8
#
# = shell.rb
#
# Shell class, which tries to run given commands.
#
# Authors: Evan Degraff, James Finlay
##

require './contract_shell'

class Shell
  include ContractShell
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

    post_initialize(@@default)
    class_invariant
  end

  #
  # Add a custom command to the shell commands
  #
  def register(name, &method)
    pre_register(name, &method)

    @whitelist[name] = method

    post_register
    class_invariant
  end

  #
  # Manage input and execute given commands
  #
  # Pipe code inspired from following. We made it prettier.
  # http://www.jstorimer.com/blogs/workingwithcode/7766099-a-unix-shell-in-ruby
  # -part-4-pipes
  #
  def execute(cmd)
    pre_execute(cmd)

    cmd = split_on_pipes(cmd).map{|v| v.split}

    pipe_in = $stdin
    pipe_out = $stdout
    pipe = []

    cmd.each_with_index { |c,i|

      pipe = IO.pipe if (i+1 < cmd.size)
      pipe_out = (i+1 < cmd.size) ? pipe.last : $stdout

      begin
        execute_single_command(c[0], c[1..-1], pipe_in, pipe_out)
      rescue SystemCallError => e
        pipe_out.close unless pipe_out == $stdout
        pipe_in.close unless pipe_in == $stdin
        $stdout << e.message
        $stdout << e.backtrace.inspect
        return
      end

      pipe_out.close unless pipe_out == $stdout
      pipe_in.close unless pipe_in == $stdin
      pipe_in = pipe.first
    }

    Process.waitall

    post_execute
    class_invariant
  end

  #
  # Execute single command
  #
  def execute_single_command(cmd, args, pipe_in, pipe_out)
    pre_execute_single_command(cmd, args, pipe_in, pipe_out)

    raise NotImplementedError, cmd if !valid? cmd

    fork {
        unless pipe_out == $stdout
          $stdout.reopen(pipe_out)
          pipe_out.close
        end

        unless pipe_in == $stdin
          $stdin.reopen(pipe_in)
          pipe_in.close
        end

        @whitelist[cmd].call args
    }

    post_execute_single_command
    class_invariant
  end

  #
  # Prompt to display
  #
  def prompt
    return "=>"
  end

  #
  # Return whether given command is valid
  #
  def valid?(cmd)
    pre_valid(cmd)

    result = @whitelist.has_key? cmd

    post_valid
    class_invariant
    return result
  end

  #
  # Return array of known commands
  #
  def valid_commands
    return @whitelist.keys
  end

  #
  # Takes line of inputs and splits it using '|' as a delimeter. This prevents
  # splitting lines that have a pipe character within a quoted string.
  #
  def split_on_pipes(line)
    # TODO - Make this suck less. It tends to separate arguments as well :(
    # TODO - Remove quotes around parameters
    line.scan( /([^"'|]+)|["']([^"']+)["']/ ).flatten.compact
  end



end
