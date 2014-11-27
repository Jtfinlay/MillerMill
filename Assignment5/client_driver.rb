require 'xmlrpc/server'
require 'xmlrpc/client'
require 'socket'
require './view'

class ClientDriver

  attr_accessor :pname, :gameID, :server

  @view

  def initialize
  end

  def start(host, port)

    s = XMLRPC::Client.new(host, "/", port)
    @server = s.proxy("manager")

    # TODO - If not connected, throws ERRNO:ECONNREFUSED

    # Get user name
    # TODO - Strip newline from player name
    @pname = ask_player_name

    # Launch client server
    port = launch_listener
    # TODO - Return ip address, isn't always 'localhost'
    @server.connect(@pname, "localhost", port)
    # TODO - 'connect' may fail and return false

    main_menu
  end

  def ask_player_name
    puts "Please enter your username:"
    return gets
  end

  def main_menu
    puts "What would you like to do?"
    puts "1. Match against player"
    puts "2. Match against Bot"
    puts "3. Load saved multiplayer game"
    puts "4. Leaderboards"

    # TODO Do something with choice. For now, just doing multiplayer
    gets

    new_multiplayer
  end

  def new_multiplayer
    puts "Enter game identifier:"
    @gameID = gets

    # Create game if DNE
    if !@server.join(@gameID, @pname)
      puts "What type of game would you like to play?"
      puts "Enter 1 for normal and 2 for OTTO/TOOT"

      # TODO Validate input

      type = gets.to_i
      @server.create(@gameID, @pname, type)
    end

    # Wait for opponent
    while @server.players(@gameID).size < 2
      puts "Waiting for a friend to join..."
      sleep(3)
    end

    # Get current game state
    w, h, turn, data = @server.current_state(@gameID)
    inputs, win_condition = @server.player_info(@gameID, @pname)

    setup_view(w, h, inputs)
    reset_model(data)

    start_match
  end


  def new_bot

  end

  def new_saved_multiplayer

  end

  def load_leaderboards

  end

  def start_match
    players = @server.players(@gameID)
    puts "Match begins: #{players[0]} vs #{players[1]}!"
    @view.start_game
  end

  def reset_model(data)
    data.each_with_index{
      |row,y| row.each_with_index{
#        |v,x| update_value(x,y,v)
      }
    }
  end

  def setup_view(width, height, inputs)
    @view = View.new(self)
    @view.setup(width, height, inputs)
  end

  def launch_listener
    # Get open port. This code is bad, can't find better way
    sock = Socket.new(:INET, :STREAM, 0)
    sock.bind(Addrinfo.tcp("localhost", 0))
    port = sock.local_address.ip_port
    sock.close

    Thread.new {
      s = XMLRPC::Server.new(port)
      s.add_handler("client", self)
      s.serve
    }
    return port
  end


  ### from View ###

  def column_press(col, value)
    @server.column_press(@gameID, @pname, col, value)
  end

  def save
  end

  def quit
  end

  ### from Server ###

  def update_value(x,y,v)
    @view.update_value(x,y,v)
    return true
  end

  def game_over(message)
    @view.game_over(message)
    return true
  end

  def message(message)
    puts message
    return true
  end

  def client_disconnect(message)
  end

end
