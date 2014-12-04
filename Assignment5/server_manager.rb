require 'xmlrpc/server'
require 'xmlrpc/client'
require './model_controller'
require './abstract_listener'
require './game_save'

class ServerManager < AbstractListener

  attr_accessor :games, :clients

  def initialize(port)
    @games = Hash.new
    @clients = Hash.new
    @save = GameSave.new("mysqlsrv.ece.ualberta.ca", "ece421grp7", "Afbgt7oE", "ece421grp7", 13010)

    s = XMLRPC::Server.new(port, "localhost", 10, "srv.log")
    s.add_handler("manager", self)
    s.serve
  end

  def connect(player_name, ip_addr, port)

    s = XMLRPC::Client.new(ip_addr, "/", port)
    @clients[player_name] = s.proxy("client")

    # TODO - Ensure player DNE
    # TODO - If not connected, throws ERRNO:ECONNREFUSED

    return [true, "Connection established"]
  end

  def join(gid, pid)
    return false if !@games.has_key?(gid)

    @games[gid].add_player(pid)
    return true
  end

  def create(gid, pid, type)
    return join(gid,pid) if @games.has_key?(gid)

    @games[gid] = ModelController.new(gid, type)
    @games[gid].subscribe(self)
    @games[gid].add_player(pid)
    return 0
  end

  def players(gid)
    return @games[gid].game.players
  end

  def whos_turn(gid)
    return @games[gid].game.players[@games[gid].game.turn]
  end

  def current_state(gid)
    return @games[gid].get_state
  end

  def player_info(gid, pid)
    return @games[gid].get_player_info(pid)
  end

  def column_press(gid, pid, col, value)
    success, msg = @games[gid].column_press(pid, col, value)
    @clients[pid].message(msg)
    return success
  end

  def update_value(x,y,v,gid)
    @games[gid].game.players.each{ |p|
      @clients[p].message("#{x}, #{y}, #{v}")
      @clients[p].update_value(x,y,v)
    }
  end

  def game_over(message,gid)
    @games[gid].game.players.each{
      |p| @clients[p].game_over(message)
    }
  end

  def save(gid, pid)
    if @save.save_game(gid, @games[gid].game.board, @games[gid].game.turn)
      game_over("Game '#{gid}' has been saved and can be resumed at a later time", gid)
    else
      @clients[pid].message("Save with gameID already exists!")
    end
  end

end
