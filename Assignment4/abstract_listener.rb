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
  def update_value(x,y,v)
    raise NotImplementedError.new('Abstract Class')
  end

end
