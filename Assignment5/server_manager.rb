require 'xmlrpc/server'
require 'xmlrpc/client'
require './model_controller'
require './abstract_listener'
require './game_save'
require './computerized_opponent'


class ServerManager < AbstractListener

  attr_accessor :games, :clients

  def initialize(port)
    @games = Hash.new
    @clients = Hash.new
    #@save = GameSave.new("mysqlsrv.ece.ualberta.ca", "ece421grp7", "Afbgt7oE", "ece421grp7", 13010)

    s = XMLRPC::Server.new(port, "localhost", 10, "srv.log")
    s.add_handler("manager", self)
    s.serve
  end

  def connect(player_name, ip_addr, port)

    if (@clients.keys.include?(player_name))
      return false
    end

    s = XMLRPC::Client.new(ip_addr, "/", port)
    @clients[player_name] = s.proxy("client")

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

  def create_bot(pid, type)
    gid = SecureRandom.uuid

    @games[gid] = ModelController.new(gid, type)
    @games[gid].subscribe(self)
    @games[gid].add_player(pid)

    bot = ComputerizedOpponent.new(gid,self)
    @clients[bot.pid] = bot
    @games[gid].add_player(bot.pid)

    return gid
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
    @games[gid].game.players.each{|p| @clients[p].turn_change} if success
    return success
  end

  def update_value(x,y,v,gid)
    @games[gid].game.players.each{ |p|
      @clients[p].message("#{x}, #{y}, #{v}")
      @clients[p].update_value(x,y,v)
    }
  end

  def game_over(message,gid)
    @games[gid].game.players.each{ |p|
      @clients[p].game_over(message)
      # @clients.delete(p) if @clients[p].is_a?(ComputerizedOpponent)
    }
  end

  def disconnect(pid, gid=nil)
    game_over(pid+' has left the game', gid) if !gid.nil?
    @clients.delete(pid)
    return 0
  end

  def save(gid, pid)
    if @save.save_game(gid, @games[gid].game.board, @games[gid].game.turn)
      game_over("Game '#{gid}' has been saved and can be resumed at a later time", gid)
    else
      @clients[pid].message("Save with gameID already exists!")
    end
  end

end
