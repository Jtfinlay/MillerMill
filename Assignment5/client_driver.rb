require 'xmlrpc/server'
require 'xmlrpc/client'
require 'socket'
require './view'
require './stats'
require './game_save'

class ClientDriver

  attr_accessor :pname, :gameID, :server

  @view
  @stats
  @save

  def initialize
    @stats = Stats.new("mysqlsrv.ece.ualberta.ca", "ece421grp7", "Afbgt7oE", "ece421grp7", 13010)
    @save = GameSave.new("mysqlsrv.ece.ualberta.ca", "ece421grp7", "Afbgt7oE", "ece421grp7", 13010)
  end

  def start(host, port, client_port)

    s = XMLRPC::Client.new(host, "/", port)
    @server = s.proxy("manager")

    # Get user name
    @pname = ask_player_name.chomp

    # Launch client server
    launch_listener(client_port)
    while (!@server.connect(@pname, Socket.ip_address_list[1].ip_address, client_port))
      print "Username is currently in use.\n"
      @pname = ask_player_name.chomp
    end

    main_menu
  end

  def ask_player_name
    puts "Please enter your username:"
    return $stdin.gets.chomp
  end

  def main_menu
    puts "What would you like to do?"
    puts "1. Match against player"
    puts "2. Match against Bot"
    puts "3. Load saved multiplayer game"
    puts "4. Leaderboards"
    puts "5. Exit"

    choice = $stdin.gets.to_i
    while choice <= 0 || choice > 5
      puts "Please enter a valid number between 1 and 4"
      choice = $stdin.gets.to_i
    end

    functions = [method(:new_multiplayer), \
                 method(:new_bot), \
                 method(:new_saved_multiplayer), \
                 method(:load_leaderboards), \
                 method(:quit)]
    functions[choice-1].call
  end

  def new_multiplayer
    puts "Enter game identifier:"
    @gameID = $stdin.gets.chomp

    if @server.num_players(@gameID) > 1
      puts "Game already has 2 players"
      @gameID = nil
      main_menu
      return
    end
    
    # Create game if DNE
    if !@server.join(@gameID, @pname)
      type = ask_game_type
      @server.create(@gameID, @pname, type)
    end

    # Wait for opponent
    while @server.players(@gameID).size < 2
      puts "Waiting for a friend to join..."
      sleep(3)
    end

    start_match
  end

  def turn_change
    # really just needed for bot
    return 0
  end

  def new_bot
    type = ask_game_type
    @gameID = @server.create_bot(@pname, type)
    start_match
  end

  def new_saved_multiplayer
    puts "Enter game identifier:"
    @gameID = $stdin.gets.chomp

    # Create game if DNE
    if !@server.join(@gameID, @pname)
      board, turn, type = @save.load_game(@gameID)
      if board.is_a? String
        puts board
        return
      end
      board = @save.serialize_board(board)
      @server.load(@gameID, @pname, board, turn, type)
    end

    # Wait for opponent
    while @server.players(@gameID).size < 2
      puts "Waiting for a friend to join..."
      sleep(3)
    end

    start_match

  end

  def load_leaderboards
    @stats.menu
    main_menu
  end

  def start_match

    # Get current game state
    w, h, turn, data = @server.current_state(@gameID)
    inputs, cond = @server.player_info(@gameID, @pname)
    players = @server.players(@gameID)

    setup_view(w, h, inputs)
    reset_model(data)

    puts "Match begins: #{players[0]} vs #{players[1]}!"
    goal = []
    cond.each{|v| goal << inputs.flatten[inputs.flatten.find_index(v)+1]}
    puts "Your goal is: " + goal.to_s
    @view.start_game
  end

  def reset_model(data)
    data.each_with_index{
      |row,y| row.each_with_index{
        |v,x| update_value(x,y,v)
      }
    }
  end

  def setup_view(width, height, inputs)
    @view = View.new(self)
    @view.setup(width, height, inputs, @pname)
  end

  def launch_listener(port)
    Thread.new {
      s = XMLRPC::Server.new(port, Socket.ip_address_list[1].ip_address)
      s.add_handler("client", self)
      s.serve
      exit
    }
    return port
  end

  def ask_game_type
    puts "What type of game would you like to play?"
    puts "Enter 1 for normal and 2 for OTTO/TOOT"

    type = $stdin.gets.to_i
    while type < 1 || type > 2
      puts "Please enter 1 or 2"
      type = $stdin.gets.to_i
    end

    return type
  end


  ### from View ###

  def column_press(col, value)
    @server.column_press(@gameID, @pname, col, value)
  end

  def save
    @server.save(@gameID, @pname)
  end

  def quit
    @view.kill if !@view.nil?
    if @gameID.nil?
      @server.disconnect(@pname)
    else  
      @server.disconnect(@pname, @gameID)
    end
    exit
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
