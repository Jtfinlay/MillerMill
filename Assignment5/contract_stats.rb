gem 'test-unit'

require 'test/unit/assertions'

module ContractStats
  include Test::Unit::Assertions

  def class_invariant
  end

  def pre_initialize(host, user, pwd, db, port)
    assert host.is_a?(String)
    assert user.is_a?(String)
    assert pwd.is_a?(String)
    assert db.is_a?(String)
    assert port.is_a?(Fixnum)
  end

  def post_initialize(connection)
    assert !connection.nil?
  end

  def pre_add_stat(game_id, p1, p2, winner)
    assert game_id.is_a?(String)
    assert p1.is_a?(String)
    assert p2.is_a?(String)
    assert winner.is_a?(String)
  end

  def post_add_stat
    # Stat is added to database
  end

  def pre_get_game(game_id)
    assert game_id.is_a?(String)
  end

  def post_get_game(result)
    assert result.is_a(String)
  end

  def pre_get_player(id)
    assert game_id.is_a?(String)
  end

  def post_get_player(result)
    assert result.is_a(String)
  end

  def pre_league_stats
  end

  def post_league_stats(result)
    assert result.is_a(String)
  end

end
