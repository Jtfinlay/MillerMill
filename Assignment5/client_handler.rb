require './game_controller'

class ClientHandler

  @server

  def initialize(server)
    @server = server
  end

  def hello
    return "ACK"
  end

  def join(gid)
    if @server.games.has_key?(gid)
      @server.games[gid] = GameController.new
    end
    return [@server.games[gid].type, @server.games[gid].players]
  end

  def setup(gid, type)
    @server.games[gid].setup(type)
  end

  def await_player(gid)

  end
end
