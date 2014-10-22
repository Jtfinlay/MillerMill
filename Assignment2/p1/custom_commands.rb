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
    pre_change_directory(dir)

    Dir.chdir(dir) if File.directory? dir

    post_change_directory
    class_invariant
  end

  #
  # Implementation of 'pwd' command
  #
  def present_working_directory
    pre_present_working_directory

    $stdout << Dir.pwd

    post_present_working_directory
    class_invariant
  end

end
