gem 'test-unit'

require 'test/unit/assertions'
require './abstract_listener'

module ContractModelController
  include Test::Unit::Assertions

  def class_invariant
  end

  def pre_initialize(gid, type)
    assert !gid.nil?, "Game ID cannot be nil"
    assert type.is_a?(Fixnum), "Type must be fixnum"
    assert (type==1 or type==2), "Type must be 1 or 2"
  end

  def post_initialize
  end

  def pre_column_press(pid, column, value)
    assert pid.is_nil?, "Player ID cannot be nil"
    assert value.is_a?(Fixnum), "Column must be Fixnum"
    assert column.is_a?(Fixnum), "Column must be Fixnum"
    assert column >= 0, "Column cannot be negative"
  end

  def post_column_press
  end

  def pre_subscribe(game, observer)
    assert !game.nil?, "Model cannot be nil"
    assert observer.is_a?(AbstractListener), "Observer must implement AbstractListener"
  end

  def post_subscribe
  end

  def pre_add_player(player_name)
    assert player_name.is_a?(String), "Player name must be string"
  end

  def post_add_player(players)
    assert !players.empty?, "Players should not be empty"
  end

  def pre_setup(gid, type)
    assert !gid.nil?, "Game ID cannot be nil"
    assert type.is_a?(Fixnum), "Type must be fixnum"
    assert (type==1 or type==2), "Type must be 1 or 2"
  end

  def post_setup(game)
    assert !game.nil?, "Game cannot be nil"
  end

  def pre_get_state
  end

  def post_get_state(result)
    assert result.size == 4, "Result should be length 4"
    assert result[0].is_a?(Fixnum), "Width must be Fixnum"
    assert result[1].is_a?(Fixnum), "Height must be Fixnum"
    assert result[2].is_a?(Fixnum), "Turn must be Fixnum"
    assert result[3].is_a?(Array), "Board data must be array"
  end

end
