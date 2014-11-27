# encoding: utf-8
#
# = abstract_listener.rb
#
# Abstract class for listening to View class
#
# Authors: Evan Degraff, James Finlay
##

class AbstractListener

  #
  # When model value is updated
  #
  def update_value(x,y,v,gid)
    raise NotImplementedError.new('Abstract Class')
  end

  #
  # Game Over
  #
  def game_over(message,gid)
    raise NotImplementedError.new('Abstract Class')
  end
  
end
