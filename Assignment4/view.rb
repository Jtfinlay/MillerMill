# encoding: utf-8
#
# = view.rb
#
# Manages Gtk GUI
#
# Authors: Evan Degraff, James Finlay
##

require 'gtk2'

class View

  @window
  @pics

  def initialize(width, height)
    reset_images

    Gtk.init
    @window = Gtk::Window.new
    @window.signal_connect("destroy"){Gtk.main_quit}
    @window.border_width = 5

    reset_grid(width,height)

    @window.show_all

    Gtk.main
  end

  #
  # Remove everything from grid and repopulate
  #
  # @param width: Width of grid in boxes
  # @param height: Height of grid in boxes
  def reset_grid(width, height)
#    @window.children = []

    v = Gtk::VBox.new

    # Toolbar
    toolbar = Gtk::Toolbar.new
    file_menu = Gtk::ToolButton.new(nil, "Restart")
    file_menu.signal_connect("clicked") {
      # TODO - Restart
    }
    toolbar.insert(0, file_menu)
    v.add(toolbar)

    # Add buttons
    btns = Gtk::HBox.new
    Array.new(width).each_with_index{|b,col|
      btn = Gtk::Button.new("Place")
      btn.signal_connect("clicked") {
        #TODO implement on-click
      }
      btns.pack_start(btn)
    }
    v.pack_start(btns)

    # Add grid
    Array.new(height).each{|a|
      h = Gtk::HBox.new
      Array.new(width).each{|b|
        h.pack_start(Gtk::Image.new(@pics[0]))
      }
      v.pack_start(h)
    }
    @window.add(v)
  end

  #
  # Remove all set images and repopulate defaults
  #
  def reset_images()
    @pics = Hash.new
    add_image(0, "empty.png")
    add_image(1, "X.png")
    add_image(2, "O.png")
  end

  #
  # Update box value
  #
  # @param x: column location
  # @param y: row location
  # @param v: value to set. Should match value in @pics
  def set_box(x, y, v)
    @window.children[0].children[y+2].children[x].set(@pics[v])
  end

  #
  # Add a possible box image, identified by given id
  # @param id: identification for image
  # @param image_file: image
  def set_image(id, image_file)
    @pics[id] = image_file
  end

end
