gem 'test-unit'

require 'test/unit/assertions'
require 'gtk2'

module ContractView
  include Test::Unit::Assertions

  def class_invariant
  end

  def pre_initialize(controller)
    assert ~controller.nil?, "Controller cannot be nil"
  end

  def post_initialize(window)
    assert window.is_a?(Gtk::Window), "Window must be a Gtk Window"
  end

  def pre_setup(width, height)
    assert width.is_a?(Fixnum), "Width must be a Fixnum"
    assert height.is_a?(Fixnum), "Height must be a Fixnum"
    assert width >= 0, "Width cannot be negative"
    assert height >= 0, "Height cannot be negative"
  end

  def post_setup(window)
    assert window.children.size > 0, "Window must have children"
  end

  def pre_kill
  end

  def post_kill
  end

  def pre_create_toolbar
  end

  def post_create_toolbar(result)
    assert result.is_a?(Gtk::Toolbar)
  end

  def pre_create_buttons(width)
    assert width.is_a?(Fixnum), "Width must be a Fixnum"
    assert width >= 0, "Width cannot be negative"
  end

  def post_create_buttons(result)
    assert result.is_a?(Gtk::HBox), "Result must be an HBox"
    assert ~result.children.empty?, "Result cannot be empty"
  end

  def pre_create_grid_row(width)
    assert width.is_a?(Fixnum), "Width must be a Fixnum"
    assert width >= 0, "Width cannot be negative"
  end

  def post_create_grid_row(result)
    assert result.is_a?(Gtk::HBox), "Result must be an HBox"
    assert ~result.children.empty?, "Result cannot be empty"
  end

  def pre_reset_images
  end

  def post_reset_images(pics)
    assert pics.is_a?(Hash), "Pics must be Hash"
    assert ~pics.empty?, "Pics cannot be empty"
  end

  def pre_update_value(keys, x, y, v)
    assert x.is_a?(Fixnum), "X must be a Fixnum"
    assert y.is_a?(Fixnum), "Y must be a Fixnum"
    assert keys.has_key?(v), "V must exist in Keys"
  end

  def post_update_value
  end

  def pre_set_image(id, image_file)
    assert image_file.is_a?(String), "Image file must be a String"
    assert File.exists(image_file), "Image file must exist"
  end

  def post_set_image(keys, id, image_file)
    assert keys[id] == image_file, "Image file must be set to id"
  end

end
