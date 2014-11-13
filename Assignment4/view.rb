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
  @controller

  def initialize(controller)
    @controller = controller
    reset_images

    Gtk.init
    @window = Gtk::Window.new
    @window.signal_connect("destroy"){Gtk.main_quit}
    @window.title = "FourPlay"

    @controller.subscribe(self)

  end

  #
  # Repopulate board
  #
  def setup(width, height)

    v = Gtk::VBox.new
    v.add(create_toolbar)
    v.pack_start(create_buttons(width))

    Array.new(height).each{|a|
      v.pack_end(create_grid_row(width))
    }

    @window.add(v)
  end

  #
  # Show grid
  #
  def start_game
    @window.show_all
    Gtk.main
  end

  #
  # Create the toolbar
  #
  def create_toolbar
    toolbar = Gtk::Toolbar.new
    file_menu = Gtk::ToolButton.new(nil, "Restart")
    file_menu.signal_connect("clicked") {
      # TODO - Restart
    }
    toolbar.insert(0, file_menu)
    return toolbar
  end

  def create_buttons(width)
    btns = Gtk::HBox.new
    Array.new(width).each_with_index{|b,col|
      btn = Gtk::Button.new("Place")
      btn.signal_connect("clicked") {
        @controller.column_press(col)
      }
      btns.pack_start(btn)
    }
    return btns
  end

  def create_grid_row(width)
    h = Gtk::HBox.new
    Array.new(width).each{|b|
      h.pack_start(Gtk::Image.new(@pics[0]))
    }
    return h
  end

  #
  # Remove all set images and repopulate defaults
  #
  def reset_images()
    @pics = Hash.new
    set_image(0, "empty.png")
    set_image(1, "X.png")
    set_image(2, "O.png")
  end

  #
  # Set box value
  #
  def update_value(x, y, v)
    @window.children[0].children.reverse[y].children[x].set(@pics[v])
  end

  #
  # Add a possible box image, identified by given id
  #
  def set_image(id, image_file)
    @pics[id] = image_file
  end

end
