gem 'test-unit'

require 'test/unit/assertions'

module ContractGameBoard
  include Test::Unit::Assertions

  def class_invariant
  end

  def pre_initialize(difficulty)
  end

  def post_initialize
  end

  def pre_make_move(game_board)
  end

  def post_make_move
  end

  def pre_easy_difficulty(game_board)
  end

  def post_easy_difficulty
  end

end
