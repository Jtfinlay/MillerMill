require 'xmlrpc/client'
require './view'

class GameClient

  @view
  @type
  @gameID

  def initialize
  end

  def start(host, port)
    server = XMLRPC::Client.new(host, "/", port)
    manager = server.proxy("manager")

    # TODO - If not connected, throws ERRNO::ECONNREFUSED

    puts manager.hello

    puts "Please enter an ID for the game you would like to start/join."
    @gameID = gets

    @type, id = manager.join(@gameID)
    puts "T: #{@type}, ID: #{id}"

    if !@type
      puts "What type of game would you like to play?"
      puts "Enter 1 for normal and 2 for OTTO/TOOT"

      # TODO - Validate inputs

      @type = gets
      manager.setup(@gameID, @type)
    end

    setup

    while manager.player_count(@gameID) < 2
      puts "Waiting for a friend to join.."
      sleep(3)
    end

    start_game
  end

  def start_game
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

  def setup
    @view = View.new(self)
    @view.setup(7, 6)
    if @type == 1
      @view.setup_standard(7, 6)
    else
      @view.setup_OTTO(7, 6)
    end
  end

  def restart
  end

  def quit
  end

  def column_press(col, value)
    # TODO
  end

end

c = GameClient.new
c.start("localhost", 2014)
