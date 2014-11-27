require 'xmlrpc/server'
require 'xmlrpc/client'

class ClientDriver

  attr_accessor :pname, :gameID, :server

  def initialize
  end

  def start(host, port)

    s = XMLRPC::Client.new(host, "/", port)
    @server = s.proxy("manager")

    # TODO - If not connected, throws ERRNO:ECONNREFUSED

    # Get user name
    @pname = ask_player_name

    # Launch client server
    launch_listener(2020)

    @server.connect(@pname, "localhost", 2020)
    #TODO - 'connect' may fail and return false

    main_menu
  end

  def ask_player_name
    puts "Please enter your username,"
    return gets
  end

  def main_menu
    puts "What would you like to do?"
    puts "1. Match against AI"
    puts "2. Match against player"
    puts "3. Leaderboards"

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

    start_match
  end
  
  def start_match
    players = @server.players(@gameID)
    puts "Match begins: #{players[0]} vs #{players[1]}!"
    @view.start_game
  end

  def launch_listener(port)
    Thread.new {
      # TODO Need dynamic port. It works if 'port' is 0, but need 
      # way to then extract generated port.

      s = XMLRPC::Server.new(port)
      s.add_handler("client", self)
      s.serve
    }
  end

  #
  # From Server
  #
  def update_value(x,y,v)
    @view.update_value(x,y,v)
    return true
  end

  # 
  # From Server
  #
  def game_over(message)
    @view.game_over(message)
    return true
  end

  

end

