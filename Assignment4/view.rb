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

  def initialize(width, height)
    Gtk.init
    window = Gtk::Window.new
    window.signal_connect("destroy"){Gtk.main_quit}
    window.border_width = 10

    v = Gtk::VBox.new
    Array.new(height).each_with_index{|a,row|
      h = Gtk::HBox.new
      Array.new(width).each_with_index{|b,col|
        h.pack_start(Gtk::Image.new("X.png"))
      }
      v.pack_start(h)
    }
    window.add(v)

    window.show_all
    Gtk.main
  end


end
