# encoding: utf-8
#
# = custom_commands.rb
#
# Contains custom shell commands not included in /bin/
#
# Authors: Evan Degraff, James Finlay
##

require './shell'

module CustomCommands

  #
  # Implementation of 'cd' command
  #
  def change_directory(dir)
    Dir.chdir(dir) if File.directory? dir
  end

  #
  # List available commands
  #
  def help(shell)
    result = "Available commands:\n"
    shell.valid_commands.each{
      |c| result << "#{c}\n"
    }
    shell.execute("echo #{result}")
  end

  #
  # Implementation of 'pwd' command
  #
  def present_working_directory(shell)
    shell.execute("echo #{Dir.pwd}")
  end

end
