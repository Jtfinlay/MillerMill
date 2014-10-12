# encoding: utf-8
#
# = custom_commands.rb
#
# Contains custom shell commands not included in /bin/
#
# Authors: Evan Degraff, James Finlay
##

module CustomCommands

  #
  # Implementation of 'cd' command
  #
  def change_directory(dir)
    Dir.chdir(dir) if File.directory? dir
  end

  #
  # Implementation of 'pwd' command
  #
  def present_working_directory
    $stdout << Dir.pwd
  end

end
