require 'xmlrpc/client'
require './view'
require './game_board'

class GameClient

  @board       # Local copy of model
  @gameID      # Game ID
  @manager     # Access to server game manager
  @observers   # Model observers
  @pid         # Player's game ID
  @pname       # Player Name
  @prev_turn   # Current turn of match
  @view        # Access to View object


  def initialize
  end

  def start(host, port)
    server = XMLRPC::Client.new(host, "/", port)
    @manager = server.proxy("manager")

    # TODO - If not connected, throws ERRNO::ECONNREFUSED

    puts @manager.hello

    puts "Please enter a Player ID"
    @pname = gets

    # TODO - Game Menu
    # New AI Game
    # New Multiplayer Game
    # Load Existing Game

    # TODO - Following is for multiplayer game. Should refactor.

    puts "Please enter an ID for the game you would like to start/join."
    @gameID = gets

    @prev_turn = 0

    type, width, height, @pid = @manager.join(@gameID, @pname)
    puts "T: #{type}, width: #{width}, height: #{height}, ID: #{@pid}"

    if !type
      puts "What type of game would you like to play?"
      puts "Enter 1 for normal and 2 for OTTO/TOOT"

      # TODO - Validate inputs

      type = gets.to_i
      @manager.setup(@gameID, type)
    end

    setup(type, width, height)

    while @manager.players(@gameID).size < 2
      puts "Waiting for a friend to join.."
      sleep(3)
    end

    fork {start_poller}
    start_game
    
  end

  def start_game
    if @pid == 1
       puts "Your opponent is #{@manager.players(@gameID)[1]}"
       puts "You have the first turn."
    else
       puts "Your opponent is #{@manager.players(@gameID)[0]}"
       puts "They will play first."
    end
    @view.start_game
  end

  def quit
    @view.kill
  end

  def restart
    @view.kill
    setup
    start_game
  end

  def setup(game_type, width, height)
    @view = View.new(self)
    @view.setup(width, height)
    @board = GameBoard.new(width, height)
    if game_type == 1
      @view.setup_standard(width, height)
    else
      @view.setup_OTTO(width, height)
    end
    @board.subscribe(@view)
  end

  def restart
  end

  def quit
  end

  def column_press(col, value)
    puts "Column_press: #{@pid}, #{col}, #{value}"
    puts "Column_press: #{@manager.press_column(@gameID, @pid, col, value)}"
  end

  def start_poller
    while true
      puts "start: #{@manager.class}"
      puts "start: #{@manager.hello}"
      puts "Turns: -#{@manager.get_turns(@gameID)}-"
      puts "post puts."
      if @manager.get_turns(@gameID) != @prev_turn
        puts "#{turns} not equal"
        message, data, players, @prev_turn = @manager.get_game_state(@gameID)
        @board.update_all(data)
      end
      sleep(2)
    end
  end

end

c = GameClient.new
c.start("localhost", 2014)
