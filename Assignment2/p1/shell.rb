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
  @whitelist

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
  # Pipe code inspired from following. We made it prettier.
  # http://www.jstorimer.com/blogs/workingwithcode/7766099-a-unix-shell-in-ruby
  # -part-4-pipes
  #
  def execute(cmd)
    cmd = split_on_pipes(cmd).map{|v| v.split}

    pipe_in = $stdin
    pipe_out = $stdout
    pipe = []

    cmd.each_with_index { |c,i|

      pipe = IO.pipe if (i+1 < cmd.size)
      pipe_out = (i+1 < cmd.size) ? pipe.last : $stdout

      execute_single_command(c[0], c[1..-1], pipe_in, pipe_out)

      pipe_out.close unless pipe_out == $stdout
      pipe_in.close unless pipe_in == $stdin
      pipe_in = pipe.first
    }

    Process.waitall
  end

  #
  # Execute single command
  #
  def execute_single_command(cmd, args, pipe_in, pipe_out)
    raise NotImplementedError, cmd if !valid? cmd

    fork {
        $stdout.reopen(pipe_out)
        $stdin.reopen(pipe_in)
        pipe_out.close unless pipe_out == $stdout
        pipe_in.close unless pipe_in == $stdin


        @whitelist[cmd].call args
    }
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
    return @whitelist.include? cmd
  end

  #
  # Takes line of inputs and splits it using '|' as a delimeter. This prevents
  # splitting lines that have a pipe character within a quoted string.
  #
  # http://stackoverflow.com/questions/4970064/how-to-split-a-string-by-colons-
  # not-in-quotes/4970136#4970136
  #
  # We apologize to Prof Miller for using StackOverflow, but we're bad at regex.
  #
  def split_on_pipes(line)
    line.scan( /([^"'|]+)|["']([^"']+)["']/ ).flatten.compact
  end



end
