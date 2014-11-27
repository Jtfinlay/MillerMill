gem 'test-unit'

require 'test/unit/assertions'

module ContractClientDriver
  include Test::Unit::Assertions

  def class_invariant
  end

  def pre_initialize
  end

  def post_initialize
  end

  def pre_start(host,port)
    assert host.is_a?(String)
    assert port.is_a?(Fixnum)
  end

  def post_start
    # Start client
  end

  def pre_ask_player_name
  end

  def post_ask_player_name(result)
    assert result.is_a?(String)
  end

  def pre_main_menu
  end

  def post_main_menu
    # Process choice
  end

  def pre_new_multiplayer
  end

  def post_new_multiplayer
    # Starts specified game
  end

  def pre_start_game
  end

  def post_start_game
    # Start new game
  end

  def pre_reset_model(data)
    assert(data.is_a?(Array))
  end

  def post_reset_model
    # Synchronizes model with data from server
  end

  def pre_setup_view(width, height, inputs)
    assert width.is_a?(Fixnum)
    assert height.is_a?(Fixnum)
    assert inputs.is_a?(Array)
  end

  def post_setup_view
    # View is setup
  end

  def pre_launch_listener
  end

  def post_launch_listener(result)
    assert result.is_a?(Fixnum)
    # Listener is launched
  end

  def pre_column_press(column,value)
    assert column.is_a(Fixnum)
    assert value.is_a(Fixnum)
  end

  def post_column_press
    # Player input is sent to server
  end

  def pre_update_value(x,y,v)
    assert x.is_a(Fixnum)
    assert y.is_a(Fixnum)
    assert v.is_a(Fixnum)
  end

  def post_update_value
    # Value is updated in view on client
  end

  def pre_game_over(message)
    assert message.is_a?(String)
  end

  def post_game_over(result)
    # Game ends on client]
    assert result.is_a(TrueClass)
  end

  def pre_message(message)
    assert message.is_a?(String)
  end

  def post_message(result)
    # Message is outputted on client terminal
    assert result.is_a(TrueClass)
  end

end
