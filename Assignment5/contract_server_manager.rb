gem 'test-unit'

require 'test/unit/assertions'

module ContractServerManager
  include Test::Unit::Assertions

  def class_invariant(games, clients)
    assert games.is_a?(Hash), "Games must be a Hash"
    assert clients.is_a?(Hash), "Clients must be a Hash"
  end

  def pre_initialize(port)
    assert port.is_a?(Fixnum), "Port must be Fixnum"
    assert port > 0, "Port must be greater than 0"
  end

  def post_intialize
  end

  def pre_connect(player_name, ip_addr, port)
    assert player_name.is_a?(String), "Player name must be String"
    assert ip_addr.is_a?(String), "IP Address must be String"
    assert ip_addr.length>0, "IP Address cannot be empty"
    assert port.is_a?(Fixnum), "Port must be fixnum"
    assert port > 0, "Port must be > 0"
  end

  def post_connect
  end

  def pre_join(gid, pid)
    assert gid.is_a?(String), "GameID must be String"
    assert pid.is_a?(String), "PlayerID must be String"
  end

  def post_join
  end

  def pre_create(gid, pid, type)
    assert gid.is_a?(String), "GameID must be String"
    assert pid.is_a?(String), "PlayerID must be String"
    assert type.is_a?(Fixnum), "Type must be Fixnum"
    assert (type == 0 or type == 1), "Type must be 1 or 0"
  end

  def post_create(games, gid)
    assert games.has_key?(gid), "Games must have gid as key"
  end

  def pre_players(gid, games)
    assert gid.is_a?(String), "GameID must be String"
    assert games.has_key?(gid), "Games must have gid as key"
  end

  def post_players
  end

  def pre_whos_turn(gid, games)
    assert gid.is_a?(String), "GameID must be String"
    assert games.has_key?(gid), "Games must have gid as key"
  end

  def post_whos_turn
  end

  def pre_current_state(gid, games)
    assert gid.is_a?(String), "GameID must be String"
    assert games.has_key?(gid), "Games must have gid as key"
  end

  def post_current_state
  end

  def pre_update_value(x,y,v,gid, games)
    assert gid.is_a?(String), "GameID must be String"
    assert games.has_key?(gid), "Games must have gid as key"
    assert x.is_a?(Fixnum), "X must be Fixnum"
    assert y.is_a?(Fixnum), "Y must be Fixnum"
    assert v.is_a?(Fixnum), "V must be Fixnum"
    assert x >= 0, "X must be >= 0"
    assert y >= 0, "Y must be >= 0"
    assert v >= 0, "V must be >= 0"
  end

  def post_update_value
  end

  def pre_game_over(message, gid, games)
    assert gid.is_a?(String), "GameID must be String"
    assert games.has_key?(gid), "Games must have gid as key"
    assert message.is_a?(String), "Message must be String"
  end

  def post_game_over

  end

end
