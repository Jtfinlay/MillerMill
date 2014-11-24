require 'xmlrpc/client'
require './view'

class GameClient

  @view
  @type

  def initialize
  end

  def start(host, port)
    server = XMLRPC::Client.new(host, "/", port)
    manager = server.proxy("manager")

    # TODO - If not connected, throws ERRNO::ECONNREFUSED

    puts manager.hello

    puts "Please enter an ID for the game you would like to start/join."
    gameID = gets

    [type, id] = manager.join(gameID)
    puts "T: #{type}, ID: #{id}"
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
    @view.setup(@@width, @@height)
    if @type == 1
      @view.setup_standard(@@width, @@height)
    else
      @view.setup_OTTO(@@width, @@height)
    end
  end

end

c = GameClient.new
c.start("localhost", 2014)
