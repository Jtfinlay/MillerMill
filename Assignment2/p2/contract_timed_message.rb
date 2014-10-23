# encoding: utf-8
#
# = contract_timed_message.rb
#
# Contracts for timed_message.rb
#
# Authors: Evan Degraff, James Finlay
##

require 'test/unit'

module ContractTimedMessage
  include Test::Unit::Assertions
  # Module, so no class invariant

  def pre_schedule_message(time, message)
    assert time.is_a? Fixnum
    assert time >= 0
    assert message.is_a? String
  end

  def post_schedule_message(time, message)
    # Message appears after specified time
  end

end
