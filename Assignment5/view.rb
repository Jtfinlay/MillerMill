# encoding: utf-8
#
# = view.rb
#
# Gtk GUI Manager
#
# Authors: Evan Degraff, James Finlay
##

require 'gtk2'
require './contract_view'

class View
  include ContractView

  @window
  @pics
  @controller

  def initialize(controller)
    @controller = controller
    reset_images
  end

  #
  # Populate board
  #
  def setup(width, height)
    Gtk.init
    @window = Gtk::Window.new
    @window.signal_connect("destroy"){Gtk.main_quit}
    @window.title = "FourPlay with Friends"
  end

  #
  # Standard X/O board
  #
  def setup_standard(width, height)
    v = Gtk::VBox.new
    v.add(create_toolbar)
    v.pack_start(create_buttons(width, 1, "X"))

    Array.new(height).each{|a|
      v.pack_end(create_grid_row(width))
    }

    @window.add(v)
  end

  #
  # OTTO/TOOT board
  #
  def setup_OTTO(width, height)
    v = Gtk::VBox.new
    v.add(create_toolbar)
    v.pack_start(create_buttons(width, 2, "O"))
    v.pack_start(create_buttons(width, 3, "T"))

    Array.new(height).each{|a|
      v.pack_end(create_grid_row(width))
    }

    @window.add(v)
  end

  #
  # Destroy GUI
  #
  def kill
    @window.destroy
  end

  #
  # Show grid & start
  #
  def start_game
    @window.show_all
    Gtk.main
  end

  #
  # Show game finish alert
  #
  def game_over(message)
    pre_game_over(message)

   dialog = Gtk::Dialog.new(
      "Game Over",
      @window,
      Gtk::Dialog::MODAL
    )

    btnRestart = Gtk::Button.new("New Game")
    btnRestart.signal_connect("clicked"){
      @controller.restart
      dialog.close
    }
    btnExit = Gtk::Button.new("Quit")
    btnExit.signal_connect("clicked"){
      @controller.quit
    }

    hbox = Gtk::HBox.new
  #  hbox.pack_start(btnRestart)
    hbox.pack_start(btnExit)

    dialog.vbox.add(Gtk::Label.new(message))
    dialog.vbox.add(hbox)

    dialog.show_all

  end

  #
  # Create the toolbar
  #
  def create_toolbar
    pre_create_toolbar

    toolbar = Gtk::Toolbar.new
    file_menu = Gtk::ToolButton.new(nil, "Restart")
    file_menu.signal_connect("clicked") {
      @controller.restart
    }
    toolbar.insert(0, file_menu)

    post_create_toolbar(toolbar)
    class_invariant
    return toolbar
  end

  #
  # Create row of action buttons
  #
  def create_buttons(width, value, label)
    pre_create_buttons(width, value, label)
    btns = Gtk::HBox.new
    Array.new(width).each_with_index{|b,col|
      btn = Gtk::Button.new("Place #{label}")
      btn.signal_connect("clicked") {
        @controller.column_press(col, value)
      }
      btns.pack_start(btn)
    }
    post_create_buttons(btns)
    class_invariant
    return btns
  end

  #
  # Creates a row in the image grid
  #
  def create_grid_row(width)
    pre_create_grid_row(width)
    h = Gtk::HBox.new
    Array.new(width).each{|b|
      h.pack_start(Gtk::Image.new(@pics[0]))
    }
    post_create_grid_row(h)
    class_invariant
    return h
  end

  #
  # Remove all set images and repopulate defaults
  #
  def reset_images()
    pre_reset_images
    @pics = Hash.new
    set_image(0, "empty.png")
    set_image(1, "X.png")
    set_image(2, "O.png")
    set_image(3, "T.png")
    post_reset_images(@pics)
    class_invariant
  end

  #
  # Set box value
  #
  def update_value(x, y, v)
    pre_update_value(@pics, x, y, v)

    @window.children[0].children.reverse[y].children[x].set(@pics[v])

    post_update_value
    class_invariant
  end

  #
  # Add a possible box image, identified by given id
  #
  def set_image(id, image_file)
    pre_set_image(id, image_file)

    @pics[id] = image_file

    post_set_image(@pics, id, image_file)
    class_invariant
  end

end
