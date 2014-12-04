gem 'test-unit'

require 'test/unit/assertions'
require './game_board'

module ContractGameSave
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

  def pre_save_game(id, board, turn)
    assert id.is_a?(String)
    assert board.is_a?(GameBoard)
    assert turn.is_a?(Fixnum)
  end

  def post_save_game(result)
    assert(result.is_a?(TrueClass) || result.is_a?(FalseClass))
  end

  def pre_load_game(id)
    assert id.is_a?(String)
  end

  def post_load_game(board, turn)
    assert board.is_a?(GameBoard)
    assert turn.is_a?(Fixnum)
  end

  def pre_serialize_board(board)
    assert board.is_a?(GameBoard)
  end

  def post_serialize_board(result)
    assert result.is_a?(String)
  end

  def pre_deserialize_board(s)
    assert s.is_a?(String)
  end

  def post_deserialize_board
    assert result.is_a?(GameBoard)
  end

end
