# encoding: utf-8
#
# = shell.rb
#
# Shell class, which tries to run given commands.
#
# Authors: Evan Degraff, James Finlay
##

class Shell

  # TODO Create list of valid commands. A lot of existing commands exist in /bin/
  # cat
  # cp
  # echo
  # grep
  # ln
  # ls
  # mkdir
  # rm
  # rmdir

  #
  # Creates shell object.
  #
  def initialize()
    # TODO
  end

  #
  # Manage input and execute given commands
  #
  def execute(cmd)
    # TODO
    # TODO Input could be invalid
    # TODO Input could be multi-line (separated by '\')
    # TODO Input could be piped (separated by '|')
  end

  #
  # Execute single command
  #
  def execute_single_command(cmd)
    # TODO
  end

  #
  # Return whether given command is valid
  #
  def valid?(cmd)
    # TODO
  end

end
