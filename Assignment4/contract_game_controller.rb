gem 'test-unit'

require 'test/unit/assertions'
require './abstract_listener'

module ContractGameController
  include Test::Unit::Assertions

  def class_invariant
  end

  def pre_initialize
  end

  def post_initialize(game, view)
    assert !game.nil?, "Model cannot be nil"
    assert !view.nil?, "View cannot be nil"
  end

  def pre_start_game(view)
    assert !view.nil?, "View cannot be nil"
  end

  def post_start_game
  end

  def pre_quit(view)
    assert !view.nil?, "View cannot be nil"
  end

  def post_quit
  end

  def pre_restart(view, game)
    assert !view.nil?, "View cannot be nil"
    assert !game.nil?, "Model cannot be nil"
  end

  def post_restart
  end

  def pre_column_press(column, value)
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

end
