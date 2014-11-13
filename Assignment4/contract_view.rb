

require 'test/unit/assertions'
require 'gtk2'

module ContractView
  include Test::Unit::Assertions

  def class_invariant
  end

  def pre_initialize(width, height)
    assert width.is_a?(Fixnum), "Width must be a Fixnum"
    assert height.is_a?(Fixnum), "Height must be a Fixnum"
    assert width >= 0, "Width cannot be negative"
    assert height >= 0, "Height cannot be negative"
  end

  def post_initialize(window)
    assert window.is_a?(Gtk::Window), "Window must be a Gtk Window"
    assert window.children.size > 0, "Window's children cannot be empty"
  end

  def pre_reset_grid(width, height)
    assert width.is_a?(Fixnum), "Width must be a Fixnum"
    assert height.is_a?(Fixnum), "Height must be a Fixnum"
    assert width >= 0, "Width cannot be negative"
    assert height >= 0, "Height cannot be negative"
  end

  def post_reset_grid(window)
    assert window.children.size > 0, "Window must have children"
  end

  def pre_reset_images
  end

  def post_reset_images(pics)
    assert pics.is_a?(Hash), "Pics must be Hash"
    assert ~pics.empty?, "Pics cannot be empty"
  end

  def pre_set_box(keys, x, y, v)
    assert x.is_a?(Fixnum), "X must be a Fixnum"
    assert y.is_a?(Fixnum), "Y must be a Fixnum"
    assert keys.has_key?(v), "V must exist in Keys"
  end

  def post_set_box
  end

  def pre_set_image(id, image_file)
    assert image_file.is_a?(String), "Image file must be a String"
    assert File.exists(image_file), "Image file must exist"
  end

  def post_set_image(keys, id, image_file)
    assert keys[id] == image_file, "Image file must be set to id"
  end

end
